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
/*
Menu BuildTagListMenu()
{
	
	Menu menu = new Menu(Menu_TagList);
	
 	menu.AddItem("Disable", "Disable Tag");
	for(int i = 0; i < g_cTabTag; i++)
	{
		menu.AddItem(g_cTabTag, g_cTabTag[i]);
	}
	
	
	menu.SetTitle("Tag List:");
	menu.ExitBackButton = true;
	menu.Pagination = 8;
	
	return menu;

}
*/
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

/*
public int Menu_TagList(Menu menu, MenuAction action, int param1, int param2)
{
	switch(action){
		
		case MenuAction_Select:
		{	
			char item[256];
			menu.GetItem(param2, item, sizeof(item));
			
			if (StrEqual(item, "Tag")) 
			{
				g_TagList.Display(param1, MENU_TIME_FOREVER);
			}
			
			if (StrEqual(item, "Disable")) 
			{	
				CS_SetClientClanTag(iClient, "");
			}
		}
		case MenuAction_End:
		{
			g_GeneralMenu.Display(param1, MENU_TIME_FOREVER);
			
		}
	}
}
*/