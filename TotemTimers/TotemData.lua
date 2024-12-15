-- Copyright © 2008, 2009 Xianghar  <xian@zron.de>
-- All Rights Reserved.
-- This code is not to be modified or distributed without written permission by the author.
-- Current distribution permissions only include curse.com, wowui.worldofwar.net, wowinterface.com and their respective addon updaters

TotemTimers = {}

TotemTimers.AvailableSpells = {}
TotemTimers.AvailableSpellIDs = {}
TotemTimers.MaxSpellIDs = {}
TotemTimers.AvailableTalents = {}

TotemTimers.SpellIDs = {
    StoneSkin = 25509,
    StoneClaw = 25525,
    EarthBind = 2484,
    StrengthOfEarth = 25528,
    Tremor = 8143,
    EarthElemental = 2062,
    
    Searing = 25533,
    FireNova = 25547,
    Magma = 25552,
    FlameTongue = 25557,
    FrostResistance = 25560,
    Wrath = 30706,
    FireElemental = 2894,
    
    Cleansing = 8170,
	Poison = 8166,
    HealingStream = 25567,
    FireResistance = 25563,
    ManaSpring = 25570,
    ManaTide = 16190,
    
    Grounding = 8177,
    NatureResistance = 25574,
    Sentry = 6495,
    Windfury = 25587,
    WrathOfAir = 3738,
    GraceOfAir = 25359,
	WindWall = 25577,
	TranquilAir = 25908,
	
    Ankh = 20608,
    LightningShield = 25472,
    WaterShield = 33736,
    EarthShield = 32594,
    TotemicCall = 36936,
    WindfuryWeapon = 25505,
    RockbiterWeapon = 25485,
    FlametongueWeapon = 25489,
    FrostbrandWeapon = 25500,
    EarthlivingWeapon = 51994,
    
    StormStrike = 17364,
    EarthShock = 25454,
    FrostShock = 25464,
    FlameShock = 25457,
    LavaLash = 60103,
    Maelstrom = 51532,
    LightningBolt = 25449,
    ChainLightning = 25442,
    LavaBurst = 60043,
    Maelstrom = 53819,
    WindShear = 57994,
    ShamanisticRage = 30823,
    FeralSpirit = 51533,
    ElementalMastery = 16166,
    Thunderstorm = 51490,
    
    CallofSpirits = 66844,
    CallofElements = 66842,
    CallofAncestors = 66843,
}

TotemTimers.BuffIDs = {
    StoneSkin = 25507,
    StrengthOfEarth = 25527,
    FlameTongue = 25554,
    FrostResistance = 25559,
    Wrath = 30708,
    FireResistance = 25562,
    ManaSpring = 25569,
    ManaTide = 16191,
    Grounding = 8178,
    NatureResistance = 25573,
    Windfury = 25580,
    WrathOfAir = 2895,
    GraceOfAir = 25360,
	WindWall = 25576,
	TranquilAir = 25909,
	
    FrostResistancePala = 27152,
    FireResistancePala = 27153,
    NatureResistanceHunter = 27045,
    IcyTalons = 55789,
    IcyTalonsSelf1 = 50887,
    IcyTalonsSelf2 = 50886,
    HornOfWinter = 57623,
    DemonicPact = 47240,
    BoW = 27142,
    GBoW = 27143,
}

TotemTimers.SpellTextures = {}
TotemTimers.SpellNames = {}

for k,v in pairs(TotemTimers.SpellIDs) do
    local n,_,t = GetSpellInfo(v)
    TotemTimers.SpellTextures[v] = t
    TotemTimers.SpellNames[v] = n
end

TotemTimers.BuffNames = {}
for k,v in pairs(TotemTimers.BuffIDs) do
    local n = GetSpellInfo(v)
    TotemTimers.BuffNames[v] = n
end

--[[
1 - Melee
2 - Ranged
3 - Caster
4 - Healer
5 - Hybrid (mostly Enh. Shaman)
]]


