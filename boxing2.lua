---@type Plugin
local plugin = ...
--New DMG and KB, whaddya think,
--nice, very nice,
--Lets see Fieris DMG and KB,
--thats very ni ce
--Now lets see Nils DMG and KB,ac
--I cant believe Diver prefers Nils boxing to mine
--You aint seen nothin yet'
--Impressive. Very nice. Let's see Koto's punching.
--i'm an idiot'

local Config = {
    BleedChance = 5, -- How likely a blood particle will apear on hit, lower means more likely (minimum 1, 0 for disabled)
    PunchSound = 22, -- Default punch sound
    PunchCooldown = 25, -- How many ticks until you are able to punch again after hitting someone
    KnockbackMultiplier = 1, -- Default knockback multiplier, increasing makes the default knockback higher, decreasing does the opposite 
    DisableBlocking = false, -- Set to true to disable the /block command
    DefaultPunching = false, -- Set to true to make players spawn in with their fists up by default
}

local Bones = {
    --Damage multiplier, Health name, Bone's name, Velocity multiplier

    [0] = {175, "chestHP", "chest"}, -- Pelvis
    [1] = {175, "chestHP", "chest"}, -- Stomach
    [2] = {175, "chestHP", "chest"}, -- Torso

    [3] = {345, "headHP", "head", 8.75}, -- Head

    [4] = {0, "leftArmHP", "left arm", 2.25}, -- Left Shoulder
    [5] = {0, "leftArmHP", "left arm", 2.25}, -- Left Forearm
    [6] = {0, "leftArmHP", "left arm", 2.25}, -- Left Hand

    [7] = {0, "rightArmHP", "right arm", 2.25}, -- Right Shoulder
    [8] = {0, "rightArmHP", "right arm", 2.25}, -- Right Forearm
    [9] = {0, "rightArmHP", "right arm", 2.25}, -- Right Hand

    [10] = {125, "leftLegHP", "left leg"}, -- Left Thigh
    [11] = {125, "leftLegHP", "left leg"}, -- Left Shin
    [12] = {125, "leftLegHP", "left leg"}, -- Left Foot

    [13] = {125, "rightLegHP", "right leg"}, -- Right Thigh
    [14] = {125, "rightLegHP", "right leg"}, -- Right Shin
    [15] = {125, "rightLegHP", "right leg"}, -- Right Foot

}

local function newHit(bone, bBody, aBody)
    

    local VicMan = aBody.data.RBHuman
                    
    local AttackMan = bBody.data.RBHuman

    if AttackMan.data.PunchCooldown then 
        return 
    end

    if Bones[bone] and VicMan then

        local CurTbl = Bones[bone]

        local DamageMulti = CurTbl[1]
        local DamagedBoneHP = VicMan[CurTbl[2]]
        local BoneName = CurTbl[3]
        local VelMulti = (CurTbl[4] or 2.75) * AttackMan.data.BoxingData.KBMulti

        VicMan[CurTbl[2]] = DamagedBoneHP - math.min( AttackMan.data.BoxingData.MaxDMG, (aBody.vel:dist(bBody.vel) * DamageMulti) )

        aBody.vel:add( bBody.vel * VelMulti )

        events.createSound(AttackMan.data.SoundPunch or Config.PunchSound, aBody.pos, 1, 0.7 + (math.random(6) * 0.1))

        local BleedChance = Config.BleedChance > 0 and math.random(Config.BleedChance)

        if BleedChance == 1 then
            events.createBulletHit(3, aBody.pos, normal)
        end

        AttackMan.data.PunchCooldown = 25
        bBody.data.HasHit = true


        -- EXTRAS --

        if AttackMan.player and VicMan.player and VicMan.player.data.damageIndicator and AttackMan.player.data.damageIndicator then
            if DamageMulti ~= 0 then
                AttackMan.player:sendMessage( string.format("%s's %s is now at %s / 100", VicMan.player.name, BoneName, DamagedBoneHP) )
            else
                AttackMan.player:sendMessage( string.format("You hit %s's %s. No damage.", VicMan.player.name, BoneName) )
            end
        end

        if bone >= 0 and bone <= 3 then
            hook.run("BoxingDamage", VicMan, AttackMan, DamagedBoneHP)
        end

        ------------

    end

end

local function blocklogic(aBody, bBody)

    local Human1 = aBody.data.RBHuman
    local Human2 = bBody.data.RBHuman

    if not Human1 or not Human2 then
        return 
    end

    if not Human1.player or not Human2.player then
        return
    end
    
    if Human1.player.data.BlockedList then

        if Human1.player.data.BlockedList[Human2.player.phoneNumber] then
            return true
        end

    end
