GetEmote2bpp: ; 1412a
	ld a, $1
	ld [rVBK], a
	call Get2bpp
	xor a
	ld [rVBK], a
	ret
; 14135

_ReplaceKrisSprite:: ; 14135
	call GetPlayerSprite
	ld a, [UsedSprites]
	ld [hUsedSpriteIndex], a
	ld a, [UsedSprites + 1]
	ld [hUsedSpriteTile], a
	jp GetUsedSprite
; 14146

RefreshSprites:: ; 14168
	call .Refresh
	jp MapCallbackSprites_LoadUsedSpritesGFX
; 1416f

.Refresh: ; 1416f
	xor a
	ld bc, UsedSpritesEnd - UsedSprites
	ld hl, UsedSprites
	call ByteFill
	call GetPlayerSprite
	call AddMapSprites
	jp LoadAndSortSprites
; 14183

GetPlayerSprite: ; 14183
; Get Chris or Kris's sprite.
	ld hl, .Chris
	ld a, [wPlayerSpriteSetupFlags]
	bit 2, a
	jr nz, .go
	ld a, [PlayerGender]
	bit 0, a
	jr z, .go
	ld hl, .Kris

.go
	ld a, [PlayerState]
	ld c, a
.loop
	ld a, [hli]
	cp c
	jr z, .good
	inc hl
	cp $ff
	jr nz, .loop

; Any player state not in the array defaults to Chris's sprite.
	xor a ; ld a, PLAYER_NORMAL
	ld [PlayerState], a
	ld a, SPRITE_CHRIS
	jr .finish

.good
	ld a, [hl]

.finish
	ld [UsedSprites + 0], a
	ld [PlayerSprite], a
	ld [PlayerObjectSprite], a
	ret

.Chris:
	db PLAYER_NORMAL,    SPRITE_CHRIS
	db PLAYER_BIKE,      SPRITE_CHRIS_BIKE
	db PLAYER_SURF,      SPRITE_SURF
	db PLAYER_SURF_PIKA, SPRITE_SURFING_PIKACHU
	db PLAYER_DIVE,      SPRITE_CHRIS_DIVE
	db $ff

.Kris:
	db PLAYER_NORMAL,    SPRITE_KRIS
	db PLAYER_BIKE,      SPRITE_KRIS_BIKE
	db PLAYER_SURF,      SPRITE_SURF
	db PLAYER_SURF_PIKA, SPRITE_SURFING_PIKACHU
	db PLAYER_DIVE,      SPRITE_KRIS_DIVE
	db $ff
; 141c9


AddMapSprites: ; 141c9
	call GetMapPermission
	call CheckOutdoorMap
	jr z, .outdoor
	ld hl, Map1ObjectSprite
	ld a, NUM_OBJECTS
.loop
	dec a
	ret z
	push af
	ld a, [hl]
	call AddSpriteGFX
	ld de, OBJECT_LENGTH
	add hl, de
	pop af
	jr .loop

.outdoor ; 141ee
	ld a, [MapGroup]
	dec a
	ld c, a
	ld b, 0
	ld hl, OutdoorSprites
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
.loop2
	ld a, [hli]
	and a
	ret z
	call AddSpriteGFX
	jr .loop2
; 14209


MapCallbackSprites_LoadUsedSpritesGFX: ; 14209
	ld a, MAPCALLBACK_SPRITES
	call RunMapCallback
	call GetUsedSprites
	ld a, [wSpriteFlags]
	bit 6, a
	ret nz

	ld c, EMOTE_SHADOW
	farcall LoadEmote
	call GetMapPermission
	call CheckOutdoorMap
	jr z, .outdoor
	ld c, EMOTE_BOULDER_DUST
	farcall LoadEmote
	ret
 .outdoor
	ld c, EMOTE_0B
	farcall LoadEmote
	ld c, EMOTE_PUDDLE_SPLASH
	farcall LoadEmote
	ret
; 14236



SafeGetSprite: ; 14236
	push hl
	call GetSprite
	pop hl
	ret
