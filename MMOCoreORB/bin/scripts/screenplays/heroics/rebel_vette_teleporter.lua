local ObjectManager = require("managers.object.object_manager")

rebel_vette_teleporter = ScreenPlay:new { 
  numberOfActs = 1, 
  questString = "rebel_vette_teleporter_queststring", --This needs to be unique! If not unique you will not pull the proper conversation.
  states = {}, --Blank, as we don't need screenplay states to teleport someone. It remains in-case we need to add it though.
  
  --This is basic quest related, doesn't harm and doesn't really do anything (I keep it for goodluck :P)
  questdata = Object:new {
    activePlayerName = "initial",
  }
}

registerScreenPlay("rebel_vette_teleporter", true) --Initialize the screenplay IAW the screenplay include

--Simply spawns the NPC
function imperial_isd_teleporter:start()
   spawnMobile("dungeon2", "rebel_vette_teleporter", 1, -37.9, 0, 0.9, 110, 480000160)  --disabled until jakku focus test is completed.

end

--The actual conversation handler
rebel_vette_teleporter_convo_handler = Object:new {
  
 }


function rebel_vette_teleporter_convo_handler:getNextConversationScreen(pConversationTemplate, pConversingPlayer, selectedOption)
  local convosession = CreatureObject(pConversingPlayer):getConversationSession()

  local lastConversationScreen = nil

  if (convosession ~= nil) then
    local session = LuaConversationSession(convosession)
    lastConversationScreen = session:getLastConversationScreen()
  end

  local conversation = LuaConversationTemplate(pConversationTemplate)

  local nextConversationScreen

  if (lastConversationScreen ~= nil) then
    local luaLastConversationScreen = LuaConversationScreen(lastConversationScreen)

    --Get the linked screen for the selected option.
    local optionLink = luaLastConversationScreen:getOptionLink(selectedOption)

    nextConversationScreen = conversation:getScreen(optionLink)

    if nextConversationScreen ~= nil then
      local nextLuaConversationScreen = LuaConversationScreen(nextConversationScreen)
    else
      nextConversationScreen = conversation:getScreen("first_conv")
    end
  else
    nextConversationScreen = conversation:getScreen("first_conv")
  end
  return nextConversationScreen
end


function rebel_vette_teleporter_convo_handler:runScreenHandlers(pConversationTemplate, pConversingPlayer, pConversingNpc, selectedOption, pConversationScreen)
  local screen = LuaConversationScreen(pConversationScreen)
  local screenID = screen:getScreenID() 

  
  local player = LuaSceneObject(pConversingPlayer)

  if ( screenID == "mayor2" ) then
   
     player:switchZone("chandrila", 178, 6, -2961, 0) -- x, z, y, cell

  end
  
  
  --print("returning convosvreen")
  return pConversationScreen
end