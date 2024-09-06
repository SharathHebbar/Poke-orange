Pack: ; 10000
	ld hl, wOptions
	set NO_TEXT_SCROLL, [hl]
	call InitPackBuffers
.loop
	call JoyTextDelay
	ld a, [wJumptableIndex]
	bit 7, a
	jr nz, .done
	call .RunJumptable
	call DelayFrame
	jr .loop

.done
	ld a, [wCurrPocket]
	ld [wLastPocket], a
	ld hl, wOptions
	res NO_TEXT_SCROLL, [hl]
	ret
; 10026

.RunJumptable: ; 10026
	ld a, [wJumptableIndex]
	ld hl, .Jumptable
	call Pack_GetJumptablePointer
	jp hl

; 10030

.Jumptable: ; 10030 (4:4030)

	dw .InitGFX            ;  0
	dw .InitItemsPocket    ;  1
	dw .ItemsPocketMenu    ;  2
	dw .InitBallsPocket    ;  3
	dw .BallsPocketMenu    ;  4
	dw .InitKeyItemsPocket ;  5
	dw .KeyItemsPocketMenu ;  6
	dw .InitTMHMPocket     ;  7
	dw .TMHMPocketMenu     ;  8
	dw Pack_QuitNoScript   ;  9
	dw Pack_QuitRunScript  ; 10

.InitGFX: ; 10046 (4:4046)
	xor a
	ld [hBGMapMode], a
	call Pack_InitGFX
	ld a, [wcf64]
	ld [wJumptableIndex], a
	jp Pack_InitColors

.InitItemsPocket: ; 10056 (4:4056)
	xor a
	ld [wCurrPocket], a
	call ClearPocketList
	call DrawPocketName
	call WaitBGMap_DrawPackGFX
	jp Pack_JumptableNext

.ItemsPocketMenu: ; 10067 (4:4067)
	ld hl, ItemsPocketMenuDataHeader
	call CopyMenuDataHeader
	ld a, [wItemsPocketCursor]
	ld [wMenuCursorBuffer], a
	ld a, [wItemsPocketScrollPosition]
	ld [wMenuScrollPosition], a
	call ScrollingMenu
	ld a, [wMenuScrollPosition]
	ld [wItemsPocketScrollPosition], a
	ld a, [wMenuCursorY]
	ld [wItemsPocketCursor], a
	lb bc, $7, $3
	call Pack_InterpretJoypad
	ret c
	jp .ItemBallsKey_LoadSubmenu

.InitKeyItemsPocket: ; 10094 (4:4094)
	ld a, $2
	ld [wCurrPocket], a
	call ClearPocketList
	call DrawPocketName
	call WaitBGMap_DrawPackGFX
	jp Pack_JumptableNext

.KeyItemsPocketMenu: ; 100a6 (4:40a6)
	ld hl, KeyItemsPocketMenuDataHeader
	call CopyMenuDataHeader
	ld a, [wKeyItemsPocketCursor]
	ld [wMenuCursorBuffer], a
	ld a, [wKeyItemsPocketScrollPosition]
	ld [wMenuScrollPosition], a
	call ScrollingMenu
	ld a, [wMenuScrollPosition]
	ld [wKeyItemsPocketScrollPosition], a
	ld a, [wMenuCursorY]
	ld [wKeyItemsPocketCursor], a
	lb bc, $3, $7
	call Pack_InterpretJoypad
	ret c
	jp .ItemBallsKey_LoadSubmenu

.InitTMHMPocket: ; 100d3 (4:40d3)
	ld a, $3
	ld [wCurrPocket], a
	call ClearPocketList
	call DrawPocketName
	xor a
	ld [hBGMapMode], a
	call WaitBGMap_DrawPackGFX
	jp Pack_JumptableNext

.TMHMPocketMenu: ; 100e8 (4:40e8)
	farcall TMHMPocket
	lb bc, $5, $1
	call Pack_InterpretJoypad
	ret c
	farcall _CheckTossableItem
	ld a, [wItemAttributeParamBuffer]
	and a
	jr nz, .use_quit
	ld hl, .MenuDataHeader2
	ld de, .Jumptable2
	jr .load_jump

.use_quit
	ld hl, .MenuDataHeader1
	ld de, .Jumptable1
.load_jump
	push de
	call LoadMenuDataHeader
	call VerticalMenu
	call ExitMenu
	pop hl
	ret c
	ld a, [wMenuCursorY]
	dec a
	call Pack_GetJumptablePointer
	jp hl

; 10124 (4:4124)
.MenuDataHeader1: ; 0x10124
	db $40 ; flags
	db 07, 13 ; start coords
	db 11, 19 ; end coords
	dw .MenuData2_1
	db 1 ; default option
; 0x1012c

.MenuData2_1: ; 0x1012c
	db $c0 ; flags
	db 2 ; items
	db "USE@"
	db "QUIT@"
; 0x10137

.Jumptable1: ; 10137

	dw .UseItem
	dw QuitItemSubmenu

; 1013b

.MenuDataHeader2: ; 0x1013b
	db $40 ; flags
	db 05, 13 ; start coords
	db 11, 19 ; end coords
	dw .MenuData2_2
	db 1 ; default option
; 0x10143

