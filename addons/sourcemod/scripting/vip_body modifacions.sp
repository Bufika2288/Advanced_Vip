/* TODO



*/
#pragma semicolon 1

#define DEBUG
#define PLUGIN_VERSION "1.0"
#define SOUND_COOLDOWN 120

#include <sourcemod>
#include <sdktools>
#include <cstrike>
#include <adminmenu>
#include <clientprefs>
//#include <multicolors>
#include <chat-processor>
#include <colorvariables>


#pragma newdecls required

//STRINGS
char g_sTag[128];

char g_sColor[8];
char g_sBodySize[12];

char g_sMenu_Flag[32];

//char g_sClientColorName[MAXPLAYERS+1][128];

//BOOLS


bool gb_ItemHealthShot[MAXPLAYERS+1];
bool gb_ItemTagrenade[MAXPLAYERS+1];
bool gb_ItemZeus[MAXPLAYERS+1];
bool gb_Transparency[MAXPLAYERS+1];
bool gb_ItemDefuseKit[MAXPLAYERS+1];


bool gb_PerkBunnyhop[MAXPLAYERS+1];
bool gb_PerkHp[MAXPLAYERS+1];
bool gb_PerkArmor[MAXPLAYERS+1];
bool gb_PerkCash[MAXPLAYERS+1];

bool gb_ClientCanUseSound[MAXPLAYERS+1];
bool gb_ClientCanUseFVK[MAXPLAYERS+1];
bool gb_ClientCanUseRespawn[MAXPLAYERS+1];




//HANDLES

Handle sm_donatormenu_enable = INVALID_HANDLE;
Handle sm_body_modifications_enable = INVALID_HANDLE;
Handle sm_fun_functions_enable = INVALID_HANDLE;
Handle sm_items_enable = INVALID_HANDLE;
Handle sm_transparency_enable = INVALID_HANDLE;
Handle sm_join_disconnect_msg = INVALID_HANDLE;
Handle sm_restrick_module_cmds = INVALID_HANDLE;
Handle sm_spawn_enable = INVALID_HANDLE;

Handle sm_donatormenu_flag = INVALID_HANDLE;
//Handle sm_donatormenu_ver = INVALID_HANDLE;
Handle sm_bodysize_enable = INVALID_HANDLE;
Handle sm_bodycolor_enable = INVALID_HANDLE;

Handle sm_rainmoney_enable = INVALID_HANDLE;
Handle sm_fakecase_enable = INVALID_HANDLE;
Handle sm_fvk_enable = INVALID_HANDLE;
Handle sm_playsound_enable = INVALID_HANDLE;
ConVar sm_playsound_cooldown;
ConVar sm_fvk_cooldown;

Handle sm_enable_hop = INVALID_HANDLE;
ConVar sm_health_onspawn;
ConVar sm_armor_onspawn;
ConVar sm_round_start_money;

ConVar sm_donatormenu_commands;
ConVar sm_spawn_commands;



Handle g_hCookieClient_Color = INVALID_HANDLE;
Handle g_hCookieClient_BodySize = INVALID_HANDLE;

Handle g_hCookieClient_PerkBunnyhop = INVALID_HANDLE;
Handle g_hCookieClient_PerkHp = INVALID_HANDLE;
Handle g_hCookieClient_PerkArmor = INVALID_HANDLE;
Handle g_hCookieClient_PerkCash = INVALID_HANDLE;

Handle g_hCookieClient_ItemHealthShot = INVALID_HANDLE;
Handle g_hCookieClient_ItemTagrenade = INVALID_HANDLE;
Handle g_hCookieClient_ItemZeus = INVALID_HANDLE;
Handle g_hCookieClient_ItemDefuse = INVALID_HANDLE;
Handle g_hCookieClient_BodyTransparency = INVALID_HANDLE;


Handle sv_autobunnyhopping;
Handle sv_enablebunnyhopping;


//MENUS
Menu g_MainMenu = null;

Menu g_GeneralMenu = null;
Menu g_FunMenu = null;

Menu g_BodySize = null;
Menu g_BodyModification = null;

Menu g_TrollFunctions = null;
Menu g_FVKMenu = null;

Menu g_ItemMenu = null;
Menu g_BodyColor = null;

Menu g_SpawnMenu = null;
Menu g_BodyTransparent = null;