; 1423c

GetSprite: ; 1423c
	call GetMonSprite
	ret c

	ld hl, SpriteHeaders ; address
	dec a
	ld c, a
	ld b, 0
	ld a, 6
	call AddNTimes
	; load the address into de
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	; load the length into c
	ld a, [hli]
	swap a
	ld c, a
	; load the sprite bank into both b and h
	ld b, [hl]
	ld a, [hli]
	; load the sprite type into l
	ld l, [hl]
	ld h, a
	ret
; 14259


GetMonSprite: ; 14259
; Return carry if a monster sprite was loaded.

	cp SPRITE_POKEMON
	jr c, .Normal
	cp SPRITE_DAYCARE_MON_1
	jr z, .wBreedMon1
	cp SPRITE_DAYCARE_MON_2
	jr z, .wBreedMon2
	cp SPRITE_VARS
	jr nc, .Variable
	jr .Icon

.Normal:
	and a
	ret

.Icon:
	sub SPRITE_POKEMON
	ld e, a
	ld d, 0
	ld hl, SpriteMons
	add hl, de
	ld a, [hl]
	jr .Mon

.wBreedMon1
	ld a, [wBreedMon1Species]
	jr .Mon

.wBreedMon2
	ld a, [wBreedMon2Species]

.Mon:
	ld e, a
	and a
	jr z, .NoBreedmon

	farcall LoadOverworldMonIcon

	lb hl, 0, MON_SPRITE
	scf
	ret

.Variable:
	sub SPRITE_VARS
	ld e, a
	ld d, 0
	ld hl, VariableSprites
	add hl, de
	ld a, [hl]
	and a
	jp nz, GetMonSprite

.NoBreedmon:
	ld a, 1
	lb hl, 0, MON_SPRITE
	and a
	ret
; 142a7


_DoesSpriteHaveFacings:: ; 142a7
; Checks to see whether we can apply a facing to a sprite.
; Returns carry unless the sprite is a Pokemon or a Still Sprite.
	cp SPRITE_POKEMON
	jr nc, .only_down

	push hl
	push bc
	ld hl, SpriteHeaders + SPRITEHEADER_TYPE ; type
	dec a
	ld c, a
	ld b, 0
	ld a, NUM_SPRITEHEADER_FIELDS
	call AddNTimes
	ld a, [hl]
	pop bc
	pop hl
	cp STILL_SPRITE
	jr nz, .only_down
	scf
	ret

.only_down
	and a
	ret
; 142c4


_GetSpritePalette:: ; 142c4
	ld a, c
	call GetMonSprite
	jr c, .is_pokemon

	ld hl, SpriteHeaders + 5 ; palette
	dec a
	ld c, a
	ld b, 0
	ld a, 6
	call AddNTimes
	ld c, [hl]
	ret

.is_pokemon
	xor a
	ld c, a
	ret
; 142db


LoadAndSortSprites: ; 142db
	call LoadSpriteGFX
	call SortUsedSprites
	jp ArrangeUsedSprites
; 142e5


AddSpriteGFX: ; 142e5
; Add any new sprite ids to a list of graphics to be loaded.
; Return carry if the list is full.

	push hl
	push bc
	ld b, a
	ld hl, UsedSprites + 2
	ld c, SPRITE_GFX_LIST_CAPACITY - 1
.loop
	ld a, [hl]
	cp b
	jr z, .exists
	and a
	jr z, .new
	inc hl
	inc hl
	dec c
	jr nz, .loop

	pop bc
	pop hl
	scf
	ret

.exists
	pop bc
	pop hl
	and a
	ret

.new
	ld [hl], b
	pop bc
	pop hl
	and a
	ret
; 14306


LoadSpriteGFX: ; 14306
	ld hl, UsedSprites
	ld b, SPRITE_GFX_LIST_CAPACITY
.loop
	ld a, [hli]
	and a
	ret z
	push bc
	push hl
	call .LoadSprite
	pop hl
	pop bc
	ld [hli], a
	dec b
	jr nz, .loop
	ret

