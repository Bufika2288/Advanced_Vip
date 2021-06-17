//////////////////////////////////////
/////////////MAIN MENUS///////////////
//////////////////////////////////////



//Item Menu
Menu BuildItemMenu(int client)
{	
	char buffer[128];
	char buffer2[128];
	char buffer3[128];
	Menu menu = new Menu(Menu_Items);
	
	Format(buffer, sizeof(buffer), "%T", "HealthShot", LANG_SERVER);
	Format(buffer2, sizeof(buffer2), "%s", gb_ItemHealthShot[ client ] ? "[Enabled]":"[Disabled]");
	Format(buffer3, sizeof(buffer3), "%s %s", buffer, buffer2);
	menu.AddItem("HealthShot", buffer3);
	
	Format(buffer, sizeof(buffer), "%T", "Tagrenade", LANG_SERVER);
	Format(buffer2, sizeof(buffer2), "%s", gb_ItemTagrenade[ client ] ? "[Enabled]":"[Disabled]");
	Format(buffer3, sizeof(buffer3), "%s %s", buffer, buffer2);
	menu.AddItem("Tagrenade", buffer3);
	
	Format(buffer, sizeof(buffer), "%T", "Zeus", LANG_SERVER);
	Format(buffer2, sizeof(buffer2), "%s", gb_ItemZeus[ client ] ? "[Enabled]":"[Disabled]");
	Format(buffer3, sizeof(buffer3), "%s %s", buffer, buffer2);
	menu.AddItem("Zeus", buffer3);
	
	Format(buffer, sizeof(buffer), "%T", "Defuse Kit", LANG_SERVER);
	Format(buffer2, sizeof(buffer2), "%s", gb_ItemDefuseKit[ client ] ? "[Enabled]":"[Disabled]");
	Format(buffer3, sizeof(buffer3), "%s %s", buffer, buffer2);
	menu.AddItem("Defuse Kit", buffer3);
		
	Format(buffer, sizeof(buffer), "%T", "Item Menu Title", LANG_SERVER);
	menu.SetTitle(buffer);
	menu.ExitBackButton = true;
	menu.Pagination = 8;
	return menu;
	
}

//////////////////////////////////////
///////////Menu Handlers//////////////
//////////////////////////////////////



public int Menu_Items(Menu menu, MenuAction action, int client, int param2)
{	

	if(action == MenuAction_Select)
	{
		char items[32];
		menu.GetItem(param2, items, sizeof(items));
		
	
		if (StrEqual(items, "HealthShot")) 
		{
			char sValue[8];
			gb_ItemHealthShot[client] = !gb_ItemHealthShot[client];
			IntToString(gb_ItemHealthShot[client], sValue, sizeof(sValue)); // convert to string
			SetClientCookie(client, g_hCookieClient_ItemHealthShot, sValue); // save to cookie
												
		}
			
		if (StrEqual(items, "Tagrenade")) 
		{
			char sValue[8];
			gb_ItemTagrenade[client] = !gb_ItemTagrenade[client];
			IntToString(gb_ItemTagrenade[client], sValue, sizeof(sValue)); // convert to string
			SetClientCookie(client, g_hCookieClient_ItemTagrenade, sValue); // save to cookie	
		}
		
		if (StrEqual(items, "Zeus"))
		{
			char sValue[8];
			gb_ItemZeus[client] = !gb_ItemZeus[client];
			IntToString(gb_ItemZeus[client], sValue, sizeof(sValue)); // convert to string
			SetClientCookie(client, g_hCookieClient_ItemZeus, sValue); // save to cookie	
		}
		
		if (StrEqual(items, "Defuse Kit"))
		{
			char sValue[8];
			gb_ItemDefuseKit[client] = !gb_ItemDefuseKit[client];
			IntToString(gb_ItemDefuseKit[client], sValue, sizeof(sValue)); // convert to string
			SetClientCookie(client, g_hCookieClient_ItemDefuse, sValue); // save to cookie	
		}
		
		g_ItemMenu = BuildItemMenu(client);
		g_ItemMenu.Display(client, MENU_TIME_FOREVER);			
	
	}
		
	if(action == MenuAction_Cancel) 
	{
	   	if(param2 == MenuCancel_ExitBack) 
	   	{
	   	 	g_GeneralMenu.Display(client, MENU_TIME_FOREVER);
		}
	}
	return 0;
}