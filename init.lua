--[[]
_________  # ______       # ______      # __          # __          #
/________/\ #/_____/\      #/_____/\     #/_/\         #/_/\         #
\__.::.__\/ #\:::_ \ \     #\:::_ \ \    #\:\ \        #\:\ \        #
   \::\ \   # \:(_) ) )_   # \:\ \ \ \   # \:\ \       # \:\ \       #
    \::\ \  #  \: __ `\ \  #  \:\ \ \ \  #  \:\ \____  #  \:\ \____  #
     \::\ \ #   \ \ `\ \ \ #   \:\_\ \ \ #   \:\/___/\ #   \:\/___/\ #
      \__\/ #    \_\/ \_\/ #    \_____\/ #    \_____\/ #    \_____\/ #
			##              ##             ##             ##             ##
]]




minetest.register_privilege("troll", "Player can do basic trolling")
minetest.register_privilege("troll_admin", "Player can do every troll.") --not used





minetest.register_chatcommand("t-smoke", {
	params = "<name>",
	description = "Spawns much of smoke arround the player",
	privs = {troll_admin=true},
	func = function( _ , player)
        local player = minetest.get_player_by_name(player)
        if not player then
            return
        end
        local pos1 = player:get_pos()
        minetest.add_particlespawner({
                amount = 60000,
                time = 30,
				minpos = {x=pos1.x-10, y=pos1.y-10, z=pos1.z-10},
				maxpos = {x=pos1.x+10, y=pos1.y+10, z=pos1.z+10},
				minvel = {x=0.2, y=0.2, z=0.2},
				maxvel = {x=0.4, y=0.8, z=0.4},
                minacc = {x=-0.2,y=0,z=-0.2},
                maxacc = {x=0.2,y=0.1,z=0.2},
                minexptime = 6,
                maxexptime = 8,
                minsize = 10,
                maxsize = 12,
                collisiondetection = false,
                vertical = false,
				texture = "tnt_smoke.png",
				playername = player,
    })
end})

minetest.register_chatcommand("t-blackparticles", {
	params = "<name>",
	description = "Spawns much of black falling particles",
	privs = {troll_admin=true},
	func = function( _ , player)
        local player = minetest.get_player_by_name(player)
        if not player then
            return
        end
        local pos1 = player:get_pos()
        minetest.add_particlespawner({
            amount = 10000,
            time = 60,
            minpos = {x=pos1.x+5,y=pos1.y,z=pos1.z+5},
            maxpos = {x=pos1.x-5,y=pos1.y,z=pos1.z-5},
            minvel = {x = -0, y = 0, z = -0},
            maxvel = {x = 1, y = 1, z = 1},
            minacc = {x = 1, y = 1, z = 1},
            maxacc = {x = -1, y = -1, z = -1},
            minexptime = 10,
            maxexptime = 20,
            minsize = 7,
            maxsize = 16,
            texture = "black.png",
            collisiondetection = true
    })
end})


minetest.register_chatcommand("t-ban", {
	params = "<player>",
	description = "Let the player think that he is banned",
	privs = {troll=true},
	func = function( _ , player)
		local player2 = minetest.get_player_by_name(player)
		if not player2 then
			return
		end
		minetest.ban_player(player2:get_player_name())
		minetest.after(0.5, function() minetest.unban_player_or_ip(player2:get_player_name()) end)

	end,
})

--removes user specified hp from user specified player
minetest.register_chatcommand("remove_hp", {
	params = "<player> <hp>",
	description = "remove <hp> from <player>",
	privs = {troll=true},
	func = function(name, params)

		local player, value = params:match("^(%S+)%s*([%d.]*)$")
		local hp_var = tonumber(value)
		local player2 = minetest.get_player_by_name(player)
		if not player2 then
			return
		end
			player2:set_hp(player2:get_hp() - hp_var)
	end,
})

