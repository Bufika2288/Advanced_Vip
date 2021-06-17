
//////////////////////////////////////
/////////////MAIN MENUS///////////////
//////////////////////////////////////

//FUn Menu
Menu BuildFunMenu()
{	
	char buffer[128];
	Menu menu = new Menu(Menu_Fun);
	
	Format(buffer, sizeof(buffer), "%T", "Other Fun stuff", LANG_SERVER);
	menu.AddItem("Other Fun stuff", buffer);
	
	Format(buffer, sizeof(buffer), "%T", "Troll Functions", LANG_SERVER);
	menu.AddItem("Troll Functions", buffer);
	
	Format(buffer, sizeof(buffer), "%T", "Body Modifications", LANG_SERVER);
	menu.AddItem("Body Modifications", buffer);
		
	Format(buffer, sizeof(buffer), "%T", "Spawn items", LANG_SERVER);
	menu.AddItem("Spawn items", buffer);
	
	Format(buffer, sizeof(buffer), "%T", "Fun Menu Title", LANG_SERVER);
	menu.SetTitle(buffer);
	menu.ExitBackButton = true;
	menu.Pagination = 8;
	
	return menu;
}

//Troll Menu
Menu BuildTrollMenu()
{	
	char buffer[128];
	Menu menu = new Menu(Menu_Troll);
	
	if ((GetConVarBool(sm_playsound_enable)))
	{
		Format(buffer, sizeof(buffer), "%T", "Play Fake Sounds", LANG_SERVER);
		menu.AddItem("Play Fake Sounds", buffer);
	}
	
	if ((GetCommandFlags("sm_fakecase") != INVALID_FCVAR_FLAGS)  && (GetConVarBool(sm_fakecase_enable)))
	{
		Format(buffer, sizeof(buffer), "%T", "Open Fake Case", LANG_SERVER);
		menu.AddItem("Open Fake Case", buffer);
	}
	
	if ((GetCommandFlags("sm_fakevackick") != INVALID_FCVAR_FLAGS) && (GetConVarBool(sm_fvk_enable)))
	{
		Format(buffer, sizeof(buffer), "%T", "Fake VAC Kick", LANG_SERVER);
		menu.AddItem("Fake VAC Kick", buffer);
		
	}
	
	Format(buffer, sizeof(buffer), "%T", "Troll Menu Title", LANG_SERVER);
	menu.SetTitle(buffer);
	menu.ExitBackButton = true;
	menu.Pagination = 8;
	
	return menu;
}

Menu BuildFVKMenu()
{
	char buffer[128];
	Menu menu = new Menu(Menu_FVK);
	
	Format(buffer, sizeof(buffer), "%T", "FVK Menu Title", LANG_SERVER);
	menu.SetTitle(buffer);
	
	AddTargetsToMenu2(menu, 0, COMMAND_FILTER_NO_BOTS);
	
	return menu;
}

Menu BuildSpawnMenu()
{
	char buffer[128];
	Menu menu = new Menu(Menu_Spawn);
	
	Format(buffer, sizeof(buffer), "%T", "Spawn Chicken", LANG_SERVER);
	menu.AddItem("Spawn Chicken", buffer);
	
	Format(buffer, sizeof(buffer), "%T", "Spawn Snow", LANG_SERVER);
	menu.AddItem("Spawn Snow", buffer);
		
	Format(buffer, sizeof(buffer), "%T", "Spawn SoccerBall", LANG_SERVER);
	menu.AddItem("Spawn SoccerBall", buffer);
	
	Format(buffer, sizeof(buffer), "%T", "Spawn items Menu Title", LANG_SERVER);
	menu.SetTitle(buffer);
	menu.ExitBackButton = true;
	menu.Pagination = 8;
	
	
	return menu;
}

