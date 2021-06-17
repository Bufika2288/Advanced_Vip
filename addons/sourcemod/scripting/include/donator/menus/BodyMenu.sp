

//////////////////////////////////////
/////////////MAIN MENUS///////////////
//////////////////////////////////////


Menu BuildBodyMenu()
{	
	char buffer[128];
	Menu menu = new Menu(Menu_Body);
	
	
	if (GetConVarBool(sm_bodycolor_enable))
	{
		
		Format(buffer, sizeof(buffer), "%T", "Body Color", LANG_SERVER);
		menu.AddItem("Body Color", buffer);
	}
	if (GetConVarBool(sm_bodysize_enable))
	{
		
		Format(buffer, sizeof(buffer), "%T", "Body Size", LANG_SERVER);
		menu.AddItem("Body Size", buffer);
	}
	
	if (GetConVarBool(sm_transparency_enable))
	{
		Format(buffer, sizeof(buffer), "%T", "Body Transparency", LANG_SERVER);
		menu.AddItem("Body Transparency", buffer);
	}
	
	Format(buffer, sizeof(buffer), "%T", "Body Menu Title", LANG_SERVER);
	menu.SetTitle(buffer);
	menu.ExitBackButton = true; 
	menu.Pagination = 8;
	return menu;
}



//BodySize Menu
Menu BuildSizeMenu()
{
	char buffer[128];
	Menu menu = new Menu(Menu_Size);
	
	Format(buffer, sizeof(buffer), "%T", "body_superfat", LANG_SERVER);
	menu.AddItem("body_fat", buffer);
	Format(buffer, sizeof(buffer), "%T", "body_fat", LANG_SERVER);
	menu.AddItem("body_fat", buffer);
	Format(buffer, sizeof(buffer), "%T", "body_normal", LANG_SERVER);
	menu.AddItem("body_normal", buffer);
	Format(buffer, sizeof(buffer), "%T", "body_skinny", LANG_SERVER);
	menu.AddItem("body_skinny", buffer);
	Format(buffer, sizeof(buffer), "%T", "body_superskinny", LANG_SERVER);
	menu.AddItem("body_superskinny", buffer);
	
	
	Format(buffer, sizeof(buffer), "%T", "Body Size Menu Title", LANG_SERVER);
	menu.SetTitle(buffer);
	menu.ExitBackButton = true; 
	menu.Pagination = 8;
	return menu;
	
}

//BodyColor Menu
Menu BuildColorMenu()
{
	char buffer[128];
	Menu menu = new Menu(Menu_Color);

	Format(buffer, sizeof(buffer), "%T", "Normal_Body_Color", LANG_SERVER);
	menu.AddItem("Normal_Body_Color", buffer);
	
	Format(buffer, sizeof(buffer), "%T", "Green", LANG_SERVER);
	menu.AddItem("Green", buffer);
	
	Format(buffer, sizeof(buffer), "%T", "Red", LANG_SERVER);
	menu.AddItem("Red", buffer);
	
	Format(buffer, sizeof(buffer), "%T", "Blue", LANG_SERVER);
	menu.AddItem("Blue", buffer);
	
	Format(buffer, sizeof(buffer), "%T", "Gold", LANG_SERVER);
	menu.AddItem("Gold", buffer);
	
	Format(buffer, sizeof(buffer), "%T", "Black", LANG_SERVER);
	menu.AddItem("Black", buffer);
	
	Format(buffer, sizeof(buffer), "%T", "Cyan", LANG_SERVER);
	menu.AddItem("Cyan", buffer);
	
	Format(buffer, sizeof(buffer), "%T", "Turquoise", LANG_SERVER);
	menu.AddItem("Turquoise", buffer);
	
	Format(buffer, sizeof(buffer), "%T", "SkyBlue", LANG_SERVER);
	menu.AddItem("SkyBlue", buffer);
	
	Format(buffer, sizeof(buffer), "%T", "Yellow", LANG_SERVER);
	menu.AddItem("Yellow", buffer);
	
	Format(buffer, sizeof(buffer), "%T", "Pink", LANG_SERVER);
	menu.AddItem("Pink", buffer);
	
	Format(buffer, sizeof(buffer), "%T", "Purple", LANG_SERVER);
	menu.AddItem("Purple", buffer);
	
	Format(buffer, sizeof(buffer), "%T", "Gray", LANG_SERVER);
	menu.AddItem("Gray", buffer);
	
	
	Format(buffer, sizeof(buffer), "%T", "Body Color Menu Title", LANG_SERVER);
	menu.SetTitle(buffer);
	menu.ExitBackButton = true; 
	menu.Pagination = 8;
	return menu;
}


//////////////////////////////////////
///////////Menu Handlers//////////////
//////////////////////////////////////