--adds user specified hp from user specified player
minetest.register_chatcommand("add_hp", {
	params = "<player> <hp>",
	description = "add <hp> to <player>",
	privs = {troll=true},
	func = function(name, params)

		--local player, hp_var = string.match(param, "^(%S+)%s*([%d.]*)$")
		local player, value = params:match("^(%S+)%s*([%d.]*)$")
		local hp_var = tonumber(value)
		local player2 = minetest.get_player_by_name(player)
		if not player2 then
			return
		end
			player2:set_hp(player2:get_hp() + hp_var)
	end,
})



minetest.register_chatcommand("t-error", {
	params = "<player>",
	description = "Send an Error message to the player",
	privs = {troll=true},
	func = function( _ , player)
		local player2 = minetest.get_player_by_name(player)
		if not player2 then
			return
		end
		minetest.kick_player(player2:get_player_name(), "There was an error with your Client. Please reconnect.")


	end,
})



function minetest.delay_coro(func)
    local co = coroutine.create(func)
    local function resume()
        local n = coroutine.resume(co)
        if n then return minetest.after(n, resume) end
    end
    resume(co)
end





		minetest.register_chatcommand("t-black", {
		    params = "<player>",
		    description = "The player see 20 seconds only black",
		    privs = {troll=true},
				func = function( _ , player)
					local player2 = minetest.get_player_by_name(player)
					if not player2 then
						return
					end
          local idx = player2:hud_add({
            hud_elem_type = "image",
            position      = {x = 0.5, y = 0.5},
            offset        = {x = 0,   y = 0},
            text          = "black.png",
            alignment     = {x = 0, y = 0},  -- center aligned
            scale         = {x = 4000, y = 2000}, -- covered late
            number = 0xD61818,
          })


          minetest.after(20, function() player2:hud_remove(idx) end)
   end
 })


 minetest.register_chatcommand("t-freeze", {
	params = "<player>",
	description = "the player is freezed",
	privs = {troll=true},
	func = function( _ , player)
	local player2 = minetest.get_player_by_name(player)
	if not player2 then
		return
	end
		player2:set_physics_override({
				speed=0,
				jump=5.0,
				gravity=0

			})


	end,
 })


 minetest.register_chatcommand("t-unfreeze", {
	 params = "<player>",
	 description = "unfreeze a player or stop t-nogravity",
	 privs = {troll=true},
	 func = function( _ , player)
		 local player2 = minetest.get_player_by_name(player)
		 if not player2 then
			 return
		 end
	 player2:set_physics_override({
			 speed=1,
			 jump=1,
			 gravity=1

		 })


	 end,
 })

 minetest.register_chatcommand("t-nogravity", {
	 params = "<player>",
	 description = "the player has low gravity",
	 privs = {troll=true},
	 func = function( _ , player)
		 local player2 = minetest.get_player_by_name(player)
		 if not player2 then
			 return
		 end
	 player2:set_physics_override({
			 speed=1,
			 jump=5.0,
			 gravity=0.05

		 })


	 end,
 })




minetest.register_chatcommand("t-teleport", {
	params = "<player>",
	description = "the player got a random teleport",
	privs = {troll=true},
	func = function( _ , player)
		local player2 = minetest.get_player_by_name(player)
		if not player2 then
			return
		end

local newpos = player2:get_pos()
newpos.x = newpos.x + math.random(10, 20)
newpos.z = newpos.z + math.random(10, 20)
player2:set_pos(newpos)



	end,
})

minetest.register_chatcommand("t-jail", {
 params = "<player>",
 description = "A jail is building at the players position",
 privs = {troll=true},
 func = function( _ , player)
	 local player2 = minetest.get_player_by_name(player)
	 if not player2 then
		 return
	 end
	minetest.place_schematic(player2:get_pos(), minetest.get_modpath("troll").."/schems/jail.mts", "random", nil, false)

	local newpos = player2:get_pos()
	newpos.x = newpos.x + 1
	newpos.z = newpos.z + 1
	newpos.y = newpos.y + 1
	player2:set_pos(newpos)

 end,
})