.LoadSprite:
	call GetSprite
	ld a, l
	ret
; 1431e


SortUsedSprites: ; 1431e
; Bubble-sort sprites by type.

; Run backwards through UsedSprites to find the last one.

	ld c, SPRITE_GFX_LIST_CAPACITY
	ld de, UsedSprites + (SPRITE_GFX_LIST_CAPACITY - 1) * 2
.FindLastSprite:
	ld a, [de]
	and a
	jr nz, .FoundLastSprite
	dec de
	dec de
	dec c
	jr nz, .FindLastSprite
.FoundLastSprite:
	dec c
	ret z

; If the length of the current sprite is
; higher than a later one, swap them.

	inc de
	ld hl, UsedSprites + 1

.CheckSprite:
	push bc
	push de
	push hl

.CheckFollowing:
	ld a, [de]
	cp [hl]
	jr nc, .loop

; Swap the two sprites.

	ld b, a
	ld a, [hl]
	ld [hl], b
	ld [de], a
	dec de
	dec hl
	ld a, [de]
	ld b, a
	ld a, [hl]
	ld [hl], b
	ld [de], a
	inc de
	inc hl

; Keep doing this until everything's in order.

.loop
	dec de
	dec de
	dec c
	jr nz, .CheckFollowing

	pop hl
	inc hl
	inc hl
	pop de
	pop bc
	dec c
	jr nz, .CheckSprite
	ret
; 14355


ArrangeUsedSprites: ; 14355
; Get the length of each sprite and space them out in VRAM.
; Crystal introduces a second table in VRAM bank 0.

	ld hl, UsedSprites
	lb bc, 0, SPRITE_GFX_LIST_CAPACITY
.FirstTableLength:
; Keep going until the end of the list.
	ld a, [hli]
	and a
	ret z

	ld a, [hl]
	call GetSpriteLength

; Spill over into the second table after $78 tiles.
	add b
	cp $78
	jr z, .loop
	jr nc, .SecondTable

.loop
	ld [hl], b
	inc hl
	ld b, a

; Assumes the next table will be reached before c hits 0.
	dec c
	jr nz, .FirstTableLength

.SecondTable:
; The second tile table starts at tile $80.
	ld b, $80
	dec hl
.SecondTableLength:
; Keep going until the end of the list.
	ld a, [hli]
	and a
	ret z

	ld a, [hl]
	call GetSpriteLength

; There are only two tables, so don't go any further than that.
	add b
	ret c

	ld [hl], b
	ld b, a
	inc hl

	dec c
	jr nz, .SecondTableLength
	ret
; 14386


GetSpriteLength: ; 14386
; Return the length of sprite type a in tiles.

	cp WALKING_SPRITE
	jr z, .AnyDirection
	cp STANDING_SPRITE
	jr z, .AnyDirection
	cp STILL_SPRITE
	jr z, .OneDirection
; MON_SPRITE
	ld a, 8
	ret

.AnyDirection:
	ld a, 12
	ret

.OneDirection:
	ld a, 4
	ret
; 1439b


GetUsedSprites: ; 1439b
	ld hl, UsedSprites
	ld c, SPRITE_GFX_LIST_CAPACITY

.loop
	ld a, [wSpriteFlags]
	res 5, a
	ld [wSpriteFlags], a

	ld a, [hli]
	and a
	ret z
	ld [hUsedSpriteIndex], a

	ld a, [hli]
	ld [hUsedSpriteTile], a

	bit 7, a
	jr z, .dont_set

	ld a, [wSpriteFlags]
	set 5, a ; load VBank0
	ld [wSpriteFlags], a

.dont_set
	push bc
	push hl
	call GetUsedSprite
	pop hl
	pop bc
	dec c
	jr nz, .loop
	ret
; 143c8

GetUsedSprite: ; 143c8
	ld a, [hUsedSpriteIndex]
	call SafeGetSprite
	ld a, [hUsedSpriteTile]
	call .GetTileAddr
	push hl
	push de
	push bc
	ld a, [wSpriteFlags]
	bit 7, a
	jr nz, .skip
	call .CopyToVram

