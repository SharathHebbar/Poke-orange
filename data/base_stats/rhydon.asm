	db RHYDON ; 112

	db 105, 130, 120,  40,  45,  45
	;   hp  atk  def  spd  sat  sdf

	db GROUND, ROCK
	db 60 ; catch rate
	db PROTECTOR ; item 1
	db PROTECTOR ; item 2
	db FEMALE_50 ; gender
	db 20 ; step cycles to hatch
	dn 7, 7 ; frontpic dimensions

	db SLOW ; growth rate
	dn MONSTER, FIELD ; egg groups

	; tmhm
	tmhm POWERUPPUNCH, DRAGON_PULSE, TOXIC, WHIRLPOOL, FISSURE, SUNNY_DAY, ICE_BEAM, BLIZZARD, HYPER_BEAM, PROTECT, RAIN_DANCE, DRAGON_TAIL, SHADOW_CLAW, IRON_TAIL, THUNDERBOLT, THUNDER, EARTHQUAKE, RETURN, DIG, BUBBLEBEAM, DOUBLE_TEAM, EARTH_POWER, GIGA_IMPACT, FLAMETHROWER, SANDSTORM, FIRE_BLAST, FACADE, REST, THIEF, ROCK_SLIDE, CUT, SURF, STRENGTH, ROCK_SMASH, ROCK_CLIMB, FIRE_PUNCH, THUNDERPUNCH, ICE_PUNCH, DYNAMICPUNCH, HEADBUTT, SWORDS_DANCE, BODY_SLAM, COUNTER, SUBSTITUTE, ENDURE, SWAGGER, SLEEP_TALK, ATTRACT, POISON_JAB
	; end
