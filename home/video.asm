; Functions dealing with VRAM.

DMATransfer:: ; 15d8
; Return carry if the transfer is completed.

	ld a, [hDMATransfer]
	and a
	ret z

; Start transfer
	ld [rHDMA5], a

; Execution is halted until the transfer is complete.

	xor a
	ld [hDMATransfer], a
	scf
	ret
; 15e3

PushOAM::
	ld a, [hOAMUpdate]
	and a
	ret nz
	jp hPushOAM

UpdateBGMapBuffer:: ; 15e3
; Copy [hFFDC] 16x8 tiles from BGMapBuffer
; to bg map addresses in BGMapBufferPtrs.

; [hFFDC] must be even since this is done in pairs.

; Return carry on success.

	ld a, [hBGMapUpdate]
	and a
	ret z

	ld a, [rVBK]
	push af
	ld [hSPBuffer], sp

	ld hl, BGMapBufferPtrs
	ld sp, hl

; We can now pop the addresses of affected spots on the BG Map

	ld hl, BGMapPalBuffer
	ld de, BGMapBuffer


.next
; Copy a pair of 16x8 blocks (one 16x16 block)

rept 2
; Get our BG Map address
	pop bc

; Palettes
	ld a, 1
	ld [rVBK], a

	ld a, [hli]
	ld [bc], a
	inc c
	ld a, [hli]
	ld [bc], a
	dec c

; Tiles
	xor a
	ld [rVBK], a

	ld a, [de]
	inc de
	ld [bc], a
	inc c
	ld a, [de]
	inc de
	ld [bc], a
endr

; We've done 2 16x8 blocks
	ld a, [hFFDC]
	dec a
	dec a
	ld [hFFDC], a

	jr nz, .next


	ld a, [hSPBuffer]
	ld l, a
	ld a, [hSPBuffer + 1]
	ld h, a
	ld sp, hl

	pop af
	ld [rVBK], a

	xor a
	ld [hBGMapUpdate], a
	scf
	ret
; 163a


WaitTop:: ; 163a
; Wait until the top half of the BG Map is being updated.

	ld a, [hBGMapMode]
	and a
	ret z

	ld a, [hBGMapHalf]
	and a
	jr z, .done

	call DelayFrame
	jr WaitTop

.done
	xor a
	ld [hBGMapMode], a
	ret
; 164c


UpdateBGMap:: ; 164c
HALF_HEIGHT EQU SCREEN_HEIGHT / 2
; Update the BG Map, in halves, from TileMap and AttrMap.

	ld a, [hBGMapMode]
	and a
	ret z

; BG Map 0
	dec a ; 1
	jr z, .DoTiles
	dec a ; 2
	jr z, .DoAttributes
; BG Map 1
	ld hl, VBGMap1
	dec a
	jr z, .DoBGMap1Tiles
	dec a
	jr z, .DoBGMap1Attributes
; Update from a specific row
; does not update hBGMapHalf
	dec a
	coord bc, 0, 0
	jr z, .DoCustomSourceTiles
	dec a
	ret nz
	coord bc, 0, 0, AttrMap
	ld a, 1
	ld [rVBK], a
	call .DoCustomSourceTiles
	xor a
	ld [rVBK], a
	ret

.DoCustomSourceTiles
	ld [hSPBuffer], sp
	ld hl, 0
	ld d, h
	ld e, l
	ld a, [hBGMapHalf] ; multiply by 20 to get the tilemap offset
	and a
	jr z, .first_half
	ld l, 20
	ld e, 32
.first_half
	add hl, bc
	ld sp, hl
	; ld a, [hBGMapHalf] (a is unchanged) ; multiply by 32 to get the bg map offset
	ld a, [hBGMapAddress]
	ld l, a
	ld a, [hBGMapAddress + 1]
	ld h, a
	ld a, [hTilesPerCycle]
	add hl, de
	jr .startCustomCopy

.DoAttributes
	ld a, [hBGMapAddress + 1]
	ld h, a
	ld a, [hBGMapAddress]
	ld l, a
.DoBGMap1Attributes
	ld a, 1
	ld [rVBK], a
	call .CopyAttributes
	xor	a
	ld [rVBK], a
	ret
	
.CopyAttributes
	ld [hSPBuffer], sp
	
; Which half?
	ld a, [hBGMapHalf]
	and a ; 0
	jr z, .AttributeMapTop
; bottom row
	coord sp, 0, 9, AttrMap
	ld de, HALF_HEIGHT * BG_MAP_WIDTH
	add hl, de
; Next time: top half
	xor a
	jr .startCopy
.AttributeMapTop
	coord sp, 0, 0, AttrMap
; Next time: bottom half
	jr .AttributeMapTopContinue

.DoTiles
	ld a, [hBGMapAddress + 1]
	ld h, a
	ld a, [hBGMapAddress]
	ld l, a
	
.DoBGMap1Tiles
	ld [hSPBuffer], sp
	
; Which half?
	ld a, [hBGMapHalf]
	and a ; 0
	jr z, .TileMapTop
; bottom row
	coord sp, 0, 9
	ld de, HALF_HEIGHT * BG_MAP_WIDTH
	add hl, de