Menu g_OtherFunStuffMenu = null;
Menu g_PerkMenu = null;
Menu g_FakeSound = null;

#include "donator/menus/GeneralMenu.sp"
#include "donator/menus/BodyMenu.sp"
#include "donator/menus/FunMenu.sp"
#include "donator/menus/ItemsMenu.sp"
#include "donator/menus/Cookies.sp"
#include "donator/menus/PerkMenu.sp"


public Plugin myinfo = 
{
	name = "Donator/Vip menu",
	author = "Levi2288",
	description = "Vip/Donator Menu",
	version = "1.0",
	url = "https://github.com/Bufika2288"
};


//////////////////////////////////////
////////////PLUGIN START//////////////
//////////////////////////////////////

public void OnPluginStart()
{
	//General
	sm_donatormenu_enable = CreateConVar("sm_donatormenu_enable", "1","Enable the main plugin");
	sm_donatormenu_commands = CreateConVar("sm_donatormenu_commands", "dm, donator, donatormenu","You can set here custom commands to open the main menu");
	sm_spawn_commands = CreateConVar("sm_spawn_commands", "vipspawn, respawn, spawnme","You can set here custom commands to use spawn");
	sm_spawn_enable = CreateConVar("sm_spawn_enable", "1","Enable the \"VipSpawn\" function");
	sm_donatormenu_flag = CreateConVar("sm_donatormenu_flag", "o", "admin flag for donators menu (empty for all players)");
	sm_restrick_module_cmds = CreateConVar("sm_restrick_module_cmds", "1", "Restrict the module cmds to flag b (Recomended if you using fake vac kick or raining money module)");
	//sm_clantag = CreateConVar("sm_clantag", "[Donator]", "Clantag for Vip");
	
	//Enable/Disable
	sm_join_disconnect_msg = CreateConVar("sm_join_disconnect_msg", "1","Enable join and discnonnect message for vips");
	sm_body_modifications_enable = CreateConVar("sm_body_modifications_enable", "1","Enable the body modifications functions");
	sm_fun_functions_enable = CreateConVar("sm_fun_functions_enable", "1","Enable the Fun functions");
	sm_items_enable = CreateConVar("sm_items_enable", "1","Enable spawn items");
	
	//Body
	sm_bodysize_enable = CreateConVar("sm_bodysize_enable", "1","Enable the body size function");
	sm_bodycolor_enable = CreateConVar("sm_bodycolor_enable", "1","Enable the body size function");
	sm_transparency_enable = CreateConVar("sm_transparency_enable", "1","Enable the body transparency function");
	
	//Troll
	sm_playsound_enable = CreateConVar("sm_playsound_enable", "1","Enable the fake sound function");
	sm_playsound_cooldown = CreateConVar("sm_playsound_cooldown", "120.0","Cooldonw to use the sounds in sec");
	sm_fvk_cooldown = CreateConVar("sm_fvk_cooldown", "120.0","Cooldonw to use fake vac kick in sec");
	sm_rainmoney_enable = CreateConVar("sm_rainmoney_enable", "1","Enable the raining money function");
	sm_fakecase_enable = CreateConVar("sm_fakecase_enable", "1","Enable the fakecase function");
	sm_fvk_enable = CreateConVar("sm_fvk_enable", "1","Enable the fake VAC kick function");
	
	//Perks
	sm_enable_hop = CreateConVar("sm_enable_hop", "1","Enable the bhop perk");
	sm_health_onspawn = CreateConVar("sm_health_onspawn", "25","How much + hp donators/vip get by default (0 to disable)");
	sm_armor_onspawn = CreateConVar("sm_armor_onspawn", "25","How much + armor donators/vip get by default (0 to disable)");
	sm_round_start_money = CreateConVar("sm_round_start_money", "700","+ money on round start (0 to disable)");
	
	AutoExecConfig(true, "Donator_Menu");
	
	//Ver
	//sm_donatormenu_ver = CreateConVar("sm_donatormenu_ver", PLUGIN_VERSION, "Plugin Version", FCVAR_SPONLY|FCVAR_DEVELOPMENTONLY);
		
	
	LoadTranslations("common.phrases");
	LoadTranslations("donatormenu.phrases");
	
	sv_autobunnyhopping = FindConVar("sv_autobunnyhopping");
	sv_enablebunnyhopping = FindConVar("sv_enablebunnyhopping");
	SetConVarBool(sv_autobunnyhopping, false);
	SetConVarBool(sv_enablebunnyhopping, false);
	
	// Cookie kezelés
	g_hCookieClient_Color = RegClientCookie("ClientColor", "Stores the color of the Client", CookieAccess_Private);
	g_hCookieClient_BodySize = RegClientCookie("ClientBodySize", "Stores the size of the Client", CookieAccess_Private);
	
	g_hCookieClient_PerkBunnyhop = RegClientCookie("Bunnyhop", "Value of Bunnyhop perk (True / False)", CookieAccess_Private);
	g_hCookieClient_PerkHp = RegClientCookie("PerkHp", "Value of Hp perk (True / False)", CookieAccess_Private);
	g_hCookieClient_PerkArmor = RegClientCookie("PerkArmor", "Value of Armor perk (True / False)", CookieAccess_Private);
	g_hCookieClient_PerkCash = RegClientCookie("PerkCash", "Value of Cash perk (True / False)", CookieAccess_Private);
	
	g_hCookieClient_ItemHealthShot = RegClientCookie("HealthShot", "Value of HealthShot item (True / False)", CookieAccess_Private);
	g_hCookieClient_ItemTagrenade = RegClientCookie("ItemTagrenade", "Value of Tagrenade item (True / False)", CookieAccess_Private);
	g_hCookieClient_ItemZeus = RegClientCookie("ItemZeus", "Value of Zeus item (True / False)", CookieAccess_Private);
	g_hCookieClient_ItemDefuse = RegClientCookie("ItemDefuse", "Value of Defuse item (True / False)", CookieAccess_Private);
	
	g_hCookieClient_BodyTransparency = RegClientCookie("BodyTransparency", "Value of DBody Transparency (True / False)", CookieAccess_Private);
	
	for (int i = MaxClients; i > 0; --i)
    {
    	if (!IsClientInGame(i))
    	{
			continue;
		}
		
        if (AreClientCookiesCached(i))
        {
            OnClientCookiesCached(i);
        }
        
        else 
		{
    		g_sColor[i] = 0;
    		g_sBodySize[i] = 0;
    		gb_PerkBunnyhop[i] = false;
    		gb_PerkHp[i] = false;
    		gb_PerkArmor[i] = false;
    		gb_PerkCash[i] = false;
    		gb_ItemHealthShot[i] = false;
    		gb_ItemTagrenade[i] = false;
    		gb_ItemZeus[i] = false;
    		gb_ItemDefuseKit[i] = false;
    		gb_Transparency[i] = false;
		}
        
    }
    


	HookEvent("player_spawn", Event_PlayerSpawn);
	HookEvent("player_spawn", Event_GiveItems);
	HookEvent("player_spawn", Event_SpawnPerks);
	
	HookEvent("round_start", Event_RoundStart);
	HookEvent("player_jump", Event_PlayerJump, EventHookMode_Post );
}



