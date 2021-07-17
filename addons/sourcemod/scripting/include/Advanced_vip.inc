#if defined _AdvancedVip_included_
  #endinput
#endif
#define _AdvancedVip_included_

public SharedPlugin __pl_AdvancedVip =
{
	name = "AdvancedVip",
	file = "Advanced_Vip.smx",
#if defined REQUIRE_PLUGIN
	required = 1
#else
	required = 0
#endif
};


public bool IsClientHasVip(int client)
{

	if(CheckAdminFlags(client, ReadFlagString(g_sMenu_Flag)))
	{
		return true;
	}
	else 
	{
		return false;
	}

}

public int PlayerMoney(int client)
{
	GetEntProp(client, Prop_Send, "m_iAccount"); 
}