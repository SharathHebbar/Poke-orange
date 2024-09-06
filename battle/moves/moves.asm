Moves: ; 41afb
; Characteristics of each move.

if DEF(PSS)
move: MACRO
	db \1 ; animation
	db \2 ; effect
	db \3 ; power
	db \4 | \5 ; category + type
	db \6 percent ; accuracy
	db \7 ; pp
	db \8 percent ; effect chance
ENDM
else
move: MACRO
	db \1 ; animation
	db \2 ; effect
	db \3 ; power
	db \5 ; type
	db \6 percent ; accuracy
	db \7 ; pp
	db \8 percent ; effect chance
ENDM
endc
	move SHADOW_CLAW,  EFFECT_NORMAL_HIT,         90, PHYSICAL, GHOST,    100, 15,   0
	move KARATE_CHOP,  EFFECT_NORMAL_HIT,         60, PHYSICAL, FIGHTING, 100, 25,   0
	move DOUBLESLAP,   EFFECT_MULTI_HIT,          25, PHYSICAL, NORMAL,    85, 10,   0
	move COMET_PUNCH,  EFFECT_MULTI_HIT,          25, PHYSICAL, FIGHTING,    85, 15,   0
	move POISON_JAB,   EFFECT_POISON_HIT,         90, PHYSICAL, POISON,   100, 20,  30
	move PAY_DAY,      EFFECT_PAY_DAY,            50, PHYSICAL, NORMAL,   100, 20,   0
	move FIRE_PUNCH,   EFFECT_BURN_HIT,           85, PHYSICAL, FIRE,     100, 15,  10
	move ICE_PUNCH,    EFFECT_FREEZE_HIT,         85, PHYSICAL, ICE,      100, 15,  10
	move THUNDERPUNCH, EFFECT_PARALYZE_HIT,       85, PHYSICAL, ELECTRIC, 100, 15,  10
	move SCRATCH,      EFFECT_NORMAL_HIT,         50, PHYSICAL, NORMAL,   100, 35,   0
	move BULLET_SEED,  EFFECT_MULTI_HIT,          25, PHYSICAL, GRASS,    100, 30,   0
	move GUILLOTINE,   EFFECT_OHKO,                1, PHYSICAL, NORMAL,    30,  5,   0
	move DRAGON_PULSE, EFFECT_NORMAL_HIT,        100, SPECIAL,  DRAGON,   100, 10,   0
	move SWORDS_DANCE, EFFECT_ATTACK_UP_2,         0, STATUS,   NORMAL,   100, 20,   0
	move CUT,          EFFECT_NORMAL_HIT,         70, PHYSICAL, GRASS,    100, 30,   0
	move GUST,         EFFECT_GUST,               50, SPECIAL,  FLYING,   100, 35,   0
	move WING_ATTACK,  EFFECT_NORMAL_HIT,         60, PHYSICAL, FLYING,   100, 35,   0
	move WHIRLWIND,    EFFECT_WHIRLWIND,           0, STATUS,   FLYING,   100, 20,   0
	move FLY,          EFFECT_FLY,                90, PHYSICAL, FLYING,   100, 15,   0
	move DARK_PULSE,   EFFECT_FLINCH_HIT,        100, SPECIAL,  DARK,     100, 15,  20
	move SLAM,         EFFECT_NORMAL_HIT,         90, PHYSICAL, NORMAL,    75, 20,   0
	move VINE_WHIP,    EFFECT_NORMAL_HIT,         50, PHYSICAL, GRASS,    100, 25,   0
	move STOMP,        EFFECT_STOMP,              65, PHYSICAL, NORMAL,   100, 20,  30
	move DOUBLE_KICK,  EFFECT_DOUBLE_HIT,         35, PHYSICAL, FIGHTING, 100, 30,   0
	move ZEN_HEADBUTT, EFFECT_FLINCH_HIT,         90, PHYSICAL, PSYCHIC,   90, 15,  20
	move GIGA_IMPACT,  EFFECT_HYPER_BEAM,        150, SPECIAL,  NORMAL,    90,  5,   0
	move FLASH_CANNON, EFFECT_SP_DEF_DOWN_HIT,   100, SPECIAL,  STEEL,    100, 10,  10
	move SAND_ATTACK,  EFFECT_ACCURACY_DOWN,       0, STATUS,   GROUND,   100, 15,   0
	move HEADBUTT,     EFFECT_FLINCH_HIT,         80, PHYSICAL, NORMAL,   100, 15,  30
	move HORN_ATTACK,  EFFECT_NORMAL_HIT,         65, PHYSICAL, NORMAL,   100, 25,   0
	move FURY_ATTACK,  EFFECT_MULTI_HIT,          25, PHYSICAL, NORMAL,    85, 20,   0
	move HORN_DRILL,   EFFECT_OHKO,                1, PHYSICAL, NORMAL,    30,  5,   0
	move TACKLE,       EFFECT_NORMAL_HIT,         50, PHYSICAL, NORMAL,   100, 35,   0
	move BODY_SLAM,    EFFECT_PARALYZE_HIT,       90, PHYSICAL, NORMAL,   100, 15,  30
	move WRAP,         EFFECT_TRAP,               40, PHYSICAL, NORMAL,    90, 20,   0
	move TAKE_DOWN,    EFFECT_RECOIL_HIT,         90, PHYSICAL, NORMAL,    85, 20,   0
	move THRASH,       EFFECT_RAMPAGE,           140, PHYSICAL, NORMAL,   100, 10,   0
	move DOUBLE_EDGE,  EFFECT_RECOIL_HIT,        120, PHYSICAL, NORMAL,   100, 15,   0
	move TAIL_WHIP,    EFFECT_DEFENSE_DOWN,        0, STATUS,   NORMAL,   100, 30,   0
	move POISON_STING, EFFECT_POISON_HIT,         40, PHYSICAL, POISON,   100, 35,  30
	move TWINEEDLE,    EFFECT_TWINEEDLE,          25, PHYSICAL, BUG,      100, 20,  20
	move PIN_MISSILE,  EFFECT_MULTI_HIT,          25, PHYSICAL, BUG,       95, 20,   0
	move LEER,         EFFECT_DEFENSE_DOWN,        0, STATUS,   NORMAL,   100, 30,   0
	move BITE,         EFFECT_FLINCH_HIT,         60, PHYSICAL, DARK,     100, 25,  30
	move GROWL,        EFFECT_ATTACK_DOWN,         0, STATUS,   NORMAL,   100, 40,   0
	move ROAR,         EFFECT_WHIRLWIND,           0, STATUS,   NORMAL,   100, 20,   0
	move SING,         EFFECT_SLEEP,               0, STATUS,   NORMAL,    55, 15,   0
	move SUPERSONIC,   EFFECT_CONFUSE,             0, STATUS,   NORMAL,    55, 20,   0
	move SONICBOOM,    EFFECT_STATIC_DAMAGE,      20, SPECIAL,  NORMAL,    90, 20,   0
	move DISABLE,      EFFECT_DISABLE,             0, STATUS,   NORMAL,   100, 20,   0
	move ACID,         EFFECT_DEFENSE_DOWN_HIT,   50, SPECIAL,  POISON,   100, 30,  10
	move EMBER,        EFFECT_BURN_HIT,           50, SPECIAL,  FIRE,     100, 25,  10
	move FLAMETHROWER, EFFECT_BURN_HIT,          100, SPECIAL,  FIRE,     100, 15,  10
	move MIST,         EFFECT_MIST,                0, STATUS,   ICE,      100, 30,   0
	move WATER_GUN,    EFFECT_NORMAL_HIT,         50, SPECIAL,  WATER,    100, 25,   0
	move HYDRO_PUMP,   EFFECT_NORMAL_HIT,        120, SPECIAL,  WATER,     80, 10,   0
	move SURF,         EFFECT_SURF,               1, SPECIAL,  WATER,    100, 20,   0
	move ICE_BEAM,     EFFECT_FREEZE_HIT,        100, SPECIAL,  ICE,      100, 10,  10
	move BLIZZARD,     EFFECT_BLIZZARD,          120, SPECIAL,  ICE,       70,  5,  10
	move PSYBEAM,      EFFECT_CONFUSE_HIT,        70, SPECIAL,  PSYCHIC,  100, 20,  10
	move BUBBLEBEAM,   EFFECT_SPEED_DOWN_HIT,     70, SPECIAL,  WATER,    100, 20,  10
	move AURORA_BEAM,  EFFECT_ATTACK_DOWN_HIT,    70, SPECIAL,  ICE,      100, 20,  10
	move HYPER_BEAM,   EFFECT_HYPER_BEAM,        150, SPECIAL,  NORMAL,    90,  5,   0
	move PECK,         EFFECT_NORMAL_HIT,         50, PHYSICAL, FLYING,   100, 35,   0
	move DRILL_PECK,   EFFECT_NORMAL_HIT,         90, PHYSICAL, FLYING,   100, 20,   0
	move SUBMISSION,   EFFECT_RECOIL_HIT,         80, PHYSICAL, FIGHTING,  80, 20,   0
	move LOW_KICK,     EFFECT_FLINCH_HIT,         50, PHYSICAL, FIGHTING, 100, 20,  30
	move COUNTER,      EFFECT_COUNTER,             1, PHYSICAL, FIGHTING, 100, 20,   0
	move SEISMIC_TOSS, EFFECT_LEVEL_DAMAGE,        1, PHYSICAL, FIGHTING, 100, 20,   0
	move STRENGTH,     EFFECT_NORMAL_HIT,        100, PHYSICAL, FIGHTING,   100, 15,   0
	move ABSORB,       EFFECT_LEECH_HIT,          50, SPECIAL,  GRASS,    100, 25,   0
	move PLAY_ROUGH,   EFFECT_ATTACK_DOWN_HIT,   100, PHYSICAL, FAIRY,     90, 10,  10
	move LEECH_SEED,   EFFECT_LEECH_SEED,          0, STATUS,   GRASS,     90, 10,   0
	move GROWTH,       EFFECT_SP_ATK_UP,           0, STATUS,   NORMAL,   100, 20,   0
	move RAZOR_LEAF,   EFFECT_NORMAL_HIT,         65, PHYSICAL, GRASS,     95, 25,   0
	move SOLARBEAM,    EFFECT_SOLARBEAM,         140, SPECIAL,  GRASS,    100, 10,   0
	move POISONPOWDER, EFFECT_POISON,              0, STATUS,   POISON,    75, 35,   0
	move STUN_SPORE,   EFFECT_PARALYZE,            0, STATUS,   GRASS,     75, 30,   0
	move SLEEP_POWDER, EFFECT_SLEEP,               0, STATUS,   GRASS,     75, 15,   0
	move PETAL_DANCE,  EFFECT_RAMPAGE,           140, SPECIAL,  GRASS,    100, 10,   0
	move STRING_SHOT,  EFFECT_SPEED_DOWN,          0, STATUS,   BUG,       95, 40,   0
	move DRAGON_RAGE,  EFFECT_STATIC_DAMAGE,      40, SPECIAL,  DRAGON,   100, 10,   0
	move FIRE_SPIN,    EFFECT_TRAP,               40, SPECIAL,  FIRE,      85, 15,   0
	move THUNDERSHOCK, EFFECT_PARALYZE_HIT,       50, SPECIAL,  ELECTRIC, 100, 30,  10
	move THUNDERBOLT,  EFFECT_PARALYZE_HIT,      100, SPECIAL,  ELECTRIC, 100, 15,  10
	move THUNDER_WAVE, EFFECT_PARALYZE,            0, STATUS,   ELECTRIC,  90, 20,   0
	move THUNDER,      EFFECT_THUNDER,           120, SPECIAL,   ELECTRIC,  70, 10, 30
	move ROCK_THROW,   EFFECT_NORMAL_HIT,         60, PHYSICAL, ROCK,      90, 15,   0
	move EARTHQUAKE,   EFFECT_EARTHQUAKE,        120, PHYSICAL, GROUND,   100, 10,   0
	move FISSURE,      EFFECT_OHKO,                1, PHYSICAL, GROUND,    30,  5,   0
	move DIG,          EFFECT_FLY,                90, PHYSICAL, GROUND,   100, 10,   0
	move TOXIC,        EFFECT_TOXIC,               0, STATUS,   POISON,    90, 10,   0
	move CONFUSION,    EFFECT_CONFUSE_HIT,        50, SPECIAL,  PSYCHIC,  100, 25,  10
	move PSYCHIC_M,    EFFECT_SP_DEF_DOWN_HIT,   100, SPECIAL,  PSYCHIC,  100, 10,  10
	move HYPNOSIS,     EFFECT_SLEEP,               0, STATUS,   PSYCHIC,   60, 20,   0
	move POWER_GEM,    EFFECT_NORMAL_HIT,         90, SPECIAL,  ROCK,     100, 20,   0
	move AGILITY,      EFFECT_SPEED_UP_2,          0, STATUS,   PSYCHIC,  100, 30,   0
	move QUICK_ATTACK, EFFECT_PRIORITY_HIT,       50, PHYSICAL, NORMAL,   100, 30,   0
	move RAGE,         EFFECT_RAGE,               40, PHYSICAL, NORMAL,   100, 20,   0
	move TELEPORT,     EFFECT_TELEPORT,            0, STATUS,   PSYCHIC,  100, 20,   0
	move NIGHT_SHADE,  EFFECT_LEVEL_DAMAGE,        1, SPECIAL,  GHOST,    100, 15,   0
	move MIMIC,        EFFECT_MIMIC,               0, STATUS,   NORMAL,   100, 10,   0
	move SCREECH,      EFFECT_DEFENSE_DOWN_2,      0, STATUS,   NORMAL,    85, 40,   0
	move DOUBLE_TEAM,  EFFECT_EVASION_UP,          0, STATUS,   NORMAL,   100, 15,   0
	move RECOVER,      EFFECT_HEAL,                0, STATUS,   NORMAL,   100, 10,   0
	move HARDEN,       EFFECT_DEFENSE_UP,          0, STATUS,   NORMAL,   100, 30,   0
	move MINIMIZE,     EFFECT_EVASION_UP,          0, STATUS,   NORMAL,   100, 10,   0
	move SMOKESCREEN,  EFFECT_ACCURACY_DOWN,       0, STATUS,   NORMAL,   100, 20,   0
	move CONFUSE_RAY,  EFFECT_CONFUSE,             0, STATUS,   GHOST,    100, 10,   0
	move WITHDRAW,     EFFECT_DEFENSE_UP,          0, STATUS,   WATER,    100, 40,   0
	move DEFENSE_CURL, EFFECT_DEFENSE_CURL,        0, STATUS,   NORMAL,   100, 40,   0
	move BARRIER,      EFFECT_DEFENSE_UP_2,        0, STATUS,   PSYCHIC,  100, 20,   0
	move LIGHT_SCREEN, EFFECT_LIGHT_SCREEN,        0, STATUS,   PSYCHIC,  100, 30,   0
	move HAZE,         EFFECT_HAZE,                0, STATUS,   ICE,      100, 30,   0
	move REFLECT,      EFFECT_REFLECT,             0, STATUS,   PSYCHIC,  100, 20,   0
	move FOCUS_ENERGY, EFFECT_FOCUS_ENERGY,        0, STATUS,   NORMAL,   100, 30,   0
	move ROCK_BLAST,   EFFECT_MULTI_HIT,          25, PHYSICAL, ROCK,      90, 10,   0
	move METRONOME,    EFFECT_METRONOME,           0, STATUS,   NORMAL,   100, 10,   0
	move MIRROR_MOVE,  EFFECT_MIRROR_MOVE,         0, STATUS,   FLYING,   100, 20,   0
	move SELFDESTRUCT, EFFECT_EXPLOSION,         200, PHYSICAL, NORMAL,   100,  5,   0
	move EGG_BOMB,     EFFECT_NORMAL_HIT,        100, PHYSICAL, NORMAL,    75, 10,   0
	move LICK,         EFFECT_PARALYZE_HIT,       40, PHYSICAL, GHOST,    100, 30,  30
	move SMOG,         EFFECT_POISON_HIT,         40, SPECIAL,  POISON,    70, 20,  40
	move SLUDGE,       EFFECT_POISON_HIT,         70, SPECIAL,  POISON,   100, 20,  30
	move SHADOW_BONE,  EFFECT_DEFENSE_DOWN_HIT,  100, PHYSICAL, GHOST,    100, 10,  20
	move FIRE_BLAST,   EFFECT_BURN_HIT,          120, SPECIAL,  FIRE,      85,  5,  10
	move WATERFALL,    EFFECT_NORMAL_HIT,        100, PHYSICAL, WATER,    100, 15,   0
	move CLAMP,        EFFECT_TRAP,               50, PHYSICAL, WATER,     85, 15,   0
	move SWIFT,        EFFECT_ALWAYS_HIT,         70, SPECIAL,  NORMAL,   100, 20,   0
	move SIGNAL_BEAM,  EFFECT_CONFUSE_HIT,        90, SPECIAL,  BUG,      100, 15,  10
	move SPIKE_CANNON, EFFECT_MULTI_HIT,          25, PHYSICAL, NORMAL,   100, 15,   0
	move ACCELEROCK,   EFFECT_PRIORITY_HIT,       50, PHYSICAL, ROCK,     100, 20,   0
	move AMNESIA,      EFFECT_SP_DEF_UP_2,         0, STATUS,   PSYCHIC,  100, 20,   0
	move DIVE,         EFFECT_FLY,                90, PHYSICAL, WATER,    100, 10,   0
	move SOFTBOILED,   EFFECT_HEAL,                0, STATUS,   NORMAL,   100, 10,   0
	move HI_JUMP_KICK, EFFECT_JUMP_KICK,         130, PHYSICAL, FIGHTING,  90, 10,   0
	move GLARE,        EFFECT_PARALYZE,            0, STATUS,   NORMAL,   100, 30,   0
	move DREAM_EATER,  EFFECT_DREAM_EATER,       120, SPECIAL,  PSYCHIC,  100, 15,   0
	move POISON_GAS,   EFFECT_POISON,              0, STATUS,   POISON,    90, 40,   0
	move BARRAGE,      EFFECT_MULTI_HIT,          25, PHYSICAL, NORMAL,    85, 20,   0
	move LEECH_LIFE,   EFFECT_LEECH_HIT,         100, PHYSICAL, BUG,      100, 10,   0
	move SKETCH,       EFFECT_SKETCH,              0, STATUS,   NORMAL,   100,  1,   0
	move SEED_BOMB,    EFFECT_NORMAL_HIT,        100, PHYSICAL, GRASS,    100, 15,   0
	move TRANSFORM,    EFFECT_TRANSFORM,           0, STATUS,   NORMAL,   100, 10,   0
	move BUBBLE,       EFFECT_SPEED_DOWN_HIT,     50, SPECIAL,  WATER,    100, 30,  10
	move DIZZY_PUNCH,  EFFECT_CONFUSE_HIT,        70, PHYSICAL, NORMAL,   100, 10,  20
	move SPORE,        EFFECT_SLEEP,               0, STATUS,   GRASS,    100, 15,   0
	move FLASH,        EFFECT_ACCURACY_DOWN,       0, STATUS,   NORMAL,   100, 20,   0
	move MIST_BALL,    EFFECT_SP_ATK_DOWN_HIT,    90, SPECIAL,  PSYCHIC,  100,  5,  50
	move SPLASH,       EFFECT_SPLASH,              0, STATUS,   NORMAL,   100, 40,   0
	move ACID_ARMOR,   EFFECT_DEFENSE_UP_2,        0, STATUS,   POISON,   100, 20,   0
	move CRABHAMMER,   EFFECT_NORMAL_HIT,        120, PHYSICAL, WATER,     90, 10,   0
	move EXPLOSION,    EFFECT_EXPLOSION,         250, PHYSICAL, NORMAL,   100,  5,   0
	move FURY_SWIPES,  EFFECT_MULTI_HIT,          25, PHYSICAL, NORMAL,    80, 15,   0
	move BONEMERANG,   EFFECT_DOUBLE_HIT,         60, PHYSICAL, GROUND,    90, 10,   0
	move REST,         EFFECT_HEAL,                0, STATUS,   PSYCHIC,  100, 10,   0
	move ROCK_SLIDE,   EFFECT_FLINCH_HIT,        100, PHYSICAL, ROCK,      90, 10,  30
	move HYPER_FANG,   EFFECT_FLINCH_HIT,         95, PHYSICAL, NORMAL,    90, 15,  10
	move FACADE,       EFFECT_FACADE,             80, PHYSICAL, NORMAL,   100, 20,   0
	move CONVERSION,   EFFECT_CONVERSION,          0, STATUS,   NORMAL,   100, 30,   0
	move TRI_ATTACK,   EFFECT_TRI_ATTACK,         90, SPECIAL,  NORMAL,   100, 10,  20
	move SUPER_FANG,   EFFECT_SUPER_FANG,          1, PHYSICAL, NORMAL,    90, 10,   0
	move SLASH,        EFFECT_NORMAL_HIT,         80, PHYSICAL, NORMAL,   100, 20,   0
	move SUBSTITUTE,   EFFECT_SUBSTITUTE,          0, STATUS,   NORMAL,   100, 10,   0
	move ROCK_CLIMB,   EFFECT_CONFUSE_HIT,       120, PHYSICAL, FIGHTING,    85, 20,  20
	move TRIPLE_KICK,  EFFECT_TRIPLE_KICK,        15, PHYSICAL, FIGHTING,  90, 10,   0
	move THIEF,        EFFECT_THIEF,              60, PHYSICAL, DARK,     100, 25, 100
	move SHELL_TRAP,   EFFECT_SHELL_TRAP,        150, SPECIAL,  FIRE,     100,  5,   0
	move LUSTER_PURGE, EFFECT_SP_DEF_DOWN_HIT,    90, SPECIAL,  PSYCHIC,  100,  5,  50
	move VENOSHOCK,    EFFECT_VENOSHOCK,          70, SPECIAL,  POISON,   100, 10,   0
	move FLAME_WHEEL,  EFFECT_FLAME_WHEEL,        70, PHYSICAL, FIRE,     100, 25,  10
	move EARTH_POWER,  EFFECT_SP_DEF_DOWN_HIT,   100, SPECIAL,  GROUND,   100, 10,  10
	move CURSE,        EFFECT_CURSE,               0, STATUS,   GHOST,    100, 10,   0
	move FLAIL,        EFFECT_REVERSAL,            1, PHYSICAL, NORMAL,   100, 15,   0
	move CONVERSION2,  EFFECT_CONVERSION2,         0, STATUS,   NORMAL,   100, 30,   0
	move AEROBLAST,    EFFECT_NORMAL_HIT,        120, SPECIAL,  FLYING,    95,  5,   0
	move COTTON_SPORE, EFFECT_SPEED_DOWN_2,        0, STATUS,   GRASS,    100, 40,   0
	move REVERSAL,     EFFECT_REVERSAL,            1, PHYSICAL, FIGHTING, 100, 15,   0
	move NASTY_PLOT,   EFFECT_SP_ATK_UP_2,         0, STATUS,   DARK,     100, 20,   0
	move HAIL,         EFFECT_HAIL,                0, STATUS,   ICE,      100, 10,   0
	move PROTECT,      EFFECT_PROTECT,             0, STATUS,   NORMAL,   100, 10,   0
	move MACH_PUNCH,   EFFECT_PRIORITY_HIT,       50, PHYSICAL, FIGHTING, 100, 30,   0
	move SCARY_FACE,   EFFECT_SPEED_DOWN_2,        0, STATUS,   NORMAL,   100, 10,   0
	move FAINT_ATTACK, EFFECT_ALWAYS_HIT,         70, PHYSICAL, DARK,     100, 20,   0
	move SWEET_KISS,   EFFECT_CONFUSE,             0, STATUS,   FAIRY,     75, 10,   0
	move BELLY_DRUM,   EFFECT_BELLY_DRUM,          0, STATUS,   NORMAL,   100, 10,   0
	move SLUDGE_BOMB,  EFFECT_POISON_HIT,        100, SPECIAL,  POISON,   100, 10,  30
	move MUD_SLAP,     EFFECT_ACCURACY_DOWN_HIT,  40, SPECIAL,  GROUND,   100, 10, 100
	move OCTAZOOKA,    EFFECT_ACCURACY_DOWN_HIT,  80, SPECIAL,  WATER,     85, 10,  50
	move SPIKES,       EFFECT_SPIKES,              0, STATUS,   GROUND,   100, 20,   0
	move ZAP_CANNON,   EFFECT_PARALYZE_HIT,      140, SPECIAL,  ELECTRIC,  50,  5, 100
	move FORESIGHT,    EFFECT_FORESIGHT,           0, STATUS,   NORMAL,   100, 40,   0
	move DESTINY_BOND, EFFECT_DESTINY_BOND,        0, STATUS,   GHOST,    100,  5,   0
	move PERISH_SONG,  EFFECT_PERISH_SONG,         0, STATUS,   NORMAL,   100,  5,   0
	move ICY_WIND,     EFFECT_SPEED_DOWN_HIT,     60, SPECIAL,  ICE,       95, 15, 100
	move POWERUPPUNCH, EFFECT_METAL_CLAW,         40, PHYSICAL, FIGHTING, 100, 20, 100
	move BONE_RUSH,    EFFECT_MULTI_HIT,          25, PHYSICAL, GROUND,    90, 10,   0
	move LOCK_ON,      EFFECT_LOCK_ON,             0, STATUS,   NORMAL,   100,  5,   0
	move OUTRAGE,      EFFECT_RAMPAGE,           140, PHYSICAL, DRAGON,   100, 10,   0
	move SANDSTORM,    EFFECT_SANDSTORM,           0, STATUS,   ROCK,     100, 10,   0
	move GIGA_DRAIN,   EFFECT_LEECH_HIT,         100, SPECIAL,  GRASS,    100, 10,   0
	move ENDURE,       EFFECT_ENDURE,              0, STATUS,   NORMAL,   100, 10,   0
	move CHARM,        EFFECT_ATTACK_DOWN_2,       0, STATUS,   FAIRY,    100, 20,   0
	move ROLLOUT,      EFFECT_ROLLOUT,            30, PHYSICAL, ROCK,      90, 20,   0
	move FALSE_SWIPE,  EFFECT_FALSE_SWIPE,        60, PHYSICAL, NORMAL,   100, 40,   0
	move SWAGGER,      EFFECT_SWAGGER,             0, STATUS,   NORMAL,    85, 15, 100
	move WATER_PULSE,  EFFECT_CONFUSE_HIT,        60, SPECIAL,  WATER,    100, 20,  20
	move SPARK,        EFFECT_PARALYZE_HIT,       70, PHYSICAL, ELECTRIC, 100, 20,  30
	move BUG_BITE,     EFFECT_BUG_BITE,           60, PHYSICAL, BUG,      100, 20,   100
	move STEEL_WING,   EFFECT_STEEL_WING,         80, PHYSICAL, STEEL,     90, 25,  10
	move MEAN_LOOK,    EFFECT_MEAN_LOOK,           0, STATUS,   NORMAL,   100,  5,   0
	move ATTRACT,      EFFECT_ATTRACT,             0, STATUS,   NORMAL,   100, 15,   0
	move SLEEP_TALK,   EFFECT_SLEEP_TALK,          0, STATUS,   NORMAL,   100, 10,   0
	move HEAL_BELL,    EFFECT_HEAL_BELL,           0, STATUS,   NORMAL,   100,  5,   0
	move RETURN,       EFFECT_RETURN,              1, PHYSICAL, NORMAL,   100, 20,   0
	move ASTONISH,     EFFECT_FLINCH_HIT,         50, PHYSICAL, GHOST,    100, 15,  30
	move BOUNCE,       EFFECT_FLY,                90, PHYSICAL, FLYING,    85,  5,   0
	move SAFEGUARD,    EFFECT_SAFEGUARD,           0, STATUS,   NORMAL,   100, 25,   0
	move SPECTRATHIEF, EFFECT_SPECTRAL_THIEF,    100, PHYSICAL, GHOST,    100, 10,   0
	move SACRED_FIRE,  EFFECT_SACRED_FIRE,       120, PHYSICAL, FIRE,      95,  5,  50
	move MAGNITUDE,    EFFECT_MAGNITUDE,           1, PHYSICAL, GROUND,   100, 30,   0
	move DYNAMICPUNCH, EFFECT_CONFUSE_HIT,       110, PHYSICAL, FIGHTING,  50,  5, 100
	move WOOD_HAMMER,  EFFECT_RECOIL_HIT,        140, PHYSICAL, GRASS,    100, 15,   0
	move DRAGONBREATH, EFFECT_PARALYZE_HIT,       70, SPECIAL,  DRAGON,   100, 20,  30
	move BATON_PASS,   EFFECT_BATON_PASS,          0, STATUS,   NORMAL,   100, 40,   0
	move ENCORE,       EFFECT_ENCORE,              0, STATUS,   NORMAL,   100,  5,   0
	move PURSUIT,      EFFECT_PURSUIT,            50, PHYSICAL, DARK,     100, 20,   0
	move RAPID_SPIN,   EFFECT_RAPID_SPIN,         50, PHYSICAL, NORMAL,   100, 40,   0
	move SWEET_SCENT,  EFFECT_EVASION_DOWN,        0, STATUS,   NORMAL,   100, 20,   0
	move IRON_TAIL,    EFFECT_DEFENSE_DOWN_HIT,  110, PHYSICAL, STEEL,     75, 15,  30
	move METAL_CLAW,   EFFECT_METAL_CLAW,         65, PHYSICAL, STEEL,     95, 35,  10
	move VITAL_THROW,  EFFECT_ALWAYS_HIT,         85, PHYSICAL, FIGHTING, 100, 10,   0
	move MORNING_SUN,  EFFECT_MORNING_SUN,         0, STATUS,   NORMAL,   100,  5,   0
	move SYNTHESIS,    EFFECT_SYNTHESIS,           0, STATUS,   GRASS,    100,  5,   0
	move MOONLIGHT,    EFFECT_MOONLIGHT,           0, STATUS,   FAIRY,    100,  5,   0
	move VOLT_TACKLE,  EFFECT_VOLT_TACKLE,       140, PHYSICAL, ELECTRIC, 100, 15,  10
	move CROSS_CHOP,   EFFECT_NORMAL_HIT,        120, PHYSICAL, FIGHTING,  80,  5,   0
	move DRAGON_TAIL,  EFFECT_DRAGON_TAIL,        75, PHYSICAL, DRAGON,    90, 10,   0
	move RAIN_DANCE,   EFFECT_RAIN_DANCE,          0, STATUS,   WATER,     90,  5,   0
	move SUNNY_DAY,    EFFECT_SUNNY_DAY,           0, STATUS,   FIRE,      90,  5,   0
	move CRUNCH,       EFFECT_SP_DEF_DOWN_HIT,    90, PHYSICAL, DARK,     100, 15,  20
	move MIRROR_COAT,  EFFECT_MIRROR_COAT,         1, SPECIAL,  PSYCHIC,  100, 20,   0
	move AERIAL_ACE,   EFFECT_ALWAYS_HIT,         70, PHYSICAL, FLYING,   100, 20,   0
	move EXTREMESPEED, EFFECT_PRIORITY_HIT,       90, PHYSICAL, NORMAL,   100,  5,   0
	move ANCIENTPOWER, EFFECT_ANCIENTPOWER,       75, SPECIAL,  ROCK,     100,  5,  10
	move SHADOW_BALL,  EFFECT_SP_DEF_DOWN_HIT,    90, SPECIAL,  GHOST,    100, 15,  20
	move FUTURE_SIGHT, EFFECT_FUTURE_SIGHT,       90, SPECIAL,  PSYCHIC,   90, 15,   0
	move ROCK_SMASH,   EFFECT_DEFENSE_DOWN_HIT,   60, PHYSICAL, FIGHTING, 100, 15,  50
	move WHIRLPOOL,    EFFECT_WHIRLPOOL,          45, SPECIAL,  WATER,     85, 15,   0
	move PSYSTRIKE,    EFFECT_PSYSTRIKE,         110, SPECIAL,  PSYCHIC,  100, 10,   0
	move MOONBLAST,    EFFECT_SP_ATK_DOWN_HIT,   100, SPECIAL,  FAIRY,    100, 15,  30
	move FAIRY_WIND,   EFFECT_NORMAL_HIT,         50, SPECIAL,  FAIRY,    100, 30,   0
	move DAZZLINGLEAM, EFFECT_NORMAL_HIT,         90, SPECIAL,  FAIRY,    100, 10,   0
	move SHADOW_SNEAK, EFFECT_PRIORITY_HIT,       50, PHYSICAL, GHOST,    100, 30,   0
	move STRUGGLE,     EFFECT_RECOIL_HIT,         65, PHYSICAL, NORMAL,   100,  1,   0