public void OnClientCookiesCached(int client)
{
	char sValue[8];
	
	GetClientCookie(client, g_hCookieClient_Color, g_sColor, sizeof(g_sColor));
	GetClientCookie(client, g_hCookieClient_BodySize, g_sBodySize, sizeof(g_sBodySize));
	
	
	//HealthShot
	GetClientCookie(client, g_hCookieClient_ItemHealthShot, sValue, sizeof(sValue)); // Gets stored value for specific client and stores in sValue
	gb_ItemHealthShot[client] = (sValue[0] != '\0' && StringToInt(sValue)); // If the string isn't empty and is >0, it'll be set to true		

	//Tagrenade
	GetClientCookie(client, g_hCookieClient_ItemTagrenade, sValue, sizeof(sValue)); // Gets stored value for specific client and stores in sValue
	gb_ItemTagrenade[client] = (sValue[0] != '\0' && StringToInt(sValue)); // If the string isn't empty and is >0, it'll be set to true
	
	//Zeus
	GetClientCookie(client, g_hCookieClient_ItemZeus, sValue, sizeof(sValue)); // Gets stored value for specific client and stores in sValue
	gb_ItemZeus[client] = (sValue[0] != '\0' && StringToInt(sValue)); // If the string isn't empty and is >0, it'll be set to true	

	//Defuse Kit
	GetClientCookie(client, g_hCookieClient_ItemDefuse, sValue, sizeof(sValue)); // Gets stored value for specific client and stores in sValue
	gb_ItemDefuseKit[client] = (sValue[0] != '\0' && StringToInt(sValue)); // If the string isn't empty and is >0, it'll be set to true	
	
	
	
	//Bunny
	GetClientCookie(client, g_hCookieClient_PerkBunnyhop, sValue, sizeof(sValue)); // Gets stored value for specific client and stores in sValue
	gb_PerkBunnyhop[client] = (sValue[0] != '\0' && StringToInt(sValue)); // If the string isn't empty and is >0, it'll be set to true		

	//Hp
	GetClientCookie(client, g_hCookieClient_PerkHp, sValue, sizeof(sValue)); // Gets stored value for specific client and stores in sValue
	gb_PerkHp[client] = (sValue[0] != '\0' && StringToInt(sValue)); // If the string isn't empty and is >0, it'll be set to true
	
	//Armor
	GetClientCookie(client, g_hCookieClient_PerkArmor, sValue, sizeof(sValue)); // Gets stored value for specific client and stores in sValue
	gb_PerkArmor[client] = (sValue[0] != '\0' && StringToInt(sValue)); // If the string isn't empty and is >0, it'll be set to true	

	//Cash
	GetClientCookie(client, g_hCookieClient_PerkCash, sValue, sizeof(sValue)); // Gets stored value for specific client and stores in sValue
	gb_PerkCash[client] = (sValue[0] != '\0' && StringToInt(sValue)); // If the string isn't empty and is >0, it'll be set to true	
	
	
	//Body Transparency
	GetClientCookie(client, g_hCookieClient_BodyTransparency, sValue, sizeof(sValue)); // Gets stored value for specific client and stores in sValue
	gb_Transparency[client] = (sValue[0] != '\0' && StringToInt(sValue)); // If the string isn't empty and is >0, it'll be set to true	
	
}

