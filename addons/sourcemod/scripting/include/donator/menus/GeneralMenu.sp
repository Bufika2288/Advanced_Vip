//////////////////////////////////////
/////////////MAIN MENUS///////////////
//////////////////////////////////////



//Item Menu
Menu BuildGeneralMenu()
{	
	char buffer[128];
	Menu menu = new Menu(Menu_General);
	
	
	if (GetConVarBool(sm_items_enable))
	{
		Format(buffer, sizeof(buffer), "%T", "Items", LANG_SERVER);
		menu.AddItem("Items", buffer);
	}
	
	if (GetConVarBool(sm_items_enable))
	{
		Format(buffer, sizeof(buffer), "%T", "Perks", LANG_SERVER);
		menu.AddItem("Perks", buffer);
	}
	
	Format(buffer, sizeof(buffer), "%T", "General Menu Title", LANG_SERVER);
	menu.SetTitle(buffer);
	menu.ExitBackButton = true;
	menu.Pagination = 8;
	
	return menu;
	
}

//////////////////////////////////////
///////////Menu Handlers//////////////
//////////////////////////////////////



public int Menu_General(Menu menu, MenuAction action, int param1, int param2)
{
	if(action == MenuAction_Select)
	{
		char items[32];
		menu.GetItem(param2, items, sizeof(items));
	
		if (StrEqual(items, "Items")) 
		{
			g_ItemMenu.Display(param1, MENU_TIME_FOREVER);
		}
		
		if (StrEqual(items, "Perks")) 
		{
			g_PerkMenu.Display(param1, MENU_TIME_FOREVER);
		}
	}
	
	if(action == MenuAction_Cancel)
	{
	     if(param2 == MenuCancel_ExitBack) 
		{
			g_MainMenu.Display(param1, MENU_TIME_FOREVER);
		}
	}
}
