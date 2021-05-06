#pragma semicolon 1
#pragma newdecls required

#include <sourcemod>
#include <sdktools>
#include <sdkhooks>
#include <cstrike>

public Plugin my_info =
{
	name = "NoDamage",
	author = "rdbo",
	description = "NoDamage",
	version = "1.0",
	url = ""
}

ConVar sm_nodamage;

 public Action OnTakeDamage(int victim, int &attacker, int &inflictor, float &damage, int &damagetype)
{
    if (sm_nodamage.IntValue &&
        (damagetype & DMG_FALL ||
         attacker != victim))
    {
        return Plugin_Handled;
    }
        
    return Plugin_Continue;
}

public void OnPluginStart()
{
    sm_nodamage = CreateConVar("nodamage", "1", "Disable Damage");
    PrintToServer("[SM] NoDamage initialized");
}

public void OnClientPutInServer(int client)
{	
	SDKHook(client, SDKHook_OnTakeDamage, OnTakeDamage);
}

public void OnClientDisconnect(int client)
{
    SDKUnhook(client, SDKHook_OnTakeDamage, OnTakeDamage);
}
