-----------------------------------------------------------
--
--
-----------------------------------------------------------

minetest.register_privilege(
   "toz",
   {  description = "Allows use of the /toz command.",
      give_to_singleplayer = false
   });

-----------------------------------------------------------

local toz_info = function(player)
  local dir = player:get_look_dir()
  local pos = player:get_pos()
  local name = player:get_player_name()
  minetest.chat_send_player(name, "player: "..dump(name));
  minetest.chat_send_player(name, " dir: "..dump(dir));
  minetest.chat_send_player(name, " pos: "..dump(pos));
end

-----------------------------------------------------------

local toz_clr = function(player, param)
  local dir = player:get_look_dir()
  local pos = player:get_pos()
  local node =  minetest.get_node({x=pos.x,y=pos.y-1,z=pos.z})
   for X=-param,param do
     for Z=-param,param do
       local ipos = {  x=math.floor(pos.x)+X,
                       y=math.floor(pos.y),
                       z=math.floor(pos.z)+Z,
                    }
        if param ~= nil then
          minetest.set_node(ipos, node)
        end
     end
   end

end

-----------------------------------------------------------

minetest.register_chatcommand(
   "tozinfo",
   {  params = "<name>",
      description = "Executes a tozinfo",
      privs = { toz = true },
      func = function(playerName)
        local player = minetest.get_player_by_name(playerName)
         toz_info(player)
      end
   });

-----------------------------------------------------------

minetest.register_chatcommand(
   "tozclr",
   {  params = "<name> <param>",
      description = "Executes a tozclr",
      privs = { toz = true },
      func = function(playerName,param)
        local player = minetest.get_player_by_name(playerName)
         toz_clr(player,param)
      end
   });