.MenuData2_2: ; 0x10143
	db $c0 ; flags
	db 3 ; items
	db "USE@"
	db "GIVE@"
	db "QUIT@"
; 0x10153

.Jumptable2: ; 10153
	dw .UseItem
	dw GiveItem
	dw QuitItemSubmenu
; 10159

.UseItem: ; 10159
	farcall AskTeachTMHM
	ret c
	farcall ChooseMonToLearnTMHM
	jr c, .declined
	ld hl, wOptions
	ld a, [hl]
	push af
	res NO_TEXT_SCROLL, [hl]
	; TODO - LD B with which party Pokémon we're actually looking at
	ld a, [wCurPartyMon]
	ld b, a
	farcall TeachTMHM
	pop af
	ld [wOptions], a
.declined
	xor a
	ld [hBGMapMode], a
	call Pack_InitGFX
	call WaitBGMap_DrawPackGFX
	jp Pack_InitColors

.InitBallsPocket: ; 10186 (4:4186)
	ld a, $1
	ld [wCurrPocket], a
	call ClearPocketList
	call DrawPocketName
	call WaitBGMap_DrawPackGFX
	jp Pack_JumptableNext

.BallsPocketMenu: ; 10198 (4:4198)
	ld hl, BallsPocketMenuDataHeader
	call CopyMenuDataHeader
	ld a, [wBallsPocketCursor]
	ld [wMenuCursorBuffer], a
	ld a, [wBallsPocketScrollPosition]
	ld [wMenuScrollPosition], a
	call ScrollingMenu
	ld a, [wMenuScrollPosition]
	ld [wBallsPocketScrollPosition], a
	ld a, [wMenuCursorY]
	ld [wBallsPocketCursor], a
	lb bc, $1, $5
	call Pack_InterpretJoypad
	ret c
	; fallthrough

.ItemBallsKey_LoadSubmenu: ; 101c5 (4:41c5)
	farcall _CheckTossableItem
	ld a, [wItemAttributeParamBuffer]
	and a
	jr nz, .tossable
	farcall CheckSelectableItem
	ld a, [wItemAttributeParamBuffer]
	and a
	jr nz, .selectable
	farcall CheckItemMenu
	ld a, [wItemAttributeParamBuffer]
	and a
	jr nz, .usable
	jr .unusable

.selectable
	farcall CheckItemMenu
	ld a, [wItemAttributeParamBuffer]
	and a
	jr nz, .selectable_usable
	jr .selectable_unusable

.tossable
	farcall CheckSelectableItem
	ld a, [wItemAttributeParamBuffer]
	and a
	jr nz, .tossable_selectable
	jr .tossable_unselectable

.usable
	ld hl, MenuDataHeader_UsableKeyItem
	ld de, Jumptable_UseGiveTossRegisterQuit
	jr .build_menu

.selectable_usable
	ld hl, MenuDataHeader_UsableItem
	ld de, Jumptable_UseGiveTossQuit
	jr .build_menu

.tossable_selectable
	ld hl, MenuDataHeader_UnusableItem
	ld de, Jumptable_UseQuit
	jr .build_menu

.tossable_unselectable
	ld hl, MenuDataHeader_UnusableKeyItem
	ld de, Jumptable_UseRegisterQuit
	jr .build_menu

.unusable
	ld hl, MenuDataHeader_HoldableKeyItem
	ld de, Jumptable_GiveTossRegisterQuit
	jr .build_menu

.selectable_unusable
	ld hl, MenuDataHeader_HoldableItem
	ld de, Jumptable_GiveTossQuit
.build_menu
	push de
	call LoadMenuDataHeader
	call VerticalMenu
	call ExitMenu
	pop hl
	ret c
	ld a, [wMenuCursorY]
	dec a
	call Pack_GetJumptablePointer
	jp hl

; 10249 (4:4249)
MenuDataHeader_UsableKeyItem: ; 0x10249
	db $40 ; flags
	db 01, 13 ; start coords
	db 11, 19 ; end coords
	dw .MenuData2
	db 1 ; default option
; 0x10251

.MenuData2: ; 0x10251
	db $c0 ; flags
	db 5 ; items
	db "USE@"
	db "GIVE@"
	db "TOSS@"
	db "SEL@"
	db "QUIT@"
; 0x1026a

Jumptable_UseGiveTossRegisterQuit: ; 1026a

	dw UseItem
	dw GiveItem
	dw TossMenu
	dw RegisterItem
	dw QuitItemSubmenu
; 10274

MenuDataHeader_UsableItem: ; 0x10274
	db $40 ; flags
	db 03, 13 ; start coords
	db 11, 19 ; end coords
	dw .MenuData2
	db 1 ; default option
; 0x1027c

.MenuData2: ; 0x1027c
	db $c0 ; flags
	db 4 ; items
	db "USE@"
	db "GIVE@"
	db "TOSS@"
	db "QUIT@"
; 0x10291

Jumptable_UseGiveTossQuit: ; 10291

	dw UseItem
	dw GiveItem
	dw TossMenu
	dw QuitItemSubmenu
; 10299

MenuDataHeader_UnusableItem: ; 0x10299
	db %01000000 ; flags
	db 07, 13 ; start coords
	db 11, 19 ; end coords
	dw .MenuData2
	db 1 ; default option