end

local function punchidle(man, boneT, boneB, dest, rot, vecA, float, floatRot, floatStr, vecB, vecC, flags)
    if boneT == 2 then

        if boneB == 4 then
            dest:set(Vector(0.1, 0, -0.25))
        elseif boneB == 7 then
            dest:set(Vector(-0.1, 0, -0.25))
        end

    end
end

--right arm swing
local function punchturnleft(man, boneT, boneB, dest, rot, vecA, float, floatRot, floatStr, vecB, vecC, flags)
    if boneT == 2 then

        if boneB == 7 then
            floatStr.value = 1
            rot:set(yawToRotMatrix(0.4))
            dest:set(Vector(-0.1, 0, -1))
        elseif boneB == 4 then
            floatStr.value = 1
            dest:set(Vector(0, -0.1, 0))
        end

    end
end

--left arm swing
local function punchturnright(man, boneT, boneB, dest, rot, vecA, float, floatRot, floatStr, vecB, vecC, flags)
    if boneT == 2 then

        if boneB == 4 then
            floatStr.value = 1
            rot:set(yawToRotMatrix(-0.4))
            dest:set(Vector(0.1, 0, -1))
        elseif boneB == 7 then
            floatStr.value = 1
            dest:set(Vector(0, -0.1, 0))
        end

    end
end

local function block(man, boneT, boneB, dest, rot, vecA, float, floatRot, floatStr, vecB, vecC, flags)
    if boneT == 2 then

        if boneB == 4 then
            floatStr.value = 1
            rot:set(yawToRotMatrix(-1))
            dest:set(Vector(0.02, 0.2, -0.3))
        elseif boneB == 7 then
            floatStr.value = 1
            rot:set(yawToRotMatrix(1))
            dest:set(Vector(-0.02, 0.2, -0.3))
        end

    end
end

plugin:addHook("Logic", function()
    for _, man in ipairs(humans.getAll()) do

        if man.data.isPunching and man.data.emote ~= "none" then
            man.data.emote = "none"
        end

        if man.data.PunchCooldown then
            man.data.PunchCooldown = man.data.PunchCooldown - 1
            if man.data.PunchCooldown <= 0 then
                man.data.PunchCooldown = nil
            end
        end

        if bit32.band(man.inputFlags, 16) == 16 and bit32.band(man.inputFlags, 8) == 8 and bit32.band(man.inputFlags, 1) == 1 and not man.data.PunchDebounce and man.player and man.player.data.CanPunch then
            
            if man.data.isPunching == nil then
                man.data.isPunching = true
                man.data.BoxingData.MaxDMG = 95
            else
                man.data.isPunching = nil
                man.data.BoxingData.MaxDMG = 1000
                man:getRigidBody(9).data.SwingLeft = nil
                man:getRigidBody(6).data.SwingRight = nil
            end

            man.data.PunchDebounce = true

        elseif bit32.band(man.inputFlags, 1) ~= 1 and man.data.PunchDebounce then
            man.data.PunchDebounce = nil
        end

        if bit32.band(man.inputFlags, 1) == 1 and man.data.isPunching == true and not man.data.PunchDebounce2 then

            if man.data.LookingLeft then
                man:getRigidBody(6).data.SwingRight = nil
                man:getRigidBody(9).data.SwingLeft = true
                man.data.SwingingGeneral = true
            elseif man.data.LookingRight then
                man:getRigidBody(9).data.SwingLeft = nil
                man:getRigidBody(6).data.SwingRight = true
                man.data.SwingingGeneral = true
            end

            man.data.PunchDebounce2 = true

        elseif bit32.band(man.inputFlags, 1) ~= 1 and man.data.isPunching == true and man.data.SwingingGeneral then
            man.data.SwingingGeneral = nil
            man:getRigidBody(6).data.SwingRight = nil
            man:getRigidBody(9).data.SwingLeft = nil
            man:getRigidBody(6).data.HasHit = nil
            man:getRigidBody(9).data.HasHit = nil
            if not man.data.isBlocking then
                man.data.PunchDebounce2 = nil
            end
            
        elseif bit32.band(man.inputFlags, 2) == 2 and man.data.isPunching then
            man.data.isBlocking = true
            man.data.PunchDebounce2 = true

        elseif bit32.band(man.inputFlags, 2) == 2 and not man.data.isPunching and man.data.isBlocking then
            man.data.isBlocking = nil
            man.data.PunchDebounce2 = nil 

        elseif bit32.band(man.inputFlags, 2) ~= 2 and man.data.isBlocking then
            man.data.isBlocking = nil
            man.data.PunchDebounce2 = nil 
        end

        if man:getRigidBody(3).rotVel.y2 <= -0.01 and not man.data.SwingingGeneral then
            man.data.LookingRight = nil
            man.data.LookingLeft = true
        elseif man:getRigidBody(3).rotVel.y2 >= 0.01 and not man.data.SwingingGeneral then
            man.data.LookingRight = true
            man.data.LookingLeft = nil
        end

    end

end)

