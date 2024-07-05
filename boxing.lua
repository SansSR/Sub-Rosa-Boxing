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
--i'm an idiot

local function bonehit(bone, bBody, aBody)
if not bBody.data.FieriFerret30.data.PunchCooldown then
    if not bBody.data.FieriFerret30.data.SoundPunch then
        bBody.data.FieriFerret30.data.SoundPunch = 22
    end
        if bone == 0 or bone == 1 or bone == 2 then
            if aBody.data.Armor then
            aBody.data.FieriFerret30.chestHP = aBody.data.FieriFerret30.chestHP - (aBody.vel:dist(bBody.vel) * 175) / aBody.data.Armor.PunchResistence
            else
                --aBody.data.FieriFerret30.chestHP = aBody.data.FieriFerret30.chestHP - (aBody.vel:dist(bBody.vel) * 175)
                aBody.data.FieriFerret30.chestHP = aBody.data.FieriFerret30.chestHP - math.min((aBody.vel:dist(bBody.vel) * 175), aBody.data.FieriFerret30.data.maximumDamage)
            end
            hook.run("BoxingDamage", aBody.data.FieriFerret30, bBody.data.FieriFerret30, aBody.data.FieriFerret30.chestHP)
            if aBody.data.FieriFerret30.player and aBody.data.FieriFerret30.player.data.damageIndicator and bBody.data.FieriFerret30.player and bBody.data.FieriFerret30.player.data.damageIndicator then 
                bBody.data.FieriFerret30.player:sendMessage(string.format("%s's chest is now at %s / 100", aBody.data.FieriFerret30.player.name, aBody.data.FieriFerret30.chestHP))
            end
            aBody.vel:add((bBody.vel * 2.75) * bBody.data.FieriFerret30.data.damageMulti)
        elseif bone == 4 or bone == 5 or bone == 6 then
            aBody.data.FieriFerret30.leftArmHP = aBody.data.FieriFerret30.leftArmHP - 0
            if aBody.data.FieriFerret30.player and aBody.data.FieriFerret30.player.data.damageIndicator and bBody.data.FieriFerret30.player and bBody.data.FieriFerret30.player.data.damageIndicator then 
                bBody.data.FieriFerret30.player:sendMessage(string.format("You hit %s's left arm. No damage.", aBody.data.FieriFerret30.player.name))
            end
            aBody.vel:add((bBody.vel * 2.25) * bBody.data.FieriFerret30.data.damageMulti)
        elseif bone == 7 or bone == 8 or bone == 9 then
            aBody.data.FieriFerret30.rightArmHP = aBody.data.FieriFerret30.rightArmHP - 0
            if aBody.data.FieriFerret30.player and aBody.data.FieriFerret30.player.data.damageIndicator and bBody.data.FieriFerret30.player and bBody.data.FieriFerret30.player.data.damageIndicator then 
                bBody.data.FieriFerret30.player:sendMessage(string.format("You hit %s's right arm. No damage.", aBody.data.FieriFerret30.player.name))
            end
            aBody.vel:add((bBody.vel * 2.25) * bBody.data.FieriFerret30.data.damageMulti)
        elseif bone == 10 or bone == 11 or bone == 12 then
            if aBody.data.Armor then
            aBody.data.FieriFerret30.leftLegHP = aBody.data.FieriFerret30.leftLegHP - (aBody.vel:dist(bBody.vel) * 125) / aBody.data.Armor.PunchResistence
            else
            aBody.data.FieriFerret30.leftLegHP = aBody.data.FieriFerret30.leftLegHP - (aBody.vel:dist(bBody.vel) * 125)
            end
            aBody.vel:add((bBody.vel * 2.75) * bBody.data.FieriFerret30.data.damageMulti)
            if aBody.data.FieriFerret30.player and aBody.data.FieriFerret30.player.data.damageIndicator and bBody.data.FieriFerret30.player and bBody.data.FieriFerret30.player.data.damageIndicator then 
                bBody.data.FieriFerret30.player:sendMessage(string.format("%s's left leg is now at %s / 100", aBody.data.FieriFerret30.player.name, aBody.data.FieriFerret30.leftLegHP))
            end
        elseif bone == 13 or bone == 14 or bone == 15 then
            if aBody.data.Armor then
            aBody.data.FieriFerret30.rightLegHP = aBody.data.FieriFerret30.rightLegHP - (aBody.vel:dist(bBody.vel) * 125) / aBody.data.Armor.PunchResistence
            else
            aBody.data.FieriFerret30.rightLegHP = aBody.data.FieriFerret30.rightLegHP - (aBody.vel:dist(bBody.vel) * 125)
            end
            aBody.vel:add((bBody.vel * 2.75) * bBody.data.FieriFerret30.data.damageMulti)
            if aBody.data.FieriFerret30.player and aBody.data.FieriFerret30.player.data.damageIndicator and bBody.data.FieriFerret30.player and bBody.data.FieriFerret30.player.data.damageIndicator then 
                bBody.data.FieriFerret30.player:sendMessage(string.format("%s's right leg is now at %s / 100", aBody.data.FieriFerret30.player.name, aBody.data.FieriFerret30.rightLegHP))
            end
        elseif bone == 3 then
            if aBody.data.Armor then
            aBody.data.FieriFerret30.headHP = aBody.data.FieriFerret30.headHP - (aBody.vel:dist(bBody.vel) * 345) / aBody.data.Armor.PunchResistence
            else
                --aBody.data.FieriFerret30.headHP = aBody.data.FieriFerret30.headHP - (aBody.vel:dist(bBody.vel) * 345)
                aBody.data.FieriFerret30.headHP = aBody.data.FieriFerret30.headHP - math.min((aBody.vel:dist(bBody.vel) * 345), aBody.data.FieriFerret30.data.maximumDamage)
            end
            hook.run("BoxingDamage", aBody.data.FieriFerret30, bBody.data.FieriFerret30, aBody.data.FieriFerret30.headHP)
            aBody.vel:add((bBody.vel * 8.75) * bBody.data.FieriFerret30.data.damageMulti)
            if aBody.data.FieriFerret30.player and aBody.data.FieriFerret30.player.data.damageIndicator and bBody.data.FieriFerret30.player and bBody.data.FieriFerret30.player.data.damageIndicator then 
                bBody.data.FieriFerret30.player:sendMessage(string.format("%s's head is now at %s / 100", aBody.data.FieriFerret30.player.name, aBody.data.FieriFerret30.headHP))
            end
        elseif aBody.type == 1 and bBody.data.FieriFerret30.data.CanPunchCar or aBody.type == 2 and bBody.data.FieriFerret30.data.CanPunchCar then
            aBody.vel:set((bBody.vel * 0.65) * bBody.data.FieriFerret30.data.damageMulti)
        end
        local chance = math.random(5)
        if chance > 3 then
            events.createBulletHit(3, aBody.pos, normal)
        end
    bBody.data.FieriFerret30.data.PunchCooldown = 25
	events.createSound(bBody.data.FieriFerret30.data.SoundPunch, aBody.pos, 1, 0.7 + (math.random(6) * 0.1))
	--aBody.data.FieriFerret30:getRigidBody(bone).vel:add((bBody.vel * 25))
	bBody.data.HasHit = true
   end