Menu BuildOtherFunStuffMenu()
{
	char buffer[128];
	Menu menu = new Menu(Menu_OtherStuff);
	
	if ((GetCommandFlags("sm_rainingmoney") != INVALID_FCVAR_FLAGS) && (GetConVarBool(sm_rainmoney_enable)))
	{
		Format(buffer, sizeof(buffer), "%T", "Raining Money", LANG_SERVER);
		menu.AddItem("Raining Money", buffer);
	}
	
	Format(buffer, sizeof(buffer), "%T", "Other Stuff Menu Title", LANG_SERVER);
	menu.SetTitle(buffer);
	menu.ExitBackButton = true;
	menu.Pagination = 8;
	
	
	return menu;
}


Menu BuildFakeSoundMenu()
{
	char buffer[128];
	Menu menu = new Menu(Menu_FakeSound);

	Format(buffer, sizeof(buffer), "%T", "Bomb Has Been Defused Sound", LANG_SERVER);
	menu.AddItem("Bomb Has Been Defused Sound", buffer);
	
	Format(buffer, sizeof(buffer), "%T", "Bomb Has Been Planted Sound", LANG_SERVER);
	menu.AddItem("Bomb Has Been Planted Sound", buffer);
	
	Format(buffer, sizeof(buffer), "%T", "Hostage Rescue Sound", LANG_SERVER);
	menu.AddItem("Hostage Rescue Sound", buffer);
	
	Format(buffer, sizeof(buffer), "%T", "CT win Sound", LANG_SERVER);
	menu.AddItem("CT win Sound", buffer);
	
	Format(buffer, sizeof(buffer), "%T", "T win Sound", LANG_SERVER);
	menu.AddItem("T win Sound", buffer);
	
	Format(buffer, sizeof(buffer), "%T", "PlaySound Menu Title", LANG_SERVER);
	menu.SetTitle(buffer);
	menu.ExitBackButton = true;
	menu.Pagination = 8;
	
	
	return menu;
}

//////////////////////////////////////
///////////Menu Handlers//////////////
//////////////////////////////////////

public int Menu_FakeSound(Menu menu, MenuAction action, int param1, int param2)
{
	if(action == MenuAction_Select)
	{
		char items[32];
		char buffer[128];
		char buffer2[128];
		char sMessage[128];
		char SoundPlayed[128];
		menu.GetItem(param2, items, sizeof(items));
		
		Format(buffer, sizeof(buffer), "%t", "Cant Use Sound Now", LANG_SERVER);
		Format(sMessage, sizeof(sMessage), "%s %s",g_sTag, buffer);	
		
		Format(buffer2, sizeof(buffer2), "%t", "Sound Played successfully", LANG_SERVER);
		Format(SoundPlayed, sizeof(SoundPlayed), "%s %s",g_sTag, buffer2);	
		
		if (StrEqual(items, "Bomb Has Been Defused Sound")) 
		{
			if (gb_ClientCanUseSound[param1] == true)
			{
				EmitSoundToAll("radio/bombdef.wav");
				CPrintToChat(param1, "%s", SoundPlayed);
				gb_ClientCanUseSound[param1] = false;
			}
			else 
			{
				CPrintToChat(param1, "%s", sMessage);
			}
		}
		
		if (StrEqual(items, "Bomb Has Been Planted Sound")) 
		{
			if (gb_ClientCanUseSound[param1] == true)
			{
				EmitSoundToAll("radio/bombpl.wav");
				CPrintToChat(param1, "%s", SoundPlayed);
				gb_ClientCanUseSound[param1] = false;
			}
			else 
			{
				CPrintToChat(param1, "%s", sMessage);
			}
		}
		
		if (StrEqual(items, "Hostage Rescue Sound")) 
		{
			if (gb_ClientCanUseSound[param1] == true)
			{
				EmitSoundToAll("radio/rescued.wav");
				CPrintToChat(param1, "%s", SoundPlayed);
				gb_ClientCanUseSound[param1] = false;
			}
			else 
			{
				CPrintToChat(param1, "%s", sMessage);
			}
		}
		
		if (StrEqual(items, "CT win Sound")) 
		{
			if (gb_ClientCanUseSound[param1] == true)
			{
				EmitSoundToAll("radio/ctwin.wav");
				CPrintToChat(param1, "%s", SoundPlayed);
				gb_ClientCanUseSound[param1] = false;
			}
			else 
			{
				CPrintToChat(param1, "%s", sMessage);
			}
		}
		
		if (StrEqual(items, "T win Sound")) 
		{		
			if (gb_ClientCanUseSound[param1] == true)
			{
				EmitSoundToAll("radio/terwin.wav");
				CPrintToChat(param1, "%s", SoundPlayed);
				gb_ClientCanUseSound[param1] = false;
			}
			else 
			{
				CPrintToChat(param1, "%s", sMessage);
			}
		}
		
		CreateTimer(sm_playsound_cooldown.FloatValue, Timer_EnableSound, param1);
		g_FakeSound.Display(param1, MENU_TIME_FOREVER);
	}
	
	if(action == MenuAction_Cancel)
	{
	      if(param2 == MenuCancel_ExitBack) 
		{
			g_FunMenu.Display(param1, MENU_TIME_FOREVER);
		}
	}
}