plugin:addHook("HumanLimbInverseKinematics", function(man, boneT, boneB, dest, rot, vecA, float, floatRot, floatStr, vecB, vecC, flags)
    if man.data.isPunching and man.data.SwingingGeneral == nil and not man.data.isBlocking then
        punchidle(man, boneT, boneB, dest, rot, vecA, float, floatRot, floatStr, vecB, vecC, flags)
    elseif man.data.isPunching and man:getRigidBody(9).data.SwingLeft and bit32.band(man.inputFlags, 4) ~= 4 and not man.data.PunchCooldown or man.data.isPunching and man:getRigidBody(9).data.SwingLeft and not man.data.PunchCooldown and man.data.autoBoxerStage0 then
        punchturnleft(man, boneT, boneB, dest, rot, vecA, float, floatRot, floatStr, vecB, vecC, flags)
    elseif man.data.isPunching and man:getRigidBody(6).data.SwingRight and bit32.band(man.inputFlags, 4) ~= 4 and not man.data.PunchCooldown or man.data.isPunching and man:getRigidBody(6).data.SwingRight and not man.data.PunchCooldown and man.data.autoBoxerStage0 then
        punchturnright(man, boneT, boneB, dest, rot, vecA, float, floatRot, floatStr, vecB, vecC, flags)
    elseif man.data.isBlocking then
        block(man, boneT, boneB, dest, rot, vecA, float, floatRot, floatStr, vecB, vecC, flags)
    end
end)


plugin:addHook("CollideBodies", function(aBody, bBody, aLocalPos, bLocalPos)
    if bBody.data.SwingLeft and not bBody.data.HasHit or bBody.data.SwingRight and not bBody.data.HasHit then
        a = blocklogic(aBody, bBody)
        b = blocklogic(bBody, aBody)

        if not a and not b then
            newHit(aBody.data.bone,bBody,aBody)
        end

    elseif aBody.data.SwingLeft and not aBody.data.HasHit or aBody.data.SwingRight and not aBody.data.HasHit then
        a = blocklogic(bBody, aBody)
        b = blocklogic(aBody, bBody)

        if not a and not b then
            newHit(bBody.data.bone,aBody,bBody)
        end
    end
end)

plugin:addHook("PostHumanCreate", function(man)
        
    for i = 0, 15 do
        man:getRigidBody(i).data.RBHuman = man
        man:getRigidBody(i).data.bone = i
    end

    man.data.BoxingData = {
        KBMulti = Config.KnockbackMultiplier,
        MaxDMG = 1000,
    }

    if Config.DefaultPunching and man.player then
        man.data.isPunching = true
        man.data.BoxingData.MaxDMG = 95
        man.player.data.CanPunch = true
    end
        
end)

plugin.commands['/punch'] = { 
    info = 'Lets you punch.',

    call = function(ply, man, args)

        if ply.data.CanPunch == nil then
            ply.data.CanPunch = true
            ply:sendMessage("Punching now available! Ctrl+Shift+LMB to do so.")
        else
            ply:sendMessage("Punching disabled, type /punch to renable.")
            ply.data.CanPunch = nil
            man.data.isPunching = nil
        end
                
    end
}


local superPunchers = {}
local inactiveSPers = {}
    
plugin:addHook("Physics", function()

    for ind, man in ipairs(superPunchers) do
        
        if man.player and man.player.data.superpunch then
            if bit32.band(man.inputFlags, 8192) == 8192 then
                man.data.BoxingData.KBMulti = 10
            else
                man.data.BoxingData.KBMulti = 1
            end
        else
            table.insert( inactiveSPers, ind )
        end

    end

    for _, indTbl in ipairs(inactiveSPers) do
        table.remove(superPunchers, indTbl)
    end

    inactiveSPers = {}
end)

plugin.commands["/superpunch"] = {
	info = "Press F to superpunch.",
        canCall = function (ply) return ply.isAdmin end,
	call = function(ply, man, args)
		if ply.data.superpunch then
            ply.data.superpunch = nil
			ply:sendMessage("Superpunch disabled.")
		else
            ply.data.superpunch = true
			ply:sendMessage("Superpunch enabled.")
		end
	end,
}