.skip
	pop bc
	ld l, c
	ld h, $0
rept 4
	add hl, hl
endr
	pop de
	add hl, de
	ld d, h
	ld e, l
	pop hl

	ld a, [wSpriteFlags]
	bit 5, a
	ret nz
	bit 6, a
	ret nz

	ld a, [hUsedSpriteIndex]
	call _DoesSpriteHaveFacings
	ret c

	ld a, h
	add $8
	ld h, a
	jr .CopyToVram
; 14406

.GetTileAddr: ; 14406
; Return the address of tile (a) in (hl).
	and $7f
	ld l, a
	ld h, 0
rept 4
	add hl, hl
endr
	ld a, l
	add VTiles0 % $100
	ld l, a
	ld a, h
	adc VTiles0 / $100
	ld h, a
	ret
; 14418

.CopyToVram: ; 14418
	ld a, [rVBK]
	push af
	ld a, [wSpriteFlags]
	bit 5, a
	ld a, $1
	jr z, .bankswitch
	ld a, $0

.bankswitch
	ld [rVBK], a
	call Get2bpp
	pop af
	ld [rVBK], a
	ret
; 1442f

LoadEmote:: ; 1442f
; Get the address of the pointer to emote c.
	ld a, c
	ld bc, 6
	ld hl, EmotesPointers
	call AddNTimes
; Load the emote address into de
	ld e, [hl]
	inc hl
	ld d, [hl]
; load the length of the emote (in tiles) into c
	inc hl
	ld c, [hl]
	swap c
; load the emote pointer bank into b
	inc hl
	ld b, [hl]
; load the VRAM destination into hl
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
; if the emote has a length of 0, do not proceed (error handling)
	ld a, c
	and a
	ret z
	jp GetEmote2bpp
; 1444d

emote_header: MACRO
	dw \1
	db \2 tiles, BANK(\1)
	dw VTiles1 tile \3
ENDM

EmotesPointers: ; 144d
; dw source address
; db length, bank
; dw dest address

	emote_header ShockEmote,     4, $78
	emote_header QuestionEmote,  4, $78
	emote_header HappyEmote,     4, $78
	emote_header SadEmote,       4, $78
	emote_header HeartEmote,     4, $78
	emote_header BoltEmote,      4, $78
	emote_header SleepEmote,     4, $78
	emote_header FishEmote,      4, $78
	emote_header JumpShadowGFX,  1, $7c
	emote_header FishingRodGFX2, 2, $7c
	emote_header BoulderDustGFX, 2, $7e
	emote_header FishingRodGFX4, 1, $7e
	emote_header PuddleSplashGFX, 1, $7f
; 14495


SpriteMons: ; 14495
	db SHELLDER
	db PIKACHU
	db ONIX
	db MACHOP
	db AERODACTYL
	db FEAROW
	db GLOOM
	db POLITOED
	db SLOWKING
	db ZAPDOS
	db MOLTRES
	db ARTICUNO
	db LUGIA
	db MEWTWO
	db MEW
	db MARSHADOW
	db HO_OH
; 144b8


OutdoorSprites: ; 144b8
; Valid sprite IDs for each map group.

	dw Group1Sprites
	dw Group2Sprites
	dw Group3Sprites
	dw Group4Sprites
	dw Group5Sprites
	dw Group6Sprites
	dw Group7Sprites
	dw Group8Sprites
	dw Group9Sprites
	dw Group10Sprites
	dw Group11Sprites
	dw Group12Sprites
	dw Group13Sprites
	dw Group14Sprites
	dw Group15Sprites
	dw Group16Sprites
	dw Group17Sprites
	dw Group18Sprites
; 144ec

