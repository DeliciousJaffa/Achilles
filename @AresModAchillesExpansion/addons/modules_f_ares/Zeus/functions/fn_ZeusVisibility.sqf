////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: by Anton Struyk, modified by Kex
//	DATE: 1/4/17
//	VERSION: 2.0
//  DESCRIPTION: Function for module "hide zeus"
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


#include "\achilles\modules_f_ares\module_header.inc.sqf"

private _dialogResult =
[
	localize "STR_AMAE_HIDE_ZEUS",
	[
		[
			localize "STR_AMAE_HIDE_ZEUS", [localize "STR_AMAE_YES", localize "STR_AMAE_NO"]
		]
	]
] call Ares_fnc_ShowChooseDialog;

if (_dialogResult isEqualTo []) exitWith {};

private _invisible = (_dialogResult select 0) == 0;
private _display_text = [localize "STR_AMAE_ZEUS_IS_NOW_VISIBLE", localize "STR_AMAE_ZEUS_IS_NOW_HIDDEN"] select _invisible;

private _curatorLogic = getAssignedCuratorLogic player;
if (_invisible and !(isObjectHidden player)) then
{
	[player, true] remoteExecCall ["hideObjectGlobal",2];
	[player, false] remoteExecCall ["allowDamage"];
	player setCaptive true;
	_curatorLogic setVariable ["showNotification", true];

	private _eagle = _curatorLogic getVariable ["bird", objNull];
	if (!isNull _eagle) then
	{
		[_eagle, true] remoteExecCall ["hideObjectGlobal",2];
		[_eagle, false] remoteExecCall ["enableSimulationGlobal",2];
	};
}
else
{
	if (!_invisible and (isObjectHidden player)) then
	{
		[player, false] remoteExecCall ["hideObjectGlobal",2];
		[player, true] remoteExecCall ["allowDamage"];
		player setCaptive false;
		_curatorLogic setVariable ["showNotification", false];

		private _eagle = _curatorLogic getVariable ["bird", objNull];
		if (!isNull _eagle) then
		{
			[_eagle, true] remoteExecCall ["enableSimulationGlobal",2];
			[_eagle, false] remoteExecCall ["hideObjectGlobal",2];
		};
	};
};

[_display_text] call Ares_fnc_ShowZeusMessage;

#include "\achilles\modules_f_ares\module_footer.inc.sqf"
