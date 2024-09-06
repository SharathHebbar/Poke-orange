; VBlank is the interrupt responsible for updating VRAM.

; In Pokemon Crystal, VBlank has been hijacked to act as the
; main loop. After time-sensitive graphics operations have been
; performed, joypad input and sound functions are executed.

; This prevents the display and audio output from lagging.


VBlank:: ; 283
	push af
	push bc
	push de
	push hl

	ld a, [hROMBank]
	ld [hROMBankBackup], a

	ld a, [hVBlank]
	cp 7
	jr z, .skipToGameTime
	and 7
	add a
	ld e, a
	ld d, 0
	ld hl, .VBlanks
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a

	call _hl_

.doGameTime
	call GameTimer

	xor a
	ld [wVBlankOccurred], a
	
	ld a, [hROMBankBackup]
	rst Bankswitch

	pop hl
	pop de
	pop bc
	pop af
	reti
; 2a1

.skipToGameTime
	ld a, [hROMBank]
	ld [hROMBankBackup], a
	ld a, [hDEDVBlankMode]
	and a
	jr z, .tryDoMapAnims
	dec a
	jr z, .doGrowlOrRoarAnim
.tryDoMapAnims
	call AnimateTileset
	jr .doGameTime

.doGrowlOrRoarAnim
	ld a, [rSVBK]
	push af
	ld a, $5
	ld [rSVBK], a

	call hPushOAM

	ld a, BANK(CopyGrowlOrRoarPals)
	call Bankswitch

	ld a, [hCGBPalUpdate]
	and a
	call nz, CopyGrowlOrRoarPals
	call RunOneFrameOfGrowlOrRoarAnim
	pop af
	ld [rSVBK], a
	jr .doGameTime

.VBlanks: ; 2a1
	dw VBlank0
	dw VBlank1
	dw VBlank2
	dw VBlank3
	dw VBlank4
	dw VBlank5
	dw VBlank6
	dw VBlank0 ; just in case
; 2b1


VBlank0:: ; 2b1
; normal operation

; rng
; scx, scy, wy, wx
; bg map buffer
; palettes
; dma transfer
; bg map
; tiles
; oam
; joypad
; sound

	ld a, [hSCX]
	ld [rSCX], a
	ld a, [hSCY]
	ld [rSCY], a
	ld a, [hWY]
	ld [rWY], a
	ld a, [hWX]
	ld [rWX], a

	; There's only time to call one of these in one vblank.
	; Calls are in order of priority.

	call UpdateBGMapBuffer
	jr c, .done
	call UpdatePalsIfCGB
	jr c, .done
	call DMATransfer
	jr c, .done
	call UpdateBGMap

	; These have their own timing checks.

	call Serve2bppRequest
	call Serve1bppRequest
	call AnimateTileset

.done

	call PushOAM


	; vblank-sensitive operations are done

	; inc frame counter
	ld hl, hVBlankCounter
	inc [hl]

	; advance random variables
	ld a, [rDIV]
	ld b, a
	ld a, [hRandomAdd]
	adc b
	ld [hRandomAdd], a

	ld a, [rDIV]
	ld b, a
	ld a, [hRandomSub]
	sbc b
	ld [hRandomSub], a

	ld a, [wOverworldDelay]
	and a
	jr z, .noDelay
	dec a
	ld [wOverworldDelay], a
.noDelay

	ld a, [wTextDelayFrames]
	and a
	jr z, .noDelay2
	dec a
	ld [wTextDelayFrames], a
.noDelay2
	call Joypad

	ld a, [hSeconds]
	ld [hSecondsBackup], a
; fallthrough

VBlank2:: ; 325
; sound only	
	ld a, BANK(_UpdateSound)
	rst Bankswitch
	jp _UpdateSound
; 337

VBlank6:: ; 436
; palettes
; tiles
; dma transfer
; sound
	; inc frame counter
	ld hl, hVBlankCounter
	inc [hl]

	call UpdateCGBPals
	jr c, VBlank2

	call Serve2bppRequest
	call Serve1bppRequest
	call DMATransfer
	jr VBlank2
	
VBlank4:: ; 3df
; bg map
; tiles
; oam
; joypad
; serial
; sound
	call UpdateBGMap
	call Serve2bppRequest
	call hPushOAM
	call Joypad
	call AskSerial
	jr VBlank2
; 400

VBlank1:: ; 337
; scx, scy
; palettes
; bg map
; tiles
; oam
; sound / lcd stat / serial
	ld a, [hSCX]
	ld [rSCX], a
	ld a, [hSCY]
	ld [rSCY], a

	call UpdatePals
	jr c, .done

	call UpdateBGMap
	call Serve2bppRequest_NoVBlankCheck

	call hPushOAM
.done

	; get requested ints
	ld a, [rIE]
	push af
	ld a, [rIF]
	push af
	xor a
	ld [rIF], a
	ld a, 1 << LCD_STAT ; lcd stat
	ld [rIE], a
	ld [rIF], a

	ei
	call VBlank2
	di

	; get requested ints
	ld a, [rIF]
	ld b, a
	; discard requested ints
	pop af
	or b
	ld b, a
	xor a
	ld [rIF], a
	; enable ints besides joypad
	pop af
	ld [rIE], a
	; rerequest ints
	ld a, b
	ld [rIF], a
	ret
; 37f


VBlank3:: ; 396
; scx, scy
; palettes
; bg map
; tiles
; oam
; sound / lcd stat
	ld a, [hSCX]
	ld [rSCX], a
	ld a, [hSCY]
	ld [rSCY], a

	ld a, [hCGBPalUpdate]
	and a
	call nz, ForceUpdateCGBPals
	jr c, .done

	call UpdateBGMap
	call Serve2bppRequest_NoVBlankCheck

	call hPushOAM
.done

	; get requested ints
	ld a, [rIE]
	push af
	ld a, [rIF]
	push af
	xor a
	ld [rIF], a
	ld a, 1 << LCD_STAT ; lcd stat
	ld [rIE], a
	ld [rIF], a

	ei
	call VBlank2
	di

	; get requested ints
	ld a, [rIF]
	ld b, a
	; discard requested ints
	pop af
	or b
	ld b, a
	xor a
	ld [rIF], a
	; enable ints besides joypad
	pop af
	ld [rIE], a
	; rerequest ints
	ld a, b
	ld [rIF], a
	ret
; 3df

VBlank5:: ; 400
; scx
; palettes
; bg map
; tiles
; joypad
	ld a, [hSCX]
	ld [rSCX], a

	call UpdatePalsIfCGB
	jr c, .done

	call UpdateBGMap
	call Serve2bppRequest
.done
	call Joypad

	xor a
	ld [rIF], a
	ld a, [rIE]
	push af
	ld a, 1 << LCD_STAT ; lcd stat
	ld [rIE], a
	; request lcd stat
	ld [rIF], a

	ei
	call VBlank2
	di

	xor a
	ld [rIF], a
	; enable ints besides joypad
	pop af
	ld [rIE], a
	ret
; 436

UpdatePals:: ; 37f
; update pals for either dmg or cgb

	ld a, [hCGB]
	and a
	jp nz, UpdateCGBPals

	; update gb pals
	ld a, [wBGP]
	ld [rBGP], a
	ld a, [wOBP0]
	ld [rOBP0], a
	ld a, [wOBP1]
	ld [rOBP1], a

	and a
	ret
; 396