Group1Sprites:
; Route 53
; Route 54
; Mandarin North
Group13Sprites:
; Sunburst Island
	db SPRITE_SEASHELL
	db SPRITE_COOLTRAINER_F
	db SPRITE_FISHER
	db SPRITE_GRAMPS
	db SPRITE_LASS
	db SPRITE_SWIMMER_GIRL
	db SPRITE_SWIMMER_GUY
	db SPRITE_YOUNGSTER
	db SPRITE_PIKACHU
	db SPRITE_POKE_BALL
	db SPRITE_FRUIT_TREE
	db 0 ; end
; 146b8

Group2Sprites:
; Route 60
Group14Sprites:
; Golden Island
	db SPRITE_SEASHELL
	db SPRITE_JESSIE
	db SPRITE_JAMES
	db SPRITE_SWIMMER_GIRL
	db SPRITE_ROCKER
	db SPRITE_SWIMMER_GUY
	db SPRITE_CAT_MAN
	db SPRITE_MISTY
	db SPRITE_ROCK
	db SPRITE_POKE_BALL
	db SPRITE_FRUIT_TREE
	db 0 ; end
; 146e6

Group3Sprites:
; Route 57
; Unnamed Island 1
; Route 58
; Navel Island
; 7 Grapefruits
; Route 59
; Moro Island
	db SPRITE_SEASHELL
	db SPRITE_BIG_SNORLAX
	db SPRITE_SIGHTSEER_F
	db SPRITE_COOLTRAINER_F
	db SPRITE_COOLTRAINER_M
	db SPRITE_FISHER
	db SPRITE_RED
	db SPRITE_ROCKER
	db SPRITE_SWIMMER_GUY
	db SPRITE_POKE_BALL
	db SPRITE_ROCK
	db 0

Group4Sprites:
; Route 55
; Pinkan Island
; Route 56 West
; Route 56 East
; Kinnow Island
	db SPRITE_SEASHELL
	db SPRITE_COOLTRAINER_M
	db SPRITE_FISHER
	db SPRITE_POKEFAN_M
	db SPRITE_TRACEY
	db SPRITE_SUPER_NERD
	db SPRITE_SWIMMER_GIRL
	db SPRITE_SWIMMER_GUY
	db SPRITE_POKE_BALL
	db SPRITE_FRUIT_TREE
	db SPRITE_ROCK
	db 0 ; end
; 146cf

Group5Sprites:
; Route 52
; Mikan Island
	db SPRITE_SEASHELL
	db SPRITE_FISHER
	db SPRITE_LASS
	db SPRITE_SUPER_NERD
	db SPRITE_SWIMMER_GIRL
	db SPRITE_SWIMMER_GUY
	db SPRITE_YOUNGSTER
	db SPRITE_BLACK_BELT
	db SPRITE_POKE_BALL
	db SPRITE_FRUIT_TREE
	db 0 ; end

Group6Sprites:
; Route 61
; Murcott Island
; Unnamed Island 2
; Mandarin South
	db SPRITE_SEASHELL
	db SPRITE_TRACEY
	db SPRITE_ROCKER
	db SPRITE_GRAMPS
	db SPRITE_LASS
	db SPRITE_YOUNGSTER
	db SPRITE_SUPER_NERD
	db SPRITE_DAYCARE_MON_1
	db SPRITE_DAYCARE_MON_2
	db SPRITE_FRUIT_TREE
	db SPRITE_POKE_BALL
	db 0 ; end

Group7Sprites:
	db 0 ; end

Group8Sprites:
; Valencia Port
; Tangelo Port
; Trovitopolis
	db SPRITE_SEASHELL
	db SPRITE_FISHING_GURU
	db SPRITE_SAILOR
	db SPRITE_FISHER
	db SPRITE_COOLTRAINER_F
	db SPRITE_GENTLEMAN
	db SPRITE_LORELEI
	db SPRITE_LANCE
	db SPRITE_TRACEY
	db SPRITE_GRAMPS
	db SPRITE_POKE_BALL
	db 0 ; end

Group9Sprites:
; Ascorbia Island
	db SPRITE_SEASHELL
	db SPRITE_GRANNY
	db SPRITE_YOUNGSTER
	db SPRITE_BLACK_BELT
	db SPRITE_SIGHTSEER_F
	db SPRITE_TRACEY
	db SPRITE_ROCKER
	db SPRITE_LASS
	db SPRITE_POKE_BALL
	db SPRITE_FRUIT_TREE
	db SPRITE_PIKACHU
	db SPRITE_DIVER_MALE_SWIM
	db 0 ; end

Group10Sprites:
	db 0 ; end

Group11Sprites:
; Route 49
; Valencia Island
	db SPRITE_SEASHELL
	db SPRITE_BUG_BOY
	db SPRITE_COOLTRAINER_F
	db SPRITE_TRACEY
	db SPRITE_SURF
	db SPRITE_COOLTRAINER_M
	db SPRITE_YOUNGSTER
	db SPRITE_POKE_BALL
	db SPRITE_FRUIT_TREE
	db 0 ; end

Group12Sprites:
; Route 50
; Route 51
; Tangelo Island
	db SPRITE_SEASHELL
	db SPRITE_BUG_BOY
	db SPRITE_COOLTRAINER_F
	db SPRITE_TRACEY
	db SPRITE_SURF
	db SPRITE_COOLTRAINER_M
	db SPRITE_YOUNGSTER
	db SPRITE_POKE_BALL
	db SPRITE_FRUIT_TREE
	db SPRITE_HO_OH
	db SPRITE_ROCKER
	db 0 ; end

Group15Sprites:
; Pummelo Island
	db SPRITE_SEASHELL
	db SPRITE_FRUIT_TREE
	db SPRITE_POKE_BALL
	db SPRITE_YOUNGSTER
	db SPRITE_POKEFAN_M
	db SPRITE_ROCKER
	db SPRITE_SAILOR
	db SPRITE_OFFICER
	db SPRITE_SURF
	db 0 ; end
	
Group16Sprites:
; Kumquat Island
	db SPRITE_SEASHELL
	db SPRITE_POLITOED
	db SPRITE_SIGHTSEER_F
	db SPRITE_SAILBOAT_TOP
	db SPRITE_SAILBOAT_BOTTOM
	db SPRITE_UMBRELLA
	db SPRITE_COOLTRAINER_M
	db SPRITE_COOLTRAINER_F
	db SPRITE_SUPER_NERD
	db SPRITE_SWIMMER_GIRL
	db SPRITE_SAILOR
	db SPRITE_FISHER
	db SPRITE_LASS
	db SPRITE_POKE_BALL
	db SPRITE_FRUIT_TREE
	db 0 ;end
	
Group17Sprites:
; Hamlin Island
	db SPRITE_SEASHELL
	db SPRITE_GYM_GUY
	db SPRITE_SIGHTSEER_F
	db SPRITE_COOLTRAINER_M
	db SPRITE_COOLTRAINER_F
	db SPRITE_SUPER_NERD
	db SPRITE_SWIMMER_GIRL
	db SPRITE_SAILOR
	db SPRITE_OFFICER
	db SPRITE_FISHER
	db SPRITE_LASS
	db SPRITE_POKE_BALL
	db SPRITE_FRUIT_TREE
	db SPRITE_SHRINE1
	db SPRITE_SHRINE2
	db 0 ;end

Group18Sprites:
; Shamouti  Island
	db SPRITE_SEASHELL
	db SPRITE_SLOWKING
	db SPRITE_KIMONO_GIRL
	db SPRITE_SAGE
	db SPRITE_BLACK_BELT
	db SPRITE_JASMINE
	db SPRITE_ZAPDOS
	db SPRITE_MOLTRES
	db SPRITE_ARTICUNO
	db SPRITE_LUGIA
	db SPRITE_LAWRENCE
	db SPRITE_LASS
	db SPRITE_CAPTURE_RING
	db SPRITE_POKE_BALL
	db SPRITE_SAILBOAT_TOP
	db SPRITE_SAILBOAT_BOTTOM
	db 0 ;end

SpriteHeaders: ; 14736
INCLUDE "gfx/overworld/sprite_headers.asm"
; 1499a