TotemData = {
	[TotemTimers.SpellNames[TotemTimers.SpellIDs.StoneSkin]] = {
		element = EARTH_TOTEM_SLOT,
        hasBuff = TotemTimers.BuffIDs.StoneSkin,
        needed = {[1]=true,[2]=true,[3]=true,[4]=true,[5]=true,},
	},
	[TotemTimers.SpellNames[TotemTimers.SpellIDs.StrengthOfEarth]] = {
		element = EARTH_TOTEM_SLOT,
        hasBuff = TotemTimers.BuffIDs.StrengthOfEarth,
       needed = {[1]=true,[2]=true,[3]=true,[4]=true,[5]=true,},
	},
	[TotemTimers.SpellNames[TotemTimers.SpellIDs.StoneClaw]] = {
		element = EARTH_TOTEM_SLOT,
        noRangeCheck = true,
	},
	[TotemTimers.SpellNames[TotemTimers.SpellIDs.Tremor]] = {
		element = EARTH_TOTEM_SLOT,
		flashInterval = 4,
		flashDelay = 2.5,
        partyOnly = true,
	},
	[TotemTimers.SpellNames[TotemTimers.SpellIDs.EarthBind]] = {
		element = EARTH_TOTEM_SLOT,
		flashInterval = 3,
		flashDelay = 0,
        noRangeCheck = true,
	},
	[TotemTimers.SpellNames[TotemTimers.SpellIDs.EarthElemental]] = {
		element = EARTH_TOTEM_SLOT,
        noRangeCheck = true,
	},
	[TotemTimers.SpellNames[TotemTimers.SpellIDs.Searing]] = {
		element = FIRE_TOTEM_SLOT,
        noRangeCheck = true,
	},
	[TotemTimers.SpellNames[TotemTimers.SpellIDs.Magma]] = {
		element = FIRE_TOTEM_SLOT,
        noRangeCheck = true,
	},
	[TotemTimers.SpellNames[TotemTimers.SpellIDs.FireNova]] = {
		element = FIRE_TOTEM_SLOT,
        noRangeCheck = true,
	},
	[TotemTimers.SpellNames[TotemTimers.SpellIDs.FlameTongue]] = {
		element = FIRE_TOTEM_SLOT,
        hasBuff = TotemTimers.BuffIDs.FlameTongue,
        needed={[3]=true,[5]=true,},
        moreBuffs = {TotemTimers.BuffIDs.DemonicPact, TotemTimers.BuffIDs.Wrath},
	},	
	[TotemTimers.SpellNames[TotemTimers.SpellIDs.FrostResistance]] = {
		element = FIRE_TOTEM_SLOT,
        hasBuff = TotemTimers.BuffIDs.FrostResistance,
        needed = {[1]=true,[2]=true,[3]=true,[4]=true,[5]=true,},
        moreBuffs = {TotemTimers.BuffIDs.FrostResistancePala},
	},
	[TotemTimers.SpellNames[TotemTimers.SpellIDs.Wrath]] = {
		element = FIRE_TOTEM_SLOT,
        hasBuff = TotemTimers.BuffIDs.Wrath,
        needed = {[3]=true,[5]=true,}
	},
	[TotemTimers.SpellNames[TotemTimers.SpellIDs.FireElemental]] = {
		element = FIRE_TOTEM_SLOT,
        noRangeCheck = true,
	},	
	[TotemTimers.SpellNames[TotemTimers.SpellIDs.Cleansing]] = {
		element = WATER_TOTEM_SLOT,
		flashInterval = 3,
		flashDelay = 0,
        partyOnly = true,
	},	
	[TotemTimers.SpellNames[TotemTimers.SpellIDs.Poison]] = {
		element = WATER_TOTEM_SLOT,
		flashInterval = 5,
		flashDelay = 0,
        partyOnly = true,
	},	
	[TotemTimers.SpellNames[TotemTimers.SpellIDs.HealingStream]] = {
		element = WATER_TOTEM_SLOT,
        partyOnly = true,
	},
	[TotemTimers.SpellNames[TotemTimers.SpellIDs.FireResistance]] = {
		element = WATER_TOTEM_SLOT,
        hasBuff = TotemTimers.BuffIDs.FireResistance,
		needed = {[1]=true,[2]=true,[3]=true,[4]=true,[5]=true,},
        moreBuffs = {TotemTimers.BuffIDs.FireResistancePala},
	},
	[TotemTimers.SpellNames[TotemTimers.SpellIDs.ManaSpring]] = {
		element = WATER_TOTEM_SLOT,
		hasBuff = TotemTimers.BuffIDs.ManaSpring,
		needed = {[2]=true,[3]=true,[4]=true,[5]=true,},
        moreBuffs = {TotemTimers.BuffIDs.BoW, TotemTimers.BuffIDs.GBoW},
	},
	[TotemTimers.SpellNames[TotemTimers.SpellIDs.ManaTide]] = {
		element = WATER_TOTEM_SLOT,
        partyOnly = true,
	},
	[TotemTimers.SpellNames[TotemTimers.SpellIDs.Grounding]] = {
		element = AIR_TOTEM_SLOT,
        hasBuff = TotemTimers.BuffIDs.Grounding,
        needed = {[1]=true,[2]=true,[3]=true,[4]=true,[5]=true,},
        partyOnly = true,
	},
	[TotemTimers.SpellNames[TotemTimers.SpellIDs.NatureResistance]] = {
		element = AIR_TOTEM_SLOT,
        hasBuff = TotemTimers.BuffIDs.NatureResistance,
        needed = {[1]=true,[2]=true,[3]=true,[4]=true,[5]=true,},
        moreBuffs = {TotemTimers.BuffIDs.NatureResistanceHunter},
    },
	[TotemTimers.SpellNames[TotemTimers.SpellIDs.Sentry]] = {
		element = AIR_TOTEM_SLOT,
        noRangeCheck = true,
	},
	[TotemTimers.SpellNames[TotemTimers.SpellIDs.Windfury]] = {
		element = AIR_TOTEM_SLOT,
		flashInterval = 5,
		flashDelay = 0,
        partyOnly = true,
	},
	[TotemTimers.SpellNames[TotemTimers.SpellIDs.WrathOfAir]] = {
		element = AIR_TOTEM_SLOT,
        hasBuff = TotemTimers.BuffIDs.WrathOfAir,
        needed = {[3]=true,[4]=true,},
	},
	[TotemTimers.SpellNames[TotemTimers.SpellIDs.GraceOfAir]] = {
		element = AIR_TOTEM_SLOT,
        hasBuff = TotemTimers.BuffIDs.GraceOfAir,
        needed = {[3]=true,[4]=true,},
	},
	[TotemTimers.SpellNames[TotemTimers.SpellIDs.WindWall]] = {
		element = AIR_TOTEM_SLOT,
        hasBuff = TotemTimers.BuffIDs.WindWall,
        needed = {[3]=true,[4]=true,},
	},
	[TotemTimers.SpellNames[TotemTimers.SpellIDs.TranquilAir]] = {
		element = AIR_TOTEM_SLOT,
        hasBuff = TotemTimers.BuffIDs.TranquilAir,
        needed = {[3]=true,[4]=true,},
	},
}

TotemTimers_Spells = {}

TotemTimers.TextureToName = {}
for k,v in pairs(TotemTimers.SpellIDs) do
    if TotemData[TotemTimers.SpellNames[v]] then
        TotemTimers.TextureToName[TotemTimers.SpellTextures[v]] = TotemTimers.SpellNames[v]
    end
end
TT_EMPTY_ICON = "Spell_Totem_WardOfDraining"