; Next time: top half
	xor a
	jr .startCopy
.TileMapTop
	coord sp, 0, 0
; Next time: bottom half
.AttributeMapTopContinue
	inc a
.startCopy
; Which half to update next time
	ld [hBGMapHalf], a
; Rows of tiles in a half
	ld a, SCREEN_HEIGHT / 2
.startCustomCopy
; Discrepancy between TileMap and BGMap
	ld bc, BG_MAP_WIDTH - (SCREEN_WIDTH - 1)
.row
; Copy a row of 20 tiles
	rept (SCREEN_WIDTH / 2) - 1
	pop de
	ld [hl], e
	inc l
	ld [hl], d
	inc l
	endr
	pop de
	ld [hl], e
	inc l
	ld [hl], d

	add hl, bc
	dec a
	jr nz, .row

	ld a, [hSPBuffer]
	ld l, a
	ld a, [hSPBuffer + 1]
	ld h, a
	ld sp, hl
	ret
; 170a

Serve1bppRequest:: ; 170a
; Only call during the first fifth of VBlank

	ld a, [hRequested1bpp]
	and a
	ret z

	ld b, a
; Back out if we're too far into VBlank
	ld a, [rLY]
	cp 144
	ret c
	cp 146
	ret nc

	xor a
	ld [hRequested1bpp], a

; Copy [hRequested1bpp] 1bpp tiles from [hRequestedVTileSource] to [hRequestedVTileDest]
	ld [hSPBuffer], sp
; Destination
	ld hl, hRequestedVTileDest
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
; Source	
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld sp, hl
	ld h, d
	ld l, e
	
; # tiles to copy
.next
	rept 4
	pop de
	ld a, e
	ld [hli], a
	ld [hli], a
	ld a, d
	ld [hli], a
	ld [hli], a
	endr
	dec b
	jr nz, .next
	jp WriteVTileSourceAndDestinationAndReturn


Serve2bppRequest_NoVBlankCheck:: ; 1778
	ld a, [hRequested2bpp]
	and a
	ret z
	ld b, a
	call _Serve2bppRequest
	xor a
	ld [hRequested2bpp], a
	ret
	
Serve2bppRequest:: ; 1769
; Only call during the first fifth of VBlank

	ld a, [hRequested2bpp]
	and a
	ret z
	ld b, a
; Back out if we're too far into VBlank
	ld a, [rLY]
	cp 144
	ret c
	cp 146
	ret nc

_Serve2bppRequest:: ; 177d
; Copy [hRequested2bpp] 2bpp tiles from [hRequestedVTileSource] to [hRequestedVTileDest]
	xor a
	ld [hRequested2bpp], a
	ld [hSPBuffer], sp
; Destination
	ld hl, hRequestedVTileDest
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
; Source	
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld sp, hl
	ld h, d
	ld l, e
	
; # tiles to copy
.next
	rept 8
	pop de
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
	endr
	dec b
	jr nz, .next

WriteVTileSourceAndDestinationAndReturn:
	ld [hRequestedVTileSource], sp	
	ld sp, hl
	ld [hRequestedVTileDest], sp

	ld a, [hSPBuffer]
	ld l, a
	ld a, [hSPBuffer + 1]
	ld h, a
	ld sp, hl
	ret
; 17d3


AnimateTileset:: ; 17d3
; Only call during the first fifth of VBlank

	ld a, [hMapAnims]
	and a
	ret z

; Back out if we're too far into VBlank
	ld a, [rLY]
	cp 144
	ret c
	cp 151
	ret nc

	ld a, [hROMBank]
	push af
	ld a, BANK(_AnimateTileset)
	rst Bankswitch

	ld a, [rSVBK]
	push af
	ld a, 1
	ld [rSVBK], a

	ld a, [rVBK]
	push af
	xor a
	ld [rVBK], a

	call _AnimateTileset

	pop af
	ld [rVBK], a
	pop af
	ld [rSVBK], a
	pop af
	rst Bankswitch
	ret
; 17ff

TransferAnimatingPicDuringHBlank::
	ld hl, wPokeAnimDestination
	ld a, [hli]
	ld d, [hl]
	ld e, a
	ld hl, wPokeAnimCoord
	ld a, [hli]
	ld h, [hl]
	ld l, a

	lb bc, 7, rSTAT & $ff
.loop
	ld a, [rLY]
	cp $90
	jr nc, .inVBlank
.waitNoHBlank
	ld a, [$ff00+c]
	and 3
	jr z, .waitNoHBlank
.waitHBlank
	ld a, [$ff00+c]
	and 3
	jr nz, .waitHBlank
.inVBlank
	rept 7
	ld a, [hli]
	ld [de], a
	inc e
	endr
	ld a, [hl]
	ld [de], a

	ld a, (BG_MAP_WIDTH - 7)
	add e
	ld e, a
	adc d
	sub e
	ld d, a
	ld a, (SCREEN_WIDTH - 7)
	add l
	ld l, a
	adc h
	sub l
	ld h, a
	dec b
	jr nz, .loop
	ret