public void OnClientPutInServer(int client)
{
	gb_ClientCanUseSound[client] = true;
	gb_ClientCanUseFVK[client] = true;
	gb_ClientCanUseRespawn[client] = true;
}
public void OnClientPostAdminCheck(int client)
{
	char sPlayerName[MAX_NAME_LENGTH];
	
	GetClientName(client, sPlayerName, sizeof(sPlayerName));
	
	if ((CheckAdminFlags(client, ReadFlagString(g_sMenu_Flag))) && (GetConVarBool(sm_join_disconnect_msg)))
	{
		char buffer[128];
		Format(buffer, sizeof(buffer), "%T", "JoinMSG", LANG_SERVER, sPlayerName);
		CPrintToChatAll("%s %s", g_sTag, buffer);
	}
}

public void OnClientDisconnect(int client)
{	
	char sPlayerName[MAX_NAME_LENGTH];
	
	GetClientName(client, sPlayerName, sizeof(sPlayerName));
	
	if ((CheckAdminFlags(client, ReadFlagString(g_sMenu_Flag))) && (GetConVarBool(sm_join_disconnect_msg)))
	{
		char buffer[128];
		Format(buffer, sizeof(buffer), "%T", "DisconnectMSG", LANG_SERVER, sPlayerName);
		PrintToChatAll("%s %N %s", g_sTag, client, buffer);
	}
}


public void OnConfigsExecuted()
{

	
	int iCount = 0;
	char sCommands[128];
	char sCommandsL[12][32];
	char sCommand[32];
	
	int iCount_spawn = 0;
	char sCommands_spawn[128];
	char sCommandsL_spawn[12][32];
	char sCommand_spawn[32];

	sm_donatormenu_commands.GetString(sCommands, sizeof(sCommands));
	ReplaceString(sCommands, sizeof(sCommands), " ", "");
	
	iCount = ExplodeString(sCommands, ",", sCommandsL, sizeof(sCommandsL), sizeof(sCommandsL[]));

	for (int i = 0; i < iCount; i++)
	{
		Format(sCommand, sizeof(sCommand), "sm_%s", sCommandsL[i]);
		
		if (!CommandExists(sCommand))
		{
			RegConsoleCmd(sCommand, VipBodyCMD, "Open the Main menu");
		}
	}
	
	sm_spawn_commands.GetString(sCommands_spawn, sizeof(sCommands_spawn));
	ReplaceString(sCommands_spawn, sizeof(sCommands_spawn), " ", "");
	
	iCount_spawn = ExplodeString(sCommands_spawn, ",", sCommandsL_spawn, sizeof(sCommandsL_spawn), sizeof(sCommandsL_spawn[]));
	
	for (int i = 0; i < iCount_spawn; i++)
	{
		Format(sCommand_spawn, sizeof(sCommand_spawn), "sm_%s", sCommandsL_spawn[i]);
		
		
		if (!CommandExists(sCommand_spawn))
		{
			RegConsoleCmd(sCommand_spawn, VipSpawn, "VipSpawn cmd");
		}
	}
}