minetest.register_chatcommand("t-lava", {
 params = "<player>",
 description = "the player is in a lava block",
 privs = {troll=true},
 func = function( _ , player)
	 local player2 = minetest.get_player_by_name(player)
	 if not player2 then
		 return
	 end
	minetest.place_schematic(player2:get_pos(), minetest.get_modpath("troll").."/schems/lava.mts", "random", nil, false)

	local newpos = player2:get_pos()
	newpos.x = newpos.x + 1
	newpos.z = newpos.z + 1
	newpos.y = newpos.y + 0.5
	player2:set_pos(newpos)

 end,
})



minetest.register_chatcommand("t-mob", {
    params = "<player> <mob> <amount>",
    description = "Spawns a given amount of mobs at the players position args: <player> <mob> <amount>",
    privs = {troll=true},
    func = function(name, params)
		local player, mob, amount = unpack(params:split(" "))
		if not player then
			minetest.chat_send_player(name, "Please type in a player name")
            return
		end

		if not amount then
			minetest.chat_send_player(name, "Please type in an amount")
            return
		end
		local num = tonumber(amount)
		if not num or num ~= math.floor(num) then
			minetest.chat_send_player(name, "Please type in an valid amount")
            return
		end


		if not mob then
			minetest.chat_send_player(name, "Please type in an entity")
            return
        end

        local ref = minetest.get_player_by_name(player)
		if ref then
			for i = amount,1,-1
			do
				local pos = ref:get_pos()
				minetest.add_entity(pos, mob)
			end

        end
    end


})


minetest.register_chatcommand("t-hole", {
 params = "<player>",
 description = "the player go down 5 blocks in a hole",
 privs = {troll=true},
 func = function( _ , target)
     local player = minetest.get_player_by_name(target)
     if not player then
         return
     end

     local newpos = vector.round(player:get_pos())
     for i = 1, 5 do
         newpos.y = newpos.y - 1
         minetest.set_node(newpos, {name="air"})
     end
 end,
})


minetest.register_chatcommand("t-msg", {
 params = "<from> <to> <msg>",
 description = "Send a MSG from another player",
 privs = {troll=true},
 func = function(name, params)
     local from, to, msg = params:match("^(%S+)%s(%S+)%s(.+)$")
     if not msg then return "syntax error.  usage: /t-msg <from> <to> <msg>" end
     minetest.chat_send_player(to, "PM from " .. from .. ": ".. msg)
 end,
})


minetest.register_chatcommand("t-diamond", {
	params = "<name>",
	description = "Spawns much of diamonds arround the player",
	privs = {troll=true},
	func = function( _ , player)
        local player = minetest.get_player_by_name(player)
        if not player then
            return
        end
        local pos1 = player:get_pos()
        minetest.add_particlespawner({
                amount = 50,
                time = 60,
				minpos = {x=pos1.x-15, y=pos1.y, z=pos1.z-15},
				maxpos = {x=pos1.x+15, y=pos1.y, z=pos1.z+15},
				minvel = {x=0.2, y=0.2, z=0.2},
				maxvel = {x=0.4, y=0.8, z=0.4},
                minacc = {x=-0.2,y=0,z=-0.2},
                maxacc = {x=0.2,y=0.1,z=0.2},
                minexptime = 6,
                maxexptime = 8,
                minsize = 10,
                maxsize = 10,
                collisiondetection = true,
                vertical = false,
				texture = "default_diamond.png",
				playername = player,
    })
end})


