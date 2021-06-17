//////////////////////////////////////
/////////////MAIN MENUS///////////////
//////////////////////////////////////



//Item Menu
Menu BuildPerkMenu(int client)
{	
	char buffer[128];
	char buffer2[128];
	char buffer3[128];
	Menu menu = new Menu(Menu_Perk);
	
	
	if (GetConVarBool(sm_enable_hop))
	{
		Format(buffer, sizeof(buffer), "%T", "Bunnyhopp", LANG_SERVER);
		Format(buffer2, sizeof(buffer2), "%s", gb_PerkBunnyhop[client] ? "[Enabled]":"[Disabled]");
		Format(buffer3, sizeof(buffer3), "%s %s", buffer, buffer2);
		menu.AddItem("Bunnyhop", buffer3);
	}
	
	if (GetConVarInt(sm_health_onspawn) != 0)
	{
		Format(buffer, sizeof(buffer), "%T", "HP on spawn", LANG_SERVER);
		Format(buffer2, sizeof(buffer2), "%s", gb_PerkHp[ client ] ? "[Enabled]":"[Disabled]");
		Format(buffer3, sizeof(buffer3), "%s %s", buffer, buffer2);
		menu.AddItem("HpSpawn", buffer3);
	}
	
	if (GetConVarInt(sm_armor_onspawn) != 0)
	{
		Format(buffer, sizeof(buffer), "%T", "Armor on spawn", LANG_SERVER);
		Format(buffer2, sizeof(buffer2), "%s", gb_PerkArmor[ client ] ? "[Enabled]":"[Disabled]");
		Format(buffer3, sizeof(buffer3), "%s %s", buffer, buffer2);
		menu.AddItem("ArmorSpawn", buffer3);
	}
	
	if (GetConVarInt(sm_round_start_money) != 0)
	{
		Format(buffer, sizeof(buffer), "%T", "Cash on Round end", LANG_SERVER);
		Format(buffer2, sizeof(buffer2), "%s", gb_PerkCash[ client ] ? "[Enabled]":"[Disabled]");
		Format(buffer3, sizeof(buffer3), "%s %s", buffer, buffer2);
		menu.AddItem("CashSpawn", buffer3);
	}
	
	
	Format(buffer, sizeof(buffer), "%T", "Perk Menu Title", LANG_SERVER);
	menu.SetTitle(buffer);
	menu.ExitBackButton = true;
	menu.Pagination = 8;
	
	return menu;
	
}

//////////////////////////////////////
///////////Menu Handlers//////////////
//////////////////////////////////////



public int Menu_Perk(Menu menu, MenuAction action, int client, int param2)
{
		
	if(action == MenuAction_Select)
	{
		char items[32];
						
		menu.GetItem(param2, items, sizeof(items));
			
		
		if (StrEqual(items, "Bunnyhop")) 
		{
			char sValue[8];	
			
			//beirás
			gb_PerkBunnyhop[client] = !gb_PerkBunnyhop[client]; // toggle value
			IntToString(gb_PerkBunnyhop[client], sValue, sizeof(sValue)); // convert to string
			SetClientCookie(client, g_hCookieClient_PerkBunnyhop, sValue); // save to cookie	
			
			if (gb_PerkBunnyhop[client])
			{
				SendConVarValue(client, sv_autobunnyhopping, "1");
				SendConVarValue(client, sv_enablebunnyhopping, "0");
			}
			else
			{
				SetDefaultValue("sv_autobunnyhopping");
				SetDefaultValue("sv_enablebunnyhopping");
			}				
		}
		
		if (StrEqual(items, "HpSpawn")) 
		{
			char sValue[8];	
			
			//beirás
			gb_PerkHp[client] = !gb_PerkHp[client]; // toggle value
			IntToString(gb_PerkHp[client], sValue, sizeof(sValue)); // convert to string
			SetClientCookie(client, g_hCookieClient_PerkHp, sValue); // save to cookie				
		}
		
		if (StrEqual(items, "ArmorSpawn")) 
		{
			char sValue[8];	
			
			//beirás
			gb_PerkArmor[client] = !gb_PerkArmor[client]; // toggle value
			IntToString(gb_PerkArmor[client], sValue, sizeof(sValue)); // convert to string
			SetClientCookie(client, g_hCookieClient_PerkArmor, sValue); // save to cookie				
		}
		
		if (StrEqual(items, "CashSpawn")) 
		{
			char sValue[8];	
			
			//beirás
			gb_PerkCash[client] = !gb_PerkCash[client]; // toggle value
			IntToString(gb_PerkCash[client], sValue, sizeof(sValue)); // convert to string
			SetClientCookie(client, g_hCookieClient_PerkCash, sValue); // save to cookie				
		}

		g_PerkMenu = BuildPerkMenu(client);
		g_PerkMenu.Display(client, MENU_TIME_FOREVER);
	}
	if(action == MenuAction_Cancel)
	{
	     if(param2 == MenuCancel_ExitBack) 
		{
			g_GeneralMenu.Display(client, MENU_TIME_FOREVER);
		}
	}
}

//Abner code https://forums.alliedmods.net/member.php?u=79792
stock void SetDefaultValue(char[] CvarToSet){
	ConVar cvar = FindConVar(CvarToSet);
	if(cvar == INVALID_HANDLE)
		return;
		
	char sDefaultValue[100];
	cvar.GetDefault(sDefaultValue, sizeof(sDefaultValue));
	SetConVarString(cvar, sDefaultValue, true);
}