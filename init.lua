-----------------------------------------------------------
--
--
-----------------------------------------------------------

minetest.register_privilege(
   "toz",
   {  description = "Allows use of the /toz command.",
      give_to_singleplayer = true
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
  param = tonumber(param)
  if (param>=1) and (param<=100) then
    for X=-param,param do
      for Z=-param,param do
        local ipos = {  x=math.floor(pos.x)+X,
                        y=math.floor(pos.y),
                        z=math.floor(pos.z)+Z,
                     }
        minetest.set_node(ipos, node)
      end
    end
  end
end

-----------------------------------------------------------

local toz_clrh = function(player, param)
  local dir = player:get_look_dir()
  local pos = player:get_pos()
  local bpos = {x=math.floor(pos.x),y=math.floor(pos.y)-1,z=math.floor(pos.z)}
  local node =  minetest.get_node(bpos)
  param = tonumber(param)
  if (param>=1) and (param<=100) then
    for X=-param,param do
      for Z=-param,param do

        local ipos = {  x = bpos.x + X,
                        y = bpos.y ,
                        z = bpos.z + Z,
                     }

        if (X==0 and Z==0) then
          -- nop
        elseif ((X==-param) or (X==param) or (Z==-param) or (Z==param)) then
          minetest.set_node(ipos, node)
        else
          minetest.set_node(ipos, {name="air"})
        end

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
      description = "sets rectangular section of size <param> with block under player",
      privs = { toz = true },
      func = function(playerName,param)
        local player = minetest.get_player_by_name(playerName)
         toz_clr(player,param)
      end
   });

-----------------------------------------------------------

minetest.register_chatcommand(
   "tozclrh",
   {  params = "<name> <param>",
      description = "clears hollow rectangular section of size <param> with block under player",
      privs = { toz = true },
      func = function(playerName,param)
        local player = minetest.get_player_by_name(playerName)
         toz_clrh(player,param)
      end
   });
