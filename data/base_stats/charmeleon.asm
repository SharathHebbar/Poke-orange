	db CHARMELEON ; 005

	db  60,  72,  63,  85,  90,  80
	;   hp  atk  def  spd  sat  sdf

	db FIRE, FIRE
	db 45 ; catch rate
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	db FEMALE_12_5 ; gender
	db 20 ; step cycles to hatch
	dn 6, 6 ; frontpic dimensions

	db MEDIUM_SLOW ; growth rate
	dn MONSTER, REPTILE ; egg groups

	; tmhm
	tmhm POWERUPPUNCH, DRAGON_PULSE, TOXIC, SUNNY_DAY, DRAGONBREATH, PROTECT, SHADOW_CLAW, IRON_TAIL, RETURN, DIG, DOUBLE_TEAM, FLAMETHROWER, FIRE_BLAST, AERIAL_ACE, FACADE, REST, ROCK_SLIDE, CUT, STRENGTH, ROCK_SMASH, FIRE_PUNCH, THUNDERPUNCH, DYNAMICPUNCH, HEADBUTT, SWORDS_DANCE, BODY_SLAM, COUNTER, SUBSTITUTE, ENDURE, SWAGGER, SLEEP_TALK, ATTRACT
	; end