public void OnMapStart()
{
	PrecacheModel("models/props/de_dust/hr_dust/dust_soccerball/dust_soccer_ball001.mdl", true);
	PrecacheModel("models/props_holidays/snowball/snowball_pile.mdl", true);
	PrecacheSound("radio/bombpl.wav", true);
	PrecacheSound("radio/bombdef.wav", true);
	PrecacheSound("radio/rescued.wav", true);
	PrecacheSound("radio/ctwin.wav", true);
	PrecacheSound("radio/terwin.wav", true);
	
	GetConVarString(sm_donatormenu_flag, g_sMenu_Flag, sizeof(g_sMenu_Flag));
	
	if (GetConVarBool(sm_restrick_module_cmds))
	{
		//Raining money
		AddCommandOverride("sm_dropmoney", Override_Command, ADMFLAG_GENERIC);
		AddCommandOverride("sm_rainingmoney", Override_Command, ADMFLAG_GENERIC);
		AddCommandOverride("sm_dm", Override_Command, ADMFLAG_GENERIC);
		AddCommandOverride("sm_rm", Override_Command, ADMFLAG_GENERIC);
		
		//FVK
		AddCommandOverride("sm_fakevackick", Override_Command, ADMFLAG_GENERIC);


	}
	Format(g_sTag, sizeof(g_sTag), "%T", "Chat Tag", LANG_SERVER);
}

public Action VipBodyCMD(int client, int args)
{
	if (GetConVarBool(sm_donatormenu_enable))
	{
		g_MainMenu = BuildMainMenu();
		g_FunMenu = BuildFunMenu();
		g_GeneralMenu = BuildGeneralMenu();
	
		g_BodyModification = BuildBodyMenu();
		g_TrollFunctions = BuildTrollMenu();
		g_ItemMenu = BuildItemMenu(client);
		g_PerkMenu = BuildPerkMenu(client);
		
		g_OtherFunStuffMenu = BuildOtherFunStuffMenu();
		g_SpawnMenu = BuildSpawnMenu();
		g_FVKMenu = BuildFVKMenu();
		g_BodySize = BuildSizeMenu();
		g_BodyColor = BuildColorMenu();
		g_BodyTransparent = BuildTransparentMenu(client);
		g_FakeSound = BuildFakeSoundMenu();
		
		char buffer[128];
	
		if (CheckAdminFlags(client, ReadFlagString(g_sMenu_Flag)))
		{
			g_MainMenu.Display(client, MENU_TIME_FOREVER);
		}
		else 
		{
			Format(buffer, sizeof(buffer), "%T", "No Access", LANG_SERVER);
			CPrintToChat(client, "%s %s", g_sTag, buffer);
		}
		
	}
	
	return Plugin_Handled;
}

//////////////////////////////////////
/////////////MAIN MENUS///////////////
//////////////////////////////////////


//Main Menu
Menu BuildMainMenu()
{	
	char buffer[128];
	Menu menu = new Menu(Menu_Main);
	
	if (GetConVarBool(sm_body_modifications_enable))
	{
		Format(buffer, sizeof(buffer), "%T", "General Functions", LANG_SERVER);
		menu.AddItem("General Functions", buffer);
	}
	
	if (GetConVarBool(sm_fun_functions_enable))
	{
		Format(buffer, sizeof(buffer), "%T", "Fun Functions", LANG_SERVER);
		menu.AddItem("Fun Functions", buffer);
	}
	
	Format(buffer, sizeof(buffer), "%T", "Main Menu Title", LANG_SERVER);
	menu.SetTitle(buffer);
	return menu;
}