//Transparent Menu
Menu BuildTransparentMenu(int client)
{

	char buffer[128];
	char buffer2[128];
	char buffer3[128];
	Menu menu = new Menu(Menu_Transparent);
	
	Format(buffer, sizeof(buffer), "%T", "Transparency", LANG_SERVER);
	Format(buffer2, sizeof(buffer2), "%s", gb_Transparency[ client ] ? "[✔️]":"[❌]");
	Format(buffer3, sizeof(buffer3), "%s %s", buffer, buffer2);
	menu.AddItem("Transparency", buffer3);
	
	Format(buffer, sizeof(buffer), "%T", "Transparent Menu Title", LANG_SERVER);
	menu.SetTitle(buffer);
	menu.ExitBackButton = true; 
	menu.Pagination = 8;
	return menu;


}




public int Menu_Size(Menu menu, MenuAction action, int param1, int param2)
{
	if(action == MenuAction_Select)
	{
		char items[32];
		menu.GetItem(param2, items, sizeof(items));

		
		if (StrEqual(items, "body_superfat")) 
		{
			Client_SuperFat(param1);
		}
			
		if (StrEqual(items, "body_fat")) 
		{
			Client_Fat(param1);
		}
		
		if (StrEqual(items, "body_normal")) 
		{
			Client_Normal(param1);
		}
			
		if (StrEqual(items, "body_skinny")) 
		{
			Client_Skinny(param1);
		}
		
		if (StrEqual(items, "body_superskinny")) 
		{
			Client_SuperSkinny(param1);
		}
		
		g_BodySize.Display(param1, MENU_TIME_FOREVER);
	}
	
	if(action == MenuAction_Cancel) 
	{
        if(param2 == MenuCancel_ExitBack) 
        {
        	g_BodyModification.Display(param1, MENU_TIME_FOREVER);
        }
    }
}


public Action SetClientRainbowColor(Handle timer, any client) 
{
 	SetEntityRenderColor(client, GetRandomInt(0,255), GetRandomInt(0,255), GetRandomInt(0,255), GetRandomInt(0,255));
}


public int Menu_Color(Menu menu, MenuAction action, int client, int param2)
{
	if(action == MenuAction_Select)
	{
		char items[32];
		menu.GetItem(param2, items, sizeof(items));
		
		Set_Player_Color(GetClientUserId(client), items, false);			
		
		g_BodyColor.Display(client, MENU_TIME_FOREVER);		
	}
	if(action == MenuAction_Cancel) 
	{
        if(param2 == MenuCancel_ExitBack) 
        {
        	g_BodyModification.Display(client, MENU_TIME_FOREVER);
        }
    }
}



public int Menu_Body(Menu menu, MenuAction action, int param1, int param2)
{
	if(action == MenuAction_Select)
	{
		char items[32];
		menu.GetItem(param2, items, sizeof(items));
		
		if (StrEqual(items, "Body Color")) 
		{
			g_BodyColor.Display(param1, MENU_TIME_FOREVER);
		}

		if (StrEqual(items, "Body Size")) 
		{
			g_BodySize.Display(param1, MENU_TIME_FOREVER);
		}
		
		if (StrEqual(items, "Body Transparency")) 
		{
			g_BodyTransparent.Display(param1, MENU_TIME_FOREVER);
		}
	}
	if(action == MenuAction_Cancel) 
	{
        if(param2 == MenuCancel_ExitBack) 
        {
        	g_FunMenu.Display(param1, MENU_TIME_FOREVER);
        }
    }
}

public int Menu_Transparent(Menu menu, MenuAction action, int client, int param2)
{
	if(action == MenuAction_Select)
	{
		char items[32];
		menu.GetItem(param2, items, sizeof(items));

		
		if (StrEqual(items, "Transparency")) 
		{
			char sValue[8];	
			gb_Transparency[client] = !gb_Transparency[client];
			IntToString(gb_Transparency[client], sValue, sizeof(sValue)); // convert to string
			SetClientCookie(client, g_hCookieClient_BodyTransparency, sValue); // save to cookie	
			if(gb_Transparency[client])
			{
				SetEntityRenderMode(client, RENDER_NONE);
			}
			else 
			{
				SetEntityRenderMode(client, RENDER_NORMAL);
			}
			
			g_BodyTransparent = BuildTransparentMenu(client);
			g_BodyTransparent.Display(client, MENU_TIME_FOREVER);
		}
	}
		
	if(action == MenuAction_Cancel) 
	{
        if(param2 == MenuCancel_ExitBack) 
        {
        	g_BodyModification.Display(client, MENU_TIME_FOREVER);
        }
		
	}
}


//////////////////////////////////////
/////////////////Etc//////////////////
//////////////////////////////////////

public void ScaleEntity(int client, int ScaleType, float fScale)
{
	SetEntProp(client, Prop_Send, "m_ScaleType", ScaleType);
	SetEntPropFloat(client, Prop_Send, "m_flModelScale", fScale);
}

public void Client_SuperFat(int client)
{
	ScaleEntity(client, 1, 1.7);
}

public void Client_Fat(int client)
{
	ScaleEntity(client, 1, 1.4);
}

public void Client_Normal(int client)
{
	ScaleEntity(client, 1, 1.0);
}

public void Client_Skinny(int client)
{
	ScaleEntity(client, 1, 0.7);
}

public void Client_SuperSkinny(int client)
{
	ScaleEntity(client, 1, 0.5);
}