plugin.commands["/givekb"] = {
	info = "Give punch knockback.",
	usage = "'name' 'amount'",
	canCall = function(ply) return ply.isConsole or ply.isAdmin end,
	---@param ply Player
	---@param args string[]
	call = function(ply, _, args)
		assert(#args >= 1, "usage")

		local victim = findOnePlayer(table.remove(args, 1))
		local dmgmulti = math.floor(tonumber(table.remove(args, 1)) or 1)

        if dmgmulti == nil or dmgmulti > 101 or dmgmulti < 0 then
			ply:sendMessage("Invalid number.")
		else
			if victim.human then
				victim.human.data.BoxingData.KBMulti = dmgmulti
				ply:sendMessage(string.format("Gave %s a %s times KB multiplier", victim.name, dmgmulti))
			end

		end

	end,
}

plugin.commands["/punchsound"] = {
	info = "Changes your punch sound.",
	canCall = function (ply) return ply.isAdmin end,
	call = function(ply, man, args)
        assert(#args >= 1, usage)
		local arguments = tonumber(args[1] or 1)

        if arguments >= 0 then
            man.data.SoundPunch = arguments
			ply:sendMessage("Punch sound set to : " .. arguments)
        else
            ply:sendMessage("Your sound must be above 0!")
        end

	end,
}

plugin.commands["/damageind"] = {
    info = "Enable damage indicators",
    alias = { "/di" },
    call = function(ply, man, args)
        
        if ply.data.damageIndicator then
            ply:sendMessage("Damage indicators is now disabled.")
            ply.data.damageIndicator = nil

        else
            ply:sendMessage("The people you hit must have this enabled.")
            ply:sendMessage("Damage indicators is now enabled")
            ply.data.damageIndicator = true
            
        end

	end,
}

plugin.commands['/block'] = {
	info = 'Block a person from punching you.',
	usage = '<phoneNumber/name>',
    
    canCall = function(ply) return not Config.DisableBlocking or ply.isAdmin end,

	call = function (ply, _, args)
		assert(#args >= 1, usage)

		local acc = findOnePlayer(table.remove(args, 1))

        if not acc then
            ply:sendMessage("Player not found!")
            return
        end

		if acc and acc.phoneNumber ~= ply.phoneNumber then
            
            ply:sendMessage(accPly.name .. " Blocked successfully!")
            ply.data.BlockedList[accPly.phoneNumber] = true
            plugin:print(string.format("%s blocked %s.", ply.name, accPly.name))

        else
            ply:sendMessage("You can't block yourself!")
		end

	end
}


plugin.commands['/unblock'] = {
	info = 'Unblock a player.',
	usage = '<phoneNumber/name>',

    canCall = function(ply) return not Config.DisableBlocking or ply.isAdmin end,

	call = function (ply, _, args)

		assert(#args >= 1, usage)

		local acc = findOnePlayer(table.remove(args, 1))

        if not acc then
            ply:sendMessage("Player not found!")
            return
        end

		if acc and acc.phoneNumber ~= ply.phoneNumber then

            ply.data.BlockedList[accPly.phoneNumber] = nil

			plugin:print(string.format("%s unblocked %s.", ply.name, accPly.name))
            ply:sendMessage(accPly.name .. " Unblocked successfully!")

        else
            ply:sendMessage("You are not blocked!")
		end
	end
}

local function returnBool(val)

    if val == "true" then
        return true
    elseif val == "false" then
        return false 
    end

end

--[[
EXAMPLE:
/editcfg DisableBlocking true
^ Disables /block

EXAMPLE 2:

/editcfg KnockbackMultiplier 25
^ Sets the default knockback multiplier to 25


(you can replace /editcfg with /ec)
]]


plugin.commands['/editcfg'] = {
	info = 'Edit the boxing config',
	usage = 'Config, Value',
    alias = {"/ec"},

    canCall = function(ply) return ply.isAdmin or ply.isConsole end,

	call = function (ply, _, args)

		assert(#args >= 1, usage)

        local CFG = args[1]
        local Value = args[2]

        Value = tonumber(Value) or returnBool(Value) or Value

        if not Config[CFG] then
            messagePlayerWrap(ply, string.format("%s is not apart of the config!", CFG) )
            return
        end

        if type(Config[CFG]) ~= type(Value) then
            messagePlayerWrap(ply, string.format("'%s' is not the same type of value as '%s'! (%s required)", Value, Config[CFG], type(Config[CFG])) )
            return
        end

        Config[CFG] = Value

        messagePlayerWrap(ply, string.format("Successfully set value %s to %s!", CFG, Value) )


	end
}