//////////////////////////////////////
/////////////SIDE MENUS///////////////
//////////////////////////////////////





//////////////////////////////////////
///////////Menu Handlers//////////////
//////////////////////////////////////


public int Menu_Main(Menu menu, MenuAction action, int param1, int param2)
{
	if(action == MenuAction_Select)
	{
		char items[32];
		menu.GetItem(param2, items, sizeof(items));

		if (StrEqual(items, "General Functions")) 
		{
			g_GeneralMenu.Display(param1, MENU_TIME_FOREVER);
		}

		if (StrEqual(items, "Fun Functions")) 
		{
			g_FunMenu.Display(param1, MENU_TIME_FOREVER);
		}
	}
}

//////////////////////////////////////
///////////////EVENTS////////////////
//////////////////////////////////////

public void Event_PlayerSpawn(Event event, const char[] name, bool dontBroadcast) 
{
	int client = GetClientOfUserId(event.GetInt("userid"));
	
	if (!client) return;
	if((g_sColor[client] != 0) && (CheckAdminFlags(client, ReadFlagString(g_sMenu_Flag))))
	{
		CreateTimer(2.5, Timer_SetColor, client);
	}
	if((g_sBodySize[client] != 0) && (CheckAdminFlags(client, ReadFlagString(g_sMenu_Flag))))
	{
		CreateTimer(2.5, Timer_SetBodyType, client);
	}
	
	if((gb_Transparency[client] == true) && (CheckAdminFlags(client, ReadFlagString(g_sMenu_Flag))))
	{
		SetEntityRenderMode(client, RENDER_NONE);
	}
	else if (gb_Transparency[client] == false)
	{
		SetEntityRenderMode(client, RENDER_NORMAL);
	}
}

public void Event_GiveItems(Event event, const char[] name, bool dontBroadcast) 
{
	int client = GetClientOfUserId(event.GetInt("userid"));
	
	if (!client) return;
	if((gb_ItemHealthShot[client] == true) && (CheckAdminFlags(client, ReadFlagString(g_sMenu_Flag))))
	{
		 GivePlayerItem(client, "weapon_healthshot");
	}
	
	if((gb_ItemTagrenade[client] == true) && (CheckAdminFlags(client, ReadFlagString(g_sMenu_Flag))))
	{
		 GivePlayerItem(client, "weapon_tagrenade");
	}
	
	if((gb_ItemZeus[client] == true) && (CheckAdminFlags(client, ReadFlagString(g_sMenu_Flag))))
	{
		 GivePlayerItem(client, "weapon_taser");
	}
	
	if((gb_ItemZeus[client] == true) && (CheckAdminFlags(client, ReadFlagString(g_sMenu_Flag))))
	{
		 GivePlayerItem(client, "weapon_taser");
	}
	
	if((gb_ItemDefuseKit[client] == true) && (CheckAdminFlags(client, ReadFlagString(g_sMenu_Flag))) && GetClientTeam(client) == CS_TEAM_CT)
	{
		 GivePlayerItem(client, "item_defuser");
	}
}	
public void Event_SpawnPerks(Event event, const char[] name, bool dontBroadcast) 
{
	int client = GetClientOfUserId(event.GetInt("userid"));
	
	if (!client) return;
	
	if((gb_PerkHp[client] == true) && (CheckAdminFlags(client, ReadFlagString(g_sMenu_Flag))))
	{
		SetEntProp(client, Prop_Data, "m_iMaxHealth", 100 + sm_health_onspawn.IntValue);
		SetEntityHealth(client, 100 + sm_health_onspawn.IntValue);
	}
	
	if((gb_PerkArmor[client] == true) && (CheckAdminFlags(client, ReadFlagString(g_sMenu_Flag))))
	{
		SetEntProp(client, Prop_Send, "m_ArmorValue", 100 + sm_armor_onspawn.IntValue);
		SetEntProp(client, Prop_Send, "m_bHasHelmet", 1);
	}
}	