public int Menu_Fun(Menu menu, MenuAction action, int param1, int param2)
{
	if(action == MenuAction_Select)
	{
		char items[32];
		menu.GetItem(param2, items, sizeof(items));
		
		if (StrEqual(items, "Other Fun stuff")) 
		{
			g_OtherFunStuffMenu.Display(param1, MENU_TIME_FOREVER);
		}

		if (StrEqual(items, "Troll Functions")) 
		{
			g_TrollFunctions.Display(param1, MENU_TIME_FOREVER);
		}
		
		if (StrEqual(items, "Body Modifications")) 
		{
			g_BodyModification.Display(param1, MENU_TIME_FOREVER);
		}
		
		if (StrEqual(items, "Spawn items")) 
		{
			g_SpawnMenu.Display(param1, MENU_TIME_FOREVER);
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


public int Menu_FVK(Menu menu, MenuAction action, int client, int param2)
{
	if(action == MenuAction_Select)
	{
		char items[32];
		char buffer[128];
		char sMessage[128];
		int target;
	
		menu.GetItem(param2, items, sizeof(items));
		int userid = StringToInt(items);
		
		Format(buffer, sizeof(buffer), "%t", "Cant Use FVK Now", LANG_SERVER);
		Format(sMessage, sizeof(sMessage), "%s %s", g_sTag, buffer);	
	
		if ((target = GetClientOfUserId(userid)) == 0)
		{
			Format(buffer, sizeof(buffer), "%T", "FVC Failed", LANG_SERVER);
			CPrintToChat(client, "%s %s", g_sTag, buffer);
		}
		else
		{
			if (gb_ClientCanUseFVK[client] == true)
			{
				ClientCommand(client, "sm_fakevackick %N", target);
				gb_ClientCanUseSound[client] = false;
				CreateTimer(sm_fvk_cooldown.FloatValue, Timer_EnableFvk, client);
			}
			else 
			{
				CPrintToChat(client, "%s", sMessage);
			}
		}
	}
	
	if(action == MenuAction_Cancel) 
	{
	     if(param2 == MenuCancel_ExitBack) 
		{
			g_FunMenu.Display(client, MENU_TIME_FOREVER);
		}
	}
}



public int Menu_Troll(Menu menu, MenuAction action, int param1, int param2)
{
	if(action == MenuAction_Select)
	{
		char items[32];
		menu.GetItem(param2, items, sizeof(items));

		if (StrEqual(items, "Play Fake Sounds")) 
		{
			g_FakeSound.Display(param1, MENU_TIME_FOREVER);
		}
		
		if (StrEqual(items, "Open Fake Case")) 
		{
			ClientCommand(param1, "sm_case");
		}
		
		if (StrEqual(items, "Fake VAC Kick")) 
		{
			g_FVKMenu.Display(param1, MENU_TIME_FOREVER);
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

public int Menu_OtherStuff(Menu menu, MenuAction action, int param1, int param2)
{
	if(action == MenuAction_Select)
	{
		char items[32];
		menu.GetItem(param2, items, sizeof(items));
		
		if (StrEqual(items, "Raining Money")) 
		{
			ClientCommand(param1, "sm_rainingmoney");
		}
		g_OtherFunStuffMenu.Display(param1, MENU_TIME_FOREVER);
	}
	
	if(action == MenuAction_Cancel) 
	{
	     if(param2 == MenuCancel_ExitBack) 
		{
			g_FunMenu.Display(param1, MENU_TIME_FOREVER);
		}
	}
}


public int Menu_Spawn(Menu menu, MenuAction action, int param1, int param2)
{
	if(action == MenuAction_Select)
	{
		char items[32];
		menu.GetItem(param2, items, sizeof(items));
		
		if (StrEqual(items, "Spawn Snow")) 
		{
			//Code from advanced admin maded by PeEzZ
			float vec[2][3];
			GetClientEyePosition(param1, vec[0]);
			GetClientEyeAngles(param1, vec[1]);
			
			Handle trace = TR_TraceRayFilterEx(vec[0], vec[1], MASK_SOLID, RayType_Infinite, Filter_ExcludePlayers);
			TR_GetEndPosition(vec[0], trace);
			CloseHandle(trace);
			
			
			int snow = CreateEntityByName("ent_snowball_pile");
			DispatchSpawn(snow);
			vec[0][2] = vec[0][2] + 16.0;
			TeleportEntity(snow, vec[0], vec[1], NULL_VECTOR);
		}

		if (StrEqual(items, "Spawn SoccerBall")) 
		{
			float vec[2][3];
			GetClientEyePosition(param1, vec[0]);
			GetClientEyeAngles(param1, vec[1]);
			
			Handle trace = TR_TraceRayFilterEx(vec[0], vec[1], MASK_SOLID, RayType_Infinite, Filter_ExcludePlayers);
			TR_GetEndPosition(vec[0], trace);
			CloseHandle(trace);
			
			int ball = CreateEntityByName("prop_physics_multiplayer");
			
			DispatchKeyValue(ball, "model", "models/props/de_dust/hr_dust/dust_soccerball/dust_soccer_ball001.mdl");
			DispatchKeyValue(ball, "physicsmode", "2");
			DispatchSpawn(ball);
			vec[0][2] = vec[0][2] + 16.0;
			TeleportEntity(ball, vec[0], vec[1], NULL_VECTOR);
		}
		
		if (StrEqual(items, "Spawn Chicken")) 
		{
			float vec[2][3];
			GetClientEyePosition(param1, vec[0]);
			GetClientEyeAngles(param1, vec[1]);
			
			Handle trace = TR_TraceRayFilterEx(vec[0], vec[1], MASK_SOLID, RayType_Infinite, Filter_ExcludePlayers);
			TR_GetEndPosition(vec[0], trace);
			CloseHandle(trace);
				
			int chicken = CreateEntityByName("chicken");
			DispatchSpawn(chicken);
			vec[0][2] = vec[0][2] + 1;
			TeleportEntity(chicken, vec[0], vec[1], NULL_VECTOR);
		}
		g_SpawnMenu.Display(param1, MENU_TIME_FOREVER);
	}
	
	if(action == MenuAction_Cancel)
	{
	     if(param2 == MenuCancel_ExitBack) 
		{
			g_FunMenu.Display(param1, MENU_TIME_FOREVER);
		}
	}
}

public bool Filter_ExcludePlayers(int entity, int contentsMask, any data)
{
	return !((entity > 0) && (entity <= MaxClients));
}

public Action Timer_EnableSound(Handle timer, any client)
{
	if (client)
		gb_ClientCanUseSound[client] = true;
}

public Action Timer_EnableFvk(Handle timer, any client)
{
	if (client)
		gb_ClientCanUseFVK[client] = true;
}
