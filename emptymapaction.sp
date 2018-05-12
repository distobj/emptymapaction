/*

emptymapaction.sp



Description:

    Takes a configured action on a map when the last human player disconnects


Versions:

    1.0

        * Initial Release

*/

#include <sourcemod>
#include <sdktools>

#pragma semicolon 1
#define PLUGIN_VERSION "1.0.0"
#define MAX_FILE_LEN 80

new Handle:g_CvarEnabled = INVALID_HANDLE;
new Handle:g_CvarAction = INVALID_HANDLE;


// Plugin definitions
public Plugin:myinfo = 
{
    name = "EmptyMapAction",
    author = "distobj",
    description = "Empty Map Action",
    version = PLUGIN_VERSION,
    url = "http://forums.alliedmods.net"
}

public OnPluginStart()
{
    g_CvarEnabled = CreateConVar("sm_emptymapaction_enabled", "1", "Enables the EmptyMapAction plugin");
    g_CvarAction = CreateConVar("sm_emptymapaction_action", "0", "Action to take upon all players disconnecting: 0 = restart, 1 = nextmap");

    HookEvent("player_disconnect", PlayerDisconnect, EventHookMode_Post);
}

public PlayerDisconnect(Handle:event, const String:name[], bool:dontBroadcast)
{
    if (!GetConVarBool(g_CvarEnabled))
    {
        return;
    }

    // ignore bot disconnects
    if (GetEventBool(event, "bot"))
    {
        return;
    }

    // grab userid so we can disregard the dropping user when counting humans
    int droppingUserId = GetEventInt(event, "userid");

    // despite only needing a bool, count using shortcut int to simplify debugging
    int humanCount = 0;
    for(int i = 1; i <= MaxClients; i++)
    {
        if (IsClientConnected(i) && (!IsFakeClient(i)) && (GetClientUserId(i) != droppingUserId))
        {
            humanCount += 1;
        }
    }  

    //PrintToServer("humanCount = %d", humanCount);

    if (humanCount == 0)
    {
        decl String: Map[32]; 
        switch(GetConVarInt(g_CvarAction)) {
            case 1: {
                LogMessage("No humans detected, forcing next map");
                GetNextMap(Map, sizeof(Map));
                ForceChangeLevel(Map, "Forcing next map");
            }
            default: {
                LogMessage("No humans detected, restarting map");
                GetCurrentMap(Map, sizeof(Map));
                ForceChangeLevel(Map, "Restarting map");
            }
        }
    }
}