public void Event_RoundStart(Event event, const char[] name, bool dontBroadcast) 
{
	
	int client = GetClientOfUserId(event.GetInt("userid"));
	
	if((gb_PerkCash[client] == true) && (CheckAdminFlags(client, ReadFlagString(g_sMenu_Flag))))
	{
		int Money = GetEntProp(client, Prop_Send, "m_iAccount");
		SetEntProp(client, Prop_Send, "m_iAccount", sm_round_start_money.IntValue + Money);
	}
	if((gb_PerkCash[client] == true) && (CheckAdminFlags(client, ReadFlagString(g_sMenu_Flag))))
	{
		gb_ClientCanUseRespawn[client] = true;
	}
}	

public void Event_PlayerJump(Event event, const char[] szEvent, bool dontBroadcast )
{
	int client = GetClientOfUserId( event.GetInt( "userid" ) );

	if (!client) return;
	if( gb_PerkBunnyhop[client] )
	{
		SetEntPropFloat( client, Prop_Send, "m_flStamina", 0.0 );
	}
}

//////////////////////////////////////
/////////////////Etc//////////////////
//////////////////////////////////////

bool CheckAdminFlags(int client, int iFlag)
{
	int iUserFlags = GetUserFlagBits(client);
	return (iUserFlags & ADMFLAG_ROOT || (iUserFlags & iFlag) == iFlag);
}

public Action Timer_SetColor(Handle timer, any client)
{
	if(IsPlayerAlive(client)) 
	{
		Set_Player_Color(GetClientUserId(client), g_sColor, true);
	}


}

public Action Timer_SetBodyType(Handle timer, any client)
{
	if(IsPlayerAlive(client)) 
	{
		Set_Player_BodyType(GetClientUserId(client), g_sBodySize);
	}


}
public Action OnPlayerRunCmd(int client, int &buttons, int &impulse, float vel[3], float angles[3], int &weapon)
{
	if (gb_PerkBunnyhop[client] && IsPlayerAlive(client))
	{
		if (buttons & IN_JUMP)
		{
			if (!(GetEntityFlags(client) & FL_ONGROUND))
			{
				if (!(GetEntityMoveType(client) & MOVETYPE_LADDER))
				{
					if (GetEntProp(client, Prop_Data, "m_nWaterLevel") <= 1)
					{
						buttons &= ~IN_JUMP;
					}
				}
			}
		}
	}
}

public Action VipSpawn(int client, int args)
{
	char buffer[256];
	char sMessage[256];
	char sTeam[32];
	
	if ((GetConVarBool(sm_spawn_enable)))
	{
		if (CheckAdminFlags(client, ReadFlagString(g_sMenu_Flag)))
		{
			if (!IsPlayerAlive(client))
			{
				if (gb_ClientCanUseRespawn[client] == true)
				{
					int Team = GetClientTeam(client);
					GetTeamName(Team, sTeam, sizeof(sTeam));
					
					if(GetClientTeam(client) == CS_TEAM_SPECTATOR)
					{
						Format(buffer, sizeof(buffer), "%T", "Spawn Invalid Team", LANG_SERVER, sTeam);
						Format(sMessage, sizeof(sMessage), "%s %s", g_sTag, buffer);
						CPrintToChat(client, sMessage);
					}
					else
					{
						CS_RespawnPlayer(client);
						Format(buffer, sizeof(buffer), "%T", "Spawn Sucess", LANG_SERVER);
						Format(sMessage, sizeof(sMessage), "%s %s", g_sTag, buffer);
						CPrintToChat(client, sMessage);
						gb_ClientCanUseRespawn[client] = false;
					}
				}
				else
				{
					Format(buffer, sizeof(buffer), "%T", "Spawn Used", LANG_SERVER);
					Format(sMessage, sizeof(sMessage), "%s %s", g_sTag, buffer);
					CPrintToChat(client, sMessage);
				}
			}
			else
			{
				
				Format(buffer, sizeof(buffer), "%t", "Cant Use Spawn (Player Still Alive)", client);
				Format(sMessage, sizeof(sMessage), "%s %s", g_sTag, buffer);
				CPrintToChat(client, sMessage);
			}
		}
		else 
		{
			Format(buffer, sizeof(buffer), "%T", "No Access", LANG_SERVER);
			CPrintToChat(client, "%s %s", g_sTag, buffer);
		}
	}
	else 
	{
		Format(buffer, sizeof(buffer), "%t", "Spawn not enabled", client);
		Format(sMessage, sizeof(sMessage), "%s %s", g_sTag, buffer);
		CPrintToChat(client, sMessage);
	}
}