
//////////////////////////////////////
/////////////MAIN MENUS///////////////
//////////////////////////////////////



//////////////////////////////////////
////////////////ETC//////////////////
//////////////////////////////////////

public void Set_Player_Color(any userid, char[] sColorToSet, bool bSilent)
{
	char buffer[128];
	char buffer2[128];
	char sMessage[128];		
	int client;
	
	
	client = GetClientOfUserId(userid);
	if (!client)
		return;
	
	//LogError("Set_Player_Color userID= %i Client= %i", userid, client);
	
	Format(buffer, sizeof(buffer), "%T", "SetColor", LANG_SERVER);
	
	
	if (StrEqual(sColorToSet, "Normal_Body_Color"))
	{
		SetEntityRenderColor(client, 255, 255, 255, 255);
		Format(sMessage, sizeof(sMessage), "%T", "SetNormalColor", LANG_SERVER);	
	}
		
	if (StrEqual(sColorToSet, "Green")) 
	{
		SetEntityRenderColor(client, 0, 255, 0, 255);
		Format(buffer2, sizeof(buffer2), "%t", "Green", LANG_SERVER);
		Format(sMessage, sizeof(sMessage), "%s %s \x04%s",g_sTag, buffer, buffer2);		
	}
	
	if (StrEqual(sColorToSet, "Red"))
	{
		SetEntityRenderColor(client, 255, 0, 0, 255);
		Format(buffer2, sizeof(buffer2), "%t", "Red", LANG_SERVER);
		Format(sMessage, sizeof(sMessage), "%s %s \x02%s",g_sTag, buffer, buffer2);		
	}
	
	if (StrEqual(sColorToSet, "Blue"))
	{
		SetEntityRenderColor(client, 0, 0, 255, 255);
		Format(buffer2, sizeof(buffer2), "%t", "Blue", LANG_SERVER);
		Format(sMessage, sizeof(sMessage), "%s %s \x0C%s",g_sTag, buffer, buffer2);
	}
	
	if (StrEqual(sColorToSet, "Gold"))
	{
		SetEntityRenderColor(client, 255, 215, 0, 255);
		Format(buffer2, sizeof(buffer2), "%t", "Gold", LANG_SERVER);
		Format(sMessage, sizeof(sMessage), "%s %s \x10%s",g_sTag, buffer, buffer2);
	}
	
	if (StrEqual(sColorToSet, "Black"))
	{
		SetEntityRenderColor(client, 0, 0, 0, 255);
		Format(buffer2, sizeof(buffer2), "%t", "Black", LANG_SERVER);
		Format(sMessage, sizeof(sMessage), "%s %s %s",g_sTag, buffer, buffer2);
	}
	
	if (StrEqual(sColorToSet, "Cyan"))
	{
		SetEntityRenderColor(client, 0, 255, 255, 255);	
		Format(buffer2, sizeof(buffer2), "%t", "Cyan", LANG_SERVER);		
		Format(sMessage, sizeof(sMessage), "%s %s \x0B%s",g_sTag, buffer, buffer2);
		
	}
	
	if (StrEqual(sColorToSet, "Turquoise"))
	{
		SetEntityRenderColor(client, 64, 224, 208, 255);
		Format(buffer2, sizeof(buffer2), "%t", "Turquoise", LANG_SERVER);
		Format(sMessage, sizeof(sMessage), "%s %s \x0B%s",g_sTag, buffer, buffer2);
	}
	
	if (StrEqual(sColorToSet, "SkyBlue"))
	{
		SetEntityRenderColor(client, 0, 191, 255, 255);
		Format(buffer2, sizeof(buffer2), "%t", "SkyBlue", LANG_SERVER);	
		Format(sMessage, sizeof(sMessage), "%s %s \x0C%s",g_sTag, buffer, buffer2);		
	}
	
	if (StrEqual(sColorToSet, "Yellow"))
	{
		SetEntityRenderColor(client, 255, 255, 0, 255);
		Format(buffer2, sizeof(buffer2), "%t", "Yellow", LANG_SERVER);
		Format(sMessage, sizeof(sMessage), "%s %s \x09%s",g_sTag, buffer, buffer2);			
	}
	
	if (StrEqual(sColorToSet, "Pink"))
	{
		SetEntityRenderColor(client, 255, 105, 180, 255);
		Format(buffer2, sizeof(buffer2), "%t", "Pink", LANG_SERVER);
		Format(sMessage, sizeof(sMessage), "%s %s \x03%s",g_sTag, buffer, buffer2);
	}
	
	if (StrEqual(sColorToSet, "Purple"))
	{
		SetEntityRenderColor(client, 128, 0, 128, 255);
		Format(buffer2, sizeof(buffer2), "%t", "Purple", LANG_SERVER);
		Format(sMessage, sizeof(sMessage), "%s %s \x0E%s",g_sTag, buffer, buffer2);				
	}
	
	if (StrEqual(sColorToSet, "Gray"))
	{
		SetEntityRenderColor(client, 128, 128, 128, 255);		
		Format(buffer2, sizeof(buffer2), "%t", "Gray", LANG_SERVER);
		Format(sMessage, sizeof(sMessage), "%s %s \x0D%s",g_sTag, buffer, buffer2);	
	}
	
	
	SetClientCookie(client, g_hCookieClient_Color, sColorToSet);
	
	if (!bSilent)
	{
		CPrintToChat(client, "%s", sMessage);
	}
}

public void Set_Player_BodyType(any userid, char[] sBodyType)
{
	int client = GetClientOfUserId(userid);
	if (!client)
		return;
		
	if (StrEqual(sBodyType, "SuperFat"))
	{
		ScaleEntity(client, 1, 1.6);
	}
	
	if (StrEqual(sBodyType, "Fat"))
	{
		ScaleEntity(client, 1, 1.3);
	}
	
	
	if (StrEqual(sBodyType, "BodyNormal"))
	{
		ScaleEntity(client, 1, 1.0);
	}
	
	
	if (StrEqual(sBodyType, "Skinny"))
	{
		ScaleEntity(client, 1, 0.7);
	}
	
	if (StrEqual(sBodyType, "SuperSkinny"))
	{
		ScaleEntity(client, 1, 0.5);
	}
	
}