; 0x102a1

.MenuData2: ; 0x102a1
	db $c0 ; flags
	db 2 ; items
	db "USE@"
	db "QUIT@"
; 0x102ac

Jumptable_UseQuit: ; 102ac

	dw UseItem
	dw QuitItemSubmenu
; 102b0

MenuDataHeader_UnusableKeyItem: ; 0x102b0
	db %01000000 ; flags
	db 05, 13 ; start coords
	db 11, 19 ; end coords
	dw .MenuData2
	db 1 ; default option
; 0x102b8

.MenuData2: ; 0x102b8
	db $c0 ; flags
	db 3 ; items
	db "USE@"
	db "SEL@"
	db "QUIT@"
; 0x102c7

Jumptable_UseRegisterQuit: ; 102c7

	dw UseItem
	dw RegisterItem
	dw QuitItemSubmenu
; 102cd

MenuDataHeader_HoldableKeyItem: ; 0x102cd
	db $40 ; flags
	db 03, 13 ; start coords
	db 11, 19 ; end coords
	dw .MenuData2
	db 1 ; default option
; 0x102d5

.MenuData2: ; 0x102d5
	db $c0 ; flags
	db 4 ; items
	db "GIVE@"
	db "TOSS@"
	db "SEL@"
	db "QUIT@"
; 0x102ea

Jumptable_GiveTossRegisterQuit: ; 102ea

	dw GiveItem
	dw TossMenu
	dw RegisterItem
	dw QuitItemSubmenu
; 102f2

MenuDataHeader_HoldableItem: ; 0x102f2
	db $40 ; flags
	db 05, 13 ; start coords
	db 11, 19 ; end coords
	dw .MenuData2
	db 1 ; default option
; 0x102fa

.MenuData2: ; 0x102fa
	db $c0 ; flags
	db 3 ; items
	db "GIVE@"
	db "TOSS@"
	db "QUIT@"
; 0x1030b

Jumptable_GiveTossQuit: ; 1030b

	dw GiveItem
	dw TossMenu
	dw QuitItemSubmenu

; 10311

UseItem: ; 10311
	farcall CheckItemMenu
	ld a, [wItemAttributeParamBuffer]
	ld hl, .dw
	rst JumpTable
	ret
; 1031f

.dw ; 1031f (4:431f)

	dw .Oak
	dw .Oak
	dw .Oak
	dw .Oak
	dw .Current
	dw .Party
	dw .Field
; 1035c

.Oak: ; 1032d (4:432d)
	ld hl, Text_ThisIsntTheTime
	jp Pack_PrintTextNoScroll

.Current: ; 10334 (4:4334)
	jp DoItemEffect

.Party: ; 10338 (4:4338)
	ld a, [PartyCount]
	and a
	jr z, .NoPokemon
	call DoItemEffect
	xor a
	ld [hBGMapMode], a
	call Pack_InitGFX
	call WaitBGMap_DrawPackGFX
	jp Pack_InitColors

.NoPokemon:
	ld hl, TextJump_YouDontHaveAPkmn
	jp Pack_PrintTextNoScroll

.Field: ; 10355 (4:4355)
	call DoItemEffect
	ld a, [wItemEffectSucceeded]
	and a
	jr z, .Oak
	ld a, $a
	ld [wJumptableIndex], a
QuitItemSubmenu: ; no-optimize stub function
	ret
; 10364 (4:4364)

TossMenu: ; 10364
	ld hl, Text_ThrowAwayHowMany
	call Pack_PrintTextNoScroll
	farcall SelectQuantityToToss
	push af
	call ExitMenu
	pop af
	ret c
	call Pack_GetItemName
	ld hl, Text_ConfirmThrowAway
	call MenuTextBox
	call YesNoBox
	push af
	call ExitMenu
	pop af
	ret c
	ld hl, NumItems
	ld a, [CurItemQuantity]
	call TossItem
	call Pack_GetItemName
	ld hl, Text_ThrewAway
	jp Pack_PrintTextNoScroll
; 1039d

RegisterItem: ; 103c2
	farcall CheckSelectableItem
	ld a, [wItemAttributeParamBuffer]
	and a
	jr nz, .cant_register
	ld a, [wCurrPocket]
	rrca
	rrca
	and $c0
	ld b, a
	ld a, [CurItemQuantity]
	inc a
	and $3f
	or b
	ld [WhichRegisteredItem], a
	ld a, [wCurItem]
	ld [RegisteredItem], a
	call Pack_GetItemName
	ld de, SFX_FULL_HEAL
	call WaitPlaySFX
	ld hl, Text_RegisteredItem
	jp Pack_PrintTextNoScroll

.cant_register
	ld hl, Text_CantRegister
	jp Pack_PrintTextNoScroll
; 103fd

GiveItem: ; 103fd
	ld a, [PartyCount]
	and a
	jp z, .NoPokemon
	ld a, [wOptions]
	push af
	res NO_TEXT_SCROLL, a
	ld [wOptions], a
	ld a, $8
	ld [PartyMenuActionText], a
	call ClearBGPalettes
	farcall LoadPartyMenuGFX
	farcall InitPartyMenuWithCancel
	farcall InitPartyMenuGFX
.loop
	farcall WritePartyMenuTilemap
	farcall PrintPartyMenuText
	call WaitBGMap
	call SetPalettes
	call DelayFrame
	farcall PartyMenuSelect
	jr c, .finish
	ld a, [CurPartySpecies]
	cp EGG
	jr nz, .give
	ld hl, .Egg
	call PrintText
	jr .loop

.give
	ld a, [wJumptableIndex]
	push af
	ld a, [wcf64]
	push af
	call GetCurNick
	ld hl, StringBuffer1
	ld de, wMonOrItemNameBuffer
	ld bc, PKMN_NAME_LENGTH
	call CopyBytes
	call TryGiveItemToPartymon
	pop af
	ld [wcf64], a
	pop af
	ld [wJumptableIndex], a
.finish
	pop af
	ld [wOptions], a
	xor a
	ld [hBGMapMode], a
	call Pack_InitGFX
	call WaitBGMap_DrawPackGFX
	jp Pack_InitColors

.NoPokemon: ; 10486 (4:4486)
	ld hl, TextJump_YouDontHaveAPkmn
	jp Pack_PrintTextNoScroll
; 1048d (4:448d)
.Egg: ; 0x1048d
	; An EGG can't hold an item.
	text_jump Text_AnEGGCantHoldAnItem
	db "@"
; 0x10492

BattlePack: ; 10493
	ld hl, wOptions
	set NO_TEXT_SCROLL, [hl]
	call InitPackBuffers
.loop
	call JoyTextDelay
	ld a, [wJumptableIndex]
	bit 7, a
	jr nz, .end
	call .RunJumptable
	call DelayFrame
	jr .loop

.end
	ld a, [wCurrPocket]
	ld [wLastPocket], a
	ld hl, wOptions
	res NO_TEXT_SCROLL, [hl]
	ret
; 104b9

.RunJumptable: ; 104b9
	ld a, [wJumptableIndex]
	ld hl, .Jumptable
	call Pack_GetJumptablePointer
	jp hl

; 104c3

.Jumptable: ; 104c3 (4:44c3)

	dw .InitGFX            ;  0
	dw .InitItemsPocket    ;  1
	dw .ItemsPocketMenu    ;  2
	dw .InitBallsPocket    ;  3
	dw .BallsPocketMenu    ;  4
	dw .InitKeyItemsPocket ;  5
	dw .KeyItemsPocketMenu ;  6
	dw .InitTMHMPocket     ;  7
	dw .TMHMPocketMenu     ;  8
	dw Pack_QuitNoScript   ;  9
	dw Pack_QuitRunScript  ; 10

.InitGFX: ; 104d9 (4:44d9)
	xor a
	ld [hBGMapMode], a
	call Pack_InitGFX
	ld a, [wcf64]
	ld [wJumptableIndex], a
	jp Pack_InitColors

.InitItemsPocket: ; 104e9 (4:44e9)
	xor a
	ld [wCurrPocket], a
	call ClearPocketList
	call DrawPocketName
	call WaitBGMap_DrawPackGFX
	jp Pack_JumptableNext

.ItemsPocketMenu: ; 104fa (4:44fa)
	ld hl, ItemsPocketMenuDataHeader
	call CopyMenuDataHeader
	ld a, [wItemsPocketCursor]
	ld [wMenuCursorBuffer], a
	ld a, [wItemsPocketScrollPosition]
	ld [wMenuScrollPosition], a
	call ScrollingMenu
	ld a, [wMenuScrollPosition]
	ld [wItemsPocketScrollPosition], a
	ld a, [wMenuCursorY]
	ld [wItemsPocketCursor], a
	lb bc, $7, $3
	call Pack_InterpretJoypad
	ret c
	jp ItemSubmenu

.InitKeyItemsPocket: ; 10527 (4:4527)
	ld a, $2
	ld [wCurrPocket], a
	call ClearPocketList
	call DrawPocketName
	call WaitBGMap_DrawPackGFX
	jp Pack_JumptableNext

.KeyItemsPocketMenu: ; 10539 (4:4539)
	ld hl, KeyItemsPocketMenuDataHeader
	call CopyMenuDataHeader
	ld a, [wKeyItemsPocketCursor]
	ld [wMenuCursorBuffer], a
	ld a, [wKeyItemsPocketScrollPosition]
	ld [wMenuScrollPosition], a
	call ScrollingMenu
	ld a, [wMenuScrollPosition]
	ld [wKeyItemsPocketScrollPosition], a
	ld a, [wMenuCursorY]
	ld [wKeyItemsPocketCursor], a
	lb bc, $3, $7
	call Pack_InterpretJoypad
	ret c
	jp ItemSubmenu

.InitTMHMPocket: ; 10566 (4:4566)
	ld a, $3
	ld [wCurrPocket], a
	call ClearPocketList
	call DrawPocketName
	xor a
	ld [hBGMapMode], a
	call WaitBGMap_DrawPackGFX
	ld hl, Text_PackEmptyString
	call Pack_PrintTextNoScroll
	jp Pack_JumptableNext

.TMHMPocketMenu: ; 10581 (4:4581)
	farcall TMHMPocket
	lb bc, $5, $1
	call Pack_InterpretJoypad
	ret c
	xor a
	jp TMHMSubmenu

.InitBallsPocket: ; 10594 (4:4594)
	ld a, $1
	ld [wCurrPocket], a
	call ClearPocketList
	call DrawPocketName
	call WaitBGMap_DrawPackGFX
	jp Pack_JumptableNext

.BallsPocketMenu: ; 105a6 (4:45a6)
	ld hl, BallsPocketMenuDataHeader
	call CopyMenuDataHeader
	ld a, [wBallsPocketCursor]
	ld [wMenuCursorBuffer], a
	ld a, [wBallsPocketScrollPosition]
	ld [wMenuScrollPosition], a
	call ScrollingMenu
	ld a, [wMenuScrollPosition]
	ld [wBallsPocketScrollPosition], a
	ld a, [wMenuCursorY]
	ld [wBallsPocketCursor], a
	lb bc, $1, $5
	call Pack_InterpretJoypad
	ret c
	; fallthrough

ItemSubmenu: ; 105d3 (4:45d3)
	farcall CheckItemContext
	ld a, [wItemAttributeParamBuffer]
TMHMSubmenu: ; 105dc (4:45dc)
	and a
	jr z, .NoUse
	ld hl, .UsableMenuDataHeader
	ld de, .UsableJumptable
	jr .proceed

.NoUse:
	ld hl, .UnusableMenuDataHeader
	ld de, .UnusableJumptable
.proceed
	push de
	call LoadMenuDataHeader
	call VerticalMenu
	call ExitMenu
	pop hl
	ret c
	ld a, [wMenuCursorY]
	dec a
	call Pack_GetJumptablePointer
	jp hl

; 10601 (4:4601)
.UsableMenuDataHeader: ; 0x10601
	db $40 ; flags
	db 07, 13 ; start coords
	db 11, 19 ; end coords
	dw .UsableMenuData2
	db 1 ; default option
; 0x10609

.UsableMenuData2: ; 0x10609
	db $c0 ; flags
	db 2 ; items
	db "USE@"
	db "QUIT@"
; 0x10614

.UsableJumptable: ; 10614

	dw .Use
	dw QuitItemSubmenu
; 10618

.UnusableMenuDataHeader: ; 0x10618
	db $40 ; flags
	db 09, 13 ; start coords
	db 11, 19 ; end coords
	dw .UnusableMenuData2
	db 1 ; default option
; 0x10620

.UnusableMenuData2: ; 0x10620
	db $c0 ; flags
	db 1 ; items
	db "QUIT@"
; 0x10627

.UnusableJumptable: ; 10627

	dw QuitItemSubmenu
; 10629

.Use: ; 10629
	farcall CheckItemContext
	ld a, [wItemAttributeParamBuffer]
	ld hl, .ItemFunctionJumptable
	rst JumpTable
	ret

.ItemFunctionJumptable: ; 10637 (4:4637)

	dw .Oak
	dw .Oak
	dw .Oak
	dw .Oak
	dw .Unused
	dw .BattleField
	dw .BattleOnly

.Oak: ; 10645 (4:4645)
	ld hl, Text_ThisIsntTheTime
	jp Pack_PrintTextNoScroll

.Unused: ; 1064c (4:464c)
	call DoItemEffect
	ld a, [wItemEffectSucceeded]
	and a
	jr nz, .ReturnToBattle
	ret

.BattleField: ; 10656 (4:4656)
	call DoItemEffect
	ld a, [wItemEffectSucceeded]
	and a
	jr nz, .quit_run_script
	xor a
	ld [hBGMapMode], a
	call Pack_InitGFX
	call WaitBGMap_DrawPackGFX
	jp Pack_InitColors

.ReturnToBattle: ; 1066c (4:466c)
	call ClearBGPalettes
	jr .quit_run_script

.BattleOnly: ; 10671 (4:4671)
	call DoItemEffect
	ld a, [wItemEffectSucceeded]
	and a
	jr z, .Oak
	cp $2
	jr z, .didnt_use_item
.quit_run_script ; 1067e (4:467e)
	ld a, 10
	ld [wJumptableIndex], a
	ret

.didnt_use_item ; 10684 (4:4684)
	xor a
	ld [wItemEffectSucceeded], a
	ret
; 1068a

InitPackBuffers: ; 1068a
	xor a
	ld [wJumptableIndex], a
	ld a, [wLastPocket]
	and $3
	ld [wCurrPocket], a
	inc a
	add a
	dec a
	ld [wcf64], a
	xor a
	ld [wcf66], a
	xor a
	ld [wSwitchItem], a
	ret
; 106a5

DepositSellInitPackBuffers: ; 106a5
	xor a
	ld [hBGMapMode], a
	ld [wJumptableIndex], a
	ld [wcf64], a
	ld [wCurrPocket], a
	ld [wcf66], a
	ld [wSwitchItem], a
	call Pack_InitGFX
	jp Pack_InitColors
; 106be

DepositSellPack: ; 106be
.loop
	call .RunJumptable
	call DepositSell_InterpretJoypad
	jr c, .loop
	ret
; 106c7

.RunJumptable: ; 106c7
	ld a, [wJumptableIndex]
	ld hl, .Jumptable
	call Pack_GetJumptablePointer
	jp hl

; 106d1

.Jumptable: ; 106d1 (4:46d1)

	dw .ItemsPocket
	dw .BallsPocket
	dw .KeyItemsPocket
	dw .TMHMPocket
.ItemsPocket: ; 106d9 (4:46d9)
	xor a
	call InitPocket
	ld hl, PC_Mart_ItemsPocketMenuDataHeader
	call CopyMenuDataHeader
	ld a, [wItemsPocketCursor]
	ld [wMenuCursorBuffer], a
	ld a, [wItemsPocketScrollPosition]
	ld [wMenuScrollPosition], a
	call ScrollingMenu
	ld a, [wMenuScrollPosition]
	ld [wItemsPocketScrollPosition], a
	ld a, [wMenuCursorY]
	ld [wItemsPocketCursor], a
	ret

.KeyItemsPocket: ; 106ff (4:46ff)
	ld a, 2
	call InitPocket
	ld hl, PC_Mart_KeyItemsPocketMenuDataHeader
	call CopyMenuDataHeader
	ld a, [wKeyItemsPocketCursor]
	ld [wMenuCursorBuffer], a
	ld a, [wKeyItemsPocketScrollPosition]
	ld [wMenuScrollPosition], a
	call ScrollingMenu
	ld a, [wMenuScrollPosition]
	ld [wKeyItemsPocketScrollPosition], a
	ld a, [wMenuCursorY]
	ld [wKeyItemsPocketCursor], a
	ret

.TMHMPocket: ; 10726 (4:4726)
	ld a, 3
	call InitPocket
	call WaitBGMap_DrawPackGFX
	farcall TMHMPocket
	ld a, [wCurItem]
	ret

.BallsPocket: ; 1073b (4:473b)
	ld a, 1
	call InitPocket
	ld hl, PC_Mart_BallsPocketMenuDataHeader
	call CopyMenuDataHeader
	ld a, [wBallsPocketCursor]
	ld [wMenuCursorBuffer], a
	ld a, [wBallsPocketScrollPosition]
	ld [wMenuScrollPosition], a
	call ScrollingMenu
	ld a, [wMenuScrollPosition]
	ld [wBallsPocketScrollPosition], a
	ld a, [wMenuCursorY]
	ld [wBallsPocketCursor], a
	ret

InitPocket: ; 10762 (4:4762)
	ld [wCurrPocket], a
	call ClearPocketList
	call DrawPocketName
	jp WaitBGMap_DrawPackGFX

DepositSell_InterpretJoypad: ; 1076f
	ld hl, wMenuJoypad
	ld a, [hl]
	and A_BUTTON
	jr nz, .a_button
	ld a, [hl]
	and B_BUTTON
	jr nz, .b_button
	ld a, [hl]
	and D_LEFT
	jr nz, .d_left
	ld a, [hl]
	and D_RIGHT
	jr nz, .d_right
	scf
	ret

.a_button
	ld a, TRUE
	ld [wcf66], a
	and a
	ret

.b_button
	xor a
	ld [wcf66], a
	and a
	ret

.d_left
	ld a, [wJumptableIndex]
	dec a
	and $3
	ld [wJumptableIndex], a
	push de
	ld de, SFX_SWITCH_POCKETS
	call PlaySFX
	pop de
	scf
	ret

.d_right
	ld a, [wJumptableIndex]
	inc a
	and $3
	ld [wJumptableIndex], a
	push de
	ld de, SFX_SWITCH_POCKETS
	call PlaySFX
	pop de
	scf
	ret
; 107bb

Pack_JumptableNext: ; 10866 (4:4866)
	ld hl, wJumptableIndex
	inc [hl]
	ret

Pack_GetJumptablePointer: ; 1086b
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret
; 10874

Pack_QuitNoScript: ; 10874 (4:4874)
	ld hl, wJumptableIndex
	set 7, [hl]
	xor a
	ld [wcf66], a
	ret

Pack_QuitRunScript: ; 1087e (4:487e)
	ld hl, wJumptableIndex
	set 7, [hl]
	ld a, TRUE
	ld [wcf66], a
	ret

Pack_PrintTextNoScroll: ; 10889 (4:4889)
	ld a, [wOptions]
	push af
	set NO_TEXT_SCROLL, a
	ld [wOptions], a
	call PrintText
	pop af
	ld [wOptions], a
	ret

WaitBGMap_DrawPackGFX: ; 1089a (4:489a)
	call WaitBGMap
DrawPackGFX: ; 1089d
	ld a, [wCurrPocket]
	and $3
	ld e, a
	ld d, $0
	ld hl, PackGFXPointers
	ld a, [PlayerGender]
	bit 0, a
	jr z, .male
	ld hl, PackFGFXPointers
.male
	add hl, de
	add hl, de
	ld a, [hli]
	ld e, a
	ld d, [hl]
	ld hl, VTiles2 tile $50
	lb bc, BANK(PackGFX), 15 ; BANK(PackFGFX), 15
	jp Request2bpp
; 108cc

PackGFXPointers: ; 108cc
	dw PackGFX + (15 tiles) * 1
	dw PackGFX + (15 tiles) * 3
	dw PackGFX + (15 tiles) * 0
	dw PackGFX + (15 tiles) * 2
; 108d4

PackFGFXPointers: ; 48e93
	dw PackFGFX + (15 tiles) * 1
	dw PackFGFX + (15 tiles) * 3
	dw PackFGFX + (15 tiles) * 0
	dw PackFGFX + (15 tiles) * 2

Pack_InterpretJoypad: ; 108d4 (4:48d4)
	ld hl, wMenuJoypad
	ld a, [wSwitchItem]
	and a
	jr nz, .switching_item
	ld a, [hl]
	and A_BUTTON
	jr nz, .a_button
	ld a, [hl]
	and B_BUTTON
	jr nz, .b_button
	ld a, [hl]
	and D_LEFT
	jr nz, .d_left
	ld a, [hl]
	and D_RIGHT
	jr nz, .d_right
	ld a, [hl]
	and SELECT
	jr nz, .select
	scf
	ret

.a_button
	and a
	ret

.b_button
	ld a, 9
	ld [wJumptableIndex], a
	scf
	ret

.d_left
	ld a, b
	ld [wJumptableIndex], a
	ld [wcf64], a
	push de
	ld de, SFX_SWITCH_POCKETS
	call PlaySFX
	pop de
	scf
	ret

.d_right
	ld a, c
	ld [wJumptableIndex], a
	ld [wcf64], a
	push de
	ld de, SFX_SWITCH_POCKETS
	call PlaySFX
	pop de
	scf
	ret

.select
	farcall SwitchItemsInBag
	ld hl, Text_MoveItemWhere
	call Pack_PrintTextNoScroll
	scf
	ret

.switching_item
	ld a, [hl]
	and A_BUTTON | SELECT
	jr nz, .place_insert
	ld a, [hl]
	and B_BUTTON
	jr nz, .end_switch
	scf
	ret

.place_insert
	farcall SwitchItemsInBag
	ld de, SFX_SWITCH_POKEMON
	call WaitPlaySFX
	ld de, SFX_SWITCH_POKEMON
	call WaitPlaySFX
.end_switch
	xor a
	ld [wSwitchItem], a
	scf
	ret

Pack_InitGFX: ; 10955
	call ClearBGPalettes
	call ClearTileMap
	call ClearSprites
	call DisableLCD
	ld hl, PackMenuGFX
	ld de, VTiles2
	ld bc, $60 tiles
	ld a, BANK(PackMenuGFX)
	call FarCopyBytes
; Background (blue if male, pink if female)
	hlcoord 0, 1
	ld bc, 11 * SCREEN_WIDTH
	ld a, $24
	call ByteFill
; This is where the items themselves will be listed.
	hlcoord 5, 1
	lb bc, 11, 15
	call ClearBox
; ◀▶ POCKET       ▼▲ ITEMS
	hlcoord 0, 0
	ld a, $28
	ld c, SCREEN_WIDTH
.loop
	ld [hli], a
	inc a
	dec c
	jr nz, .loop
	call DrawPocketName
	call PlacePackGFX
; Place the textbox for displaying the item description
	hlcoord 0, SCREEN_HEIGHT - 4 - 2
	lb bc, 4, SCREEN_WIDTH - 2
	call TextBox
	call EnableLCD
	jp DrawPackGFX
; 109a5

PlacePackGFX: ; 109a5
	hlcoord 0, 3
	ld a, $50
	ld de, SCREEN_WIDTH - 5
	ld b, 3
.row
	ld c, 5
.column
	ld [hli], a
	inc a
	dec c
	jr nz, .column
	add hl, de
	dec b
	jr nz, .row
	ret
; 109bb

DrawPocketName: ; 109bb
	ld a, [wCurrPocket]
	; * 15
	ld d, a
	swap a
	sub d
	ld d, 0
	ld e, a
	ld hl, .tilemap
	add hl, de
	ld d, h
	ld e, l
	hlcoord 0, 7
	ld c, 3
.row
	ld b, 5
.col
	ld a, [de]
	inc de
	ld [hli], a
	dec b
	jr nz, .col
	ld a, c
	ld c, SCREEN_WIDTH - 5
	add hl, bc
	ld c, a
	dec c
	jr nz, .row
	ret
; 109e1

.tilemap ; 109e1
	db $00, $04, $04, $04, $01 ; top border
	db $06, $07, $08, $09, $0a ; Items
	db $02, $05, $05, $05, $03 ; bottom border
	db $00, $04, $04, $04, $01 ; top border
	db $15, $16, $17, $18, $19 ; Balls
	db $02, $05, $05, $05, $03 ; bottom border
	db $00, $04, $04, $04, $01 ; top border
	db $0b, $0c, $0d, $0e, $0f ; Key Items
	db $02, $05, $05, $05, $03 ; bottom border
	db $00, $04, $04, $04, $01 ; top border
	db $10, $11, $12, $13, $14 ; TM/HM
	db $02, $05, $05, $05, $03 ; bottom border
; 10a1d

Pack_GetItemName: ; 10a1d
	ld a, [wCurItem]
	ld [wNamedObjectIndexBuffer], a
	call GetItemName
	jp CopyName1
; 10a2a

ClearPocketList: ; 10a36 (4:4a36)
	hlcoord 5, 2
	lb bc, 10, SCREEN_WIDTH - 5
	jp ClearBox

Pack_InitColors: ; 10a40
	call WaitBGMap
	ld b, SCGB_PACK_PALS
	call GetSGBLayout
	call SetPalettes
	jp DelayFrame
; 10a4f

ItemsPocketMenuDataHeader: ; 0x10a4f
	db $40 ; flags
	db 01, 07 ; start coords
	db 11, 19 ; end coords
	dw .MenuData2
	db 1 ; default option
; 0x10a57

.MenuData2: ; 0x10a57
	db $ae ; flags
	db 5, 8 ; rows, columns
	db 2 ; horizontal spacing
	dbw 0, NumItems
	dba PlaceMenuItemName
	dba PlaceMenuItemQuantity
	dba UpdateItemDescription
; 10a67

PC_Mart_ItemsPocketMenuDataHeader: ; 0x10a67
	db $40 ; flags
	db 01, 07 ; start coords
	db 11, 19 ; end coords
	dw .MenuData2
	db 1 ; default option
; 0x10a6f

.MenuData2: ; 0x10a6f
	db $2e ; flags
	db 5, 8 ; rows, columns
	db 2 ; horizontal spacing
	dbw 0, NumItems
	dba PlaceMenuItemName
	dba PlaceMenuItemQuantity
	dba UpdateItemDescription
; 10a7f

KeyItemsPocketMenuDataHeader: ; 0x10a7f
	db $40 ; flags
	db 01, 07 ; start coords
	db 11, 19 ; end coords
	dw .MenuData2
	db 1 ; default option
; 0x10a87

.MenuData2: ; 0x10a87
	db $ae ; flags
	db 5, 8 ; rows, columns
	db 1 ; horizontal spacing
	dbw 0, NumKeyItems
	dba PlaceMenuItemName
	dba PlaceMenuItemQuantity
	dba UpdateItemDescription
; 10a97

PC_Mart_KeyItemsPocketMenuDataHeader: ; 0x10a97
	db $40 ; flags
	db 01, 07 ; start coords
	db 11, 19 ; end coords
	dw .MenuData2
	db 1 ; default option
; 0x10a9f

.MenuData2: ; 0x10a9f
	db $2e ; flags
	db 5, 8 ; rows, columns
	db 1 ; horizontal spacing
	dbw 0, NumKeyItems
	dba PlaceMenuItemName
	dba PlaceMenuItemQuantity
	dba UpdateItemDescription
; 10aaf

BallsPocketMenuDataHeader: ; 0x10aaf
	db $40 ; flags
	db 01, 07 ; start coords
	db 11, 19 ; end coords
	dw .MenuData2
	db 1 ; default option
; 0x10ab7

.MenuData2: ; 0x10ab7
	db $ae ; flags
	db 5, 8 ; rows, columns
	db 2 ; horizontal spacing
	dbw 0, NumBalls
	dba PlaceMenuItemName
	dba PlaceMenuItemQuantity
	dba UpdateItemDescription
; 10ac7

PC_Mart_BallsPocketMenuDataHeader: ; 0x10ac7
	db $40 ; flags
	db 01, 07 ; start coords
	db 11, 19 ; end coords
	dw .MenuData2
	db 1 ; default option
; 0x10acf

.MenuData2: ; 0x10acf
	db $2e ; flags
	db 5, 8 ; rows, columns
	db 2 ; horizontal spacing
	dbw 0, NumBalls
	dba PlaceMenuItemName
	dba PlaceMenuItemQuantity
	dba UpdateItemDescription
; 10adf

Text_ThrowAwayHowMany: ; 0x10ae4
	; Throw away how many?
	text_jump UnknownText_0x1c0ba5
	db "@"
; 0x10ae9

Text_ConfirmThrowAway: ; 0x10ae9
	; Throw away @ @ (S)?
	text_jump UnknownText_0x1c0bbb
	db "@"
; 0x10aee

Text_ThrewAway: ; 0x10aee
	; Threw away @ (S).
	text_jump UnknownText_0x1c0bd8
	db "@"
; 0x10af3

Text_ThisIsntTheTime: ; 0x10af3
	; OAK:  ! This isn't the time to use that!
	text_jump UnknownText_0x1c0bee
	db "@"
; 0x10af8

TextJump_YouDontHaveAPkmn: ; 0x10af8
	; You don't have a #MON!
	text_jump Text_YouDontHaveAPkmn
	db "@"
; 0x10afd

Text_RegisteredItem: ; 0x10afd
	; Registered the @ .
	text_jump UnknownText_0x1c0c2e
	db "@"
; 0x10b02

Text_CantRegister: ; 0x10b02
	; You can't register that item.
	text_jump UnknownText_0x1c0c45
	db "@"
; 0x10b07

Text_MoveItemWhere: ; 0x10b07
	; Where should this be moved to?
	text_jump UnknownText_0x1c0c63
	db "@"
; 0x10b0c

Text_PackEmptyString: ; 0x10b0c
	;
	text_jump UnknownText_0x1c0c83
	db "@"
; 0x10b11

PackMenuGFX:
INCBIN "gfx/pack/pack_menu.2bpp"
PackGFX:
INCBIN "gfx/pack/pack.2bpp"
PackFGFX: ; 48e9b
INCBIN "gfx/pack/pack_f.2bpp"
