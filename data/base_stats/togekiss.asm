	db TOGEKISS ; 177

	db  85,  50,  95,  80,  120,  115
	;   hp  atk  def  spd  sat  sdf

	db FAIRY, FLYING
	db 30 ; catch rate
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	db FEMALE_12_5 ; gender
	db 15 ; step cycles to hatch
	dn 7, 7 ; frontpic dimensions

	db FAST ; growth rate
	dn AVIAN, FAIRYEGG ; egg groups

	; tmhm
	tmhm WATER_PULSE, TOXIC, SUNNY_DAY, HYPER_BEAM, PROTECT, RAIN_DANCE, SOLARBEAM, RETURN, PSYCHIC_M, SHADOW_BALL, DOUBLE_TEAM, GIGA_IMPACT, FLAMETHROWER, FIRE_BLAST, DAZZLINGLEAM, AERIAL_ACE, FACADE, REST, STEEL_WING, FLASH, FLY, ROCK_SMASH, HEADBUTT, ZEN_HEADBUTT, SUBSTITUTE, ENDURE, SWAGGER, SLEEP_TALK, ATTRACT, SIGNAL_BEAM
	; end