end

local function blocklogic(aBody, bBody)
    if aBody.data.FieriFerret30 and aBody.data.FieriFerret30.player and aBody.data.FieriFerret30.player.data.BlockedList then
    for i,v in ipairs(aBody.data.FieriFerret30.player.data.BlockedList) do
        if bBody.data.FieriFerret30 and bBody.data.FieriFerret30.player and bBody.data.FieriFerret30.player.phoneNumber == v then
            return true
        end
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
        elseif	boneB == 4 then
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
        elseif	boneB == 7 then
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
                man.data.maximumDamage = 95
            else
                man.data.isPunching = nil
                man.data.maximumDamage = 1000
                man:getRigidBody(9).data.SwingLeft = nil
                man:getRigidBody(6).data.SwingRight = nil
            end
            man.data.PunchDebounce = true
        elseif bit32.band(man.inputFlags, 1) ~= 1 and man.data.PunchDebounce then
            man.data.PunchDebounce = nil
        end

        if bit32.band(man.inputFlags, 1) == 1 and man.data.isPunching == true and not man.data.PunchDebounce2 or man.data.autoBoxerStage0 then
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
        elseif bit32.band(man.inputFlags, 1) ~= 1 and man.data.isPunching == true and man.data.SwingingGeneral or man.data.autoBoxerStage1 then
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
    for _, ply in ipairs(players.getAll()) do
        if ply.human then
            if ply.data.invis == true and ply.human.data.invis ~= true then
                ply.human.data.invis = true
            end
            if ply.data.invis == nil and ply.human.data.invis == true then
                ply.human.data.invis = nil
            end
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
        if a == nil and b == nil then
        bonehit(aBody.data.bone,bBody,aBody)
        end
    elseif aBody.data.SwingLeft and not aBody.data.HasHit or aBody.data.SwingRight and not aBody.data.HasHit then
        a = blocklogic(bBody, aBody)
        b = blocklogic(aBody, bBody)
        if a == nil and b == nil then
            bonehit(bBody.data.bone,aBody,bBody)
        end
    end
end)

    plugin:addHook("PostHumanCreate", function(man)
        for i = 0, 15 do
            man:getRigidBody(i).data.FieriFerret30 = man
            man:getRigidBody(i).data.bone = i
        end
        man.data.damageMulti = 1
    man.data.maximumDamage = 1000
        man.data.canCountToKills = true
    end)

    plugin.commands['/punch'] = { 
        info = 'Lets you punch.',
        canCall = function (ply) return ply end,
        ---@param ply Player
        ---@param args string[]
        call = function (ply, man, args)
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
    
plugin:addHook("Physics", function()
	for _, man in ipairs(humans.getAll()) do
		if man.player then
            if man.player.data.superpunch and bit32.band(man.inputFlags, 8192) == 8192 then
				man.data.superpunch = true
            else
				man.data.superpunch = false
			end
			if man.player.data.superpunch and man.data.superpunch == true then
				man.data.damageMulti = 10
            elseif man.player.data.superpunch and man.data.superpunch ~= true then
				man.data.damageMulti = 1
			end
		end
	end
end)

plugin.commands["/superpunch"] = {
	info = "Press F to superpunch, trolling cmd.",
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
				victim.human.data.damageMulti = dmgmulti
				ply:sendMessage(string.format("Gave %s a %s times KB multiplier", victim.name, dmgmulti))
			end
		end
	end,
}

plugin.commands["/punchsound"] = {
	info = "Changes the punch sound.",
	canCall = function (ply) return ply.subRosaID == 28395 or ply.subRosaID == 42799 end,
	call = function(ply, man, args)
        assert(#args >= 1, 'usage')
		local arguments = tonumber(args[1] or 1)
        if arguments >= 0 then
        man.data.SoundPunch = arguments
			ply:sendMessage("Punch sound set to : " .. arguments)
        else
            man.player:sendMessage("Your sound must be above 0!")
        end
	end,
}

plugin:addEnableHandler(function()
	tourneyTime = false
end)

plugin.commands["/damageind"] = {
    info = "Enable damage indicators",
    alias = { "/di" },
    call = function(ply, man, args)
        if tourneyTime ~= true then
	    	if ply.data.damageIndicator then
	    		ply.data.damageIndicator = nil
	    	else
	    		ply.data.damageIndicator = true
	    		ply:sendMessage("The people you hit must have this enabled.")
	    	end
	    	ply:sendMessage(string.format("Damage indicators %s enabled", ply.data.damageIndicator and "is now" or "is no longer"))
        else
            ply:sendMessage("Damage indicators are disabled during tournaments.")
        end
	end,
}

local disablePlugins = { "meleeversus", "anticheat","autoboxer", "parkourtest", "hat", "physgun", "forcechoke", "c4", "ghoul", "headless", "hyd", "shitclipdeluxe", "sand", "stasis" }

plugin.commands["/tourney"] = {
	info = "Disable features for tourneys.",
	canCall = function(ply) return ply.isAdmin or ply.isConsole end,
	call = function(ply, _, _)
	if tourneyTime == false then
            tourneyTime = true
            for _, ply in ipairs(players.getAll()) do
                ply.data.damageIndicator = nil
            end
        for i = 1, #disablePlugins do
            local pl = hook.getPluginByName(disablePlugins[i], "plugins")
            pl:disable(true)
            plugin:print(string.format("Disabling %s for tourneyTime", i))
        end
	else
		tourneyTime = false
        for i = 1, #disablePlugins do
            local pl = hook.getPluginByName(disablePlugins[i], "plugins")
            pl:enable(true)
            plugin:print(string.format("Reenabling %s for tourneyTime", i))
        end
	end
		adminLog(string.format("%s %s tournament mode.", ply.name, tourneyTime and "enabled" or "disabled"))
	end
}