	db NIDORINO ; 033

	db  61,  72,  57,  65,  55,  55
	;   hp  atk  def  spd  sat  sdf

	db POISON, POISON
	db 120 ; catch rate
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	db ALL_MALE ; gender
	db 20 ; step cycles to hatch
	dn 6, 6 ; frontpic dimensions

	db MEDIUM_SLOW ; growth rate
	dn MONSTER, FIELD ; egg groups

	; tmhm
	tmhm WATER_PULSE, VENOSHOCK, TOXIC, SUNNY_DAY, ICE_BEAM, BLIZZARD, PROTECT, RAIN_DANCE, SHADOW_CLAW, IRON_TAIL, THUNDERBOLT, THUNDER, RETURN, DIG, BUBBLEBEAM, DOUBLE_TEAM, SLUDGE_BOMB, FACADE, REST, THIEF, CUT, STRENGTH, ROCK_SMASH, HEADBUTT, BODY_SLAM, COUNTER, SUBSTITUTE, ENDURE, SWAGGER, SLEEP_TALK, ATTRACT, POISON_JAB
	; end