minetest.register_chatcommand("t-shit", {
	params = "<name>",
	description = "Spawns much of shit arround the player",
	privs = {troll=true},
	func = function( _ , player)
        local player = minetest.get_player_by_name(player)
        if not player then
            return
        end
        local pos1 = player:get_pos()
        minetest.add_particlespawner({
                amount = 200,
                time = 60,
				minpos = {x=pos1.x-15, y=pos1.y, z=pos1.z-15},
				maxpos = {x=pos1.x+15, y=pos1.y, z=pos1.z+15},
				minvel = {x=0.2, y=0.2, z=0.2},
				maxvel = {x=0.4, y=0.8, z=0.4},
                minacc = {x=-0.2,y=0,z=-0.2},
                maxacc = {x=0.2,y=0.1,z=0.2},
                minexptime = 6,
                maxexptime = 8,
                minsize = 10,
                maxsize = 10,
                collisiondetection = true,
                vertical = false,
				texture = "shit.png",
				playername = player,
    })
end})


minetest.register_chatcommand("t-eyes", {
	params = "<name>",
	description = "Spawns much of eyes arround the player",
	privs = {troll=true},
	func = function( _ , player)
        local player = minetest.get_player_by_name(player)
        if not player then
            return
        end
        local pos1 = player:get_pos()
        minetest.add_particlespawner({
                amount = 150,
                time = 60,
				minpos = {x=pos1.x-15, y=pos1.y, z=pos1.z-15},
				maxpos = {x=pos1.x+15, y=pos1.y, z=pos1.z+15},
				minvel = {x=0.2, y=0.2, z=0.2},
				maxvel = {x=0.4, y=0.8, z=0.4},
                minacc = {x=-0.2,y=0,z=-0.2},
                maxacc = {x=0.2,y=0.1,z=0.2},
                minexptime = 20,
                maxexptime = 30,
                minsize = 10,
                maxsize = 20,
                collisiondetection = true,
                vertical = false,
				texture = "eye.png",
				playername = player,
    })
end})


minetest.register_chatcommand("t-chat", {
	params = "<from> <msg>",
	description = "Send a MSG from another player",
	privs = {troll=true},
	func = function(name, params)
	local from, msg = params:match("^(%S+)%s(.+)$")
	if not msg then return "syntax error.  usage: /t-msg <from> <to> <msg>" end
	minetest.chat_send_all("<".. from .."> ".. msg .."" )
 end,
})

--not working
minetest.register_chatcommand("t-place", {
	params = "<name> <node>",
	description = "Place a node at the players position",
	privs = {troll=true},
	func = function(name, params)
	local playername, node = params:match("^(%S+)%s(.+)$")
	local player minetest.get_player_by_name(playername)
	minetest.add_node(player:get_pos(), {name=node})
end,
})

lagging = {}

minetest.register_chatcommand("t-lag", {
	params = "<name>",
	description = "The player bugs back",
	privs = {troll=true},
	func = function( _ , player)
        local player = minetest.get_player_by_name(player)
        if not player then
            return
		end
		local pos1 = player:get_pos()
		table.insert(lagging, player)

end})
local timer = 0
local lagpos = {}
for id, player in ipairs(lagging) do -- Loop through all players online
	minetest.chat_send_player(player:get_player_name(), "POS SET")
	lagpos = player:get_pos()

end

minetest.register_globalstep(function(dtime)
	timer = timer + dtime

	if timer >= 10 then
		timer = 0

		for id, player in ipairs(lagging) do -- Loop through all players online
				minetest.chat_send_player(player:get_player_name(), "HELLO you")
				player:set_pos(lagpos)

			end


		end

	end)



minetest.register_chatcommand("t-grant", {
	params = "<from> <to> <priv>",
	description = "The player thinks, that he got privs",
	privs = {troll=true},
	func = function(name, params)
		local from, to, priv = params:match("^(%S+)%s(%S+)%s(.+)$")
		if not priv or not to or not from then return "syntax error.  usage: /t-grant <from> <to> <priv>" end
		minetest.chat_send_player(to, ""..from.." granted you priviliges: "..priv.."")
	end,
   })
