_mortar = _this;

_pickupAction = [
	"pickupAction",
	"Pick up",
	"",
	{
		[_target, _player] call ace_csw_fnc_assemble_pickupTripod;
	},
	{isNull gunner _target}
] call ace_interact_menu_fnc_createAction;

[_mortar, 0, ["ACE_MainActions"], _pickupAction] call ace_interact_menu_fnc_addActionToObject;

    fn_HabFuze_WP_smoke = {
        private ["_smokegen", "_smokegen2", "_pos", "_pos2"];

        if (!hasinterface) exitwith {};

        _pos = [(_this select 0), _this select 1, 0];
        _pos2 = [((_this select 0)+5), _this select 1, 0];

        _smokegen = "#particlesource" createvehicle _pos;
        _smokegen setPosATL _pos;
        _smokegen setParticleClass "HabFuze_WPLinger";

        sleep 45.0;
        deletevehicle _smokegen;
    };

fn_NDS_M224_repos = {
    private ["_mor", "_dir"];

    _mor = _this select 0;
    _dir = _this select 1;

    if (local _mor) then {
        _mor setPosATL [getPos _mor select 0, getPos _mor select 1, (getPos _mor select 2)+0.2];
        _mor setDir _dir;
    } else {
        PVM224repos = _this;
        if (isDedicated) then {
            (owner _mor) publicVariableClient "PVM224repos";
        } else {
            publicVariableServer "PVM224repos";
        };
    };
};

"PVM224repos" addpublicVariableEventHandler {
    (_this select 1) call fn_NDS_M224_repos;
};

fn_NDS_M224_in = {
    private ["_hdg", "_pos", "_mor", "_varname", "_morai", "_gnr", "_oldname", "_c", "_magcount", "_mags"];

    _mor = (_this select 0);
    _gnr = (_this select 1);

    _hp = "land_HelipadEmpty_F" createvehicle (getPos _mor);
    _hp setDir (getDir _mor);
    _mor attachto [_hp];

    if (local _mor) then {
        // if !(isplayer _gnr) exitwith {
            if (isplayer _gnr) then {
                // *************************calculate fire arc limits***************
                _mordir = getDir _mor;

                _M224arc1 = _mor getPos [1350, (_mordir - 45)];
                _M224arc15 = _mor getPos [1350, (_mordir - 50)];

                _M224arc2 = _mor getPos [1350, (_mordir + 45)];
                _M224arc25 = _mor getPos [1350, (_mordir + 50)];

                waitUntil {
                    shownArtilleryComputer
                };
                _ctrl = [500, _M224arc1, _M224arc15, _M224arc2, _M224arc25] call CH_fnc_findControl;
            } else {
                // *****************************************************************
                // ---------------------get ammo
                _mags = magazinesAmmo _mor;
                _magcount = count _mags;
                // -----------------------
                _oldname = vehicleVarName _mor;
                if (_oldname != "") then {
                    _varname = vehicleVarName _mor;
                    // _gnr = (_this select 1);
                    _pos = getPos _mor;
                    _hdg = getDir _mor;
                    // enableradio false;
                    deletevehicle _mor;
                    _morai = "NDS_M224_mortar_AI" createvehicle _pos;
                    _morai setPos _pos;
                    _morai setDir _hdg;

                    if (local _gnr) then {
                        _gnr moveInGunner _morai;
                    } else {
                        [ _gnr, _morai ] remoteExec [ "moveInGunner", _gnr ];
                    };

                    _morai setvehicleVarName _varname;
                    call compile format["%1 = _morai", _varname];
                    publicVariable _varname;

                    {
                        _morai removeMagazine _x
                    } forEach magazines _morai;
                    _c = 0;
                    // <-------setAmmo
                    while {_c <= (_magcount - 1)} do {
                        _morai addMagazine (_mags select _c);
                        _c = _c + 1
                    };
                    _c = 0;
                } else {
                    _pos = getPos _mor;
                    _hdg = getDir _mor;
                    deletevehicle _mor;
                    _morai = "NDS_M224_mortar_AI" createvehicle _pos;
                    _morai setPos _pos;
                    _morai setDir _hdg;

                    if (local _gnr) then {
                        _gnr moveInGunner _morai;
                    } else {
                        [ _gnr, _morai ] remoteExec [ "moveInGunner", _gnr ];
                    };

                    {
                        _morai removeMagazine _x
                    } forEach magazines _morai;
                    _c = 0;
                    // <-------setAmmo
                    while {_c <= (_magcount - 1)} do {
                        _morai addMagazine (_mags select _c);
                        _c = _c + 1
                    };
                    _c = 0;
                };
            };
        } else {
            PVM224getin = _this;
            if (isDedicated) then {
                (owner _mor) publicVariableClient "PVM224getin";
            } else {
                publicVariableServer "PVM224getin";
            };
        };
    };
    "PVM224getin" addpublicVariableEventHandler {
        (_this select 1) call fn_NDS_M224_in;
    };

    fn_NDS_M224_out = {
        private ["_gnr", "_hdg", "_pos", "_mor", "_varname", "_mororg", "_oldname", "_c", "_magcount", "_mags"];

        // if (!hasinterface) exitwith {};
        // if (!isplayer (_this select 1)) then {
            _mor = (_this select 0);
            _gnr = (_this select 1);
            _hp = attachedTo _mor;
            detach _mor;
            deleteVehicle _hp;

            if (local _mor) then {
                if !(isplayer _gnr) exitwith {
                    // ---------------------get ammo
                    _mags = magazinesAmmo _mor;
                    _magcount = count _mags;
                    // -----------------------
                    _oldname = vehicleVarName _mor;

                    if (_oldname != "") then {
                        _varname = vehicleVarName _mor;
                        _pos = getPos _mor;
                        _hdg = getDir _mor;
                        deletevehicle _mor;
                        _mororg = "avm224_M224_mortar" createvehicle _pos;
                        _mororg setPos _pos;
                        _mororg setDir _hdg;
                        _mororg setvehicleVarName _varname;
                        call compile format["%1 = _mororg", _varname];
                        publicVariable _varname;
                        {
                            _mororg removeMagazine _x
                        } forEach magazines _mororg;
                        _c = 0;
                        // <-------setAmmo
                        while {_c <= (_magcount - 1)} do {
                            _mororg addMagazine (_mags select _c);
                            _c = _c + 1
                        };
                        _c = 0;
                    } else {
                        _pos = getPos _mor;
                        _hdg = getDir _mor;
                        deletevehicle _mor;
                        _mororg = "avm224_M224_mortar" createvehicle _pos;
                        _mororg setPos _pos;
                        _mororg setDir _hdg;
                        {
                            _mororg removeMagazine _x
                        } forEach magazines _mororg;
                        _c = 0;
                        // <-------setAmmo
                        while {_c <= (_magcount - 1)} do {
                            _mororg addMagazine (_mags select _c);
                            _c = _c + 1
                        };
                        _c = 0;
                    };
                    // else
                };
            } else {
                PVM224getout = _this;
                if (isDedicated) then {
                    (owner _mor) publicVariableClient "PVM224getout";
                } else {
                    publicVariableServer "PVM224getout";
                };
            };
        };
        "PVM224getout" addpublicVariableEventHandler {
            (_this select 1) call fn_NDS_M224_out;
        };

        fn_HabFuze_M224_rearm = {
            private ["_mor", "_magcast", "_countgwh", "_found", "_a", "_search", "_cnthe1", "_cnthe0", "_cntwp1", "_cntwpi0", "_cntwpi1","_cntill", "_foundbox", "_ammoboxes", "_ammoboxcount", "_mags", "_magcount", "_forload", "_c", "_loaded", "_dir", "_empties", "_remain", "_fulls"];

            _mor = _this select 0;
            _unload = _this select 1;

            if (local _mor) then {
                if (_unload == 1) then {
                    _pos = _mor getRelPos [2, 135];
                    _mags = magazinesAmmo _mor;
                    _magcount = count _mags;
                    if (_magcount == 0) exitwith {
                        hint "already unloaded"
                    };
                    _c=0;
                    _fulls = "groundweaponholder" createvehicle _pos;

                    while {_magcount > 0} do {
                        _fulls additemCargoGlobal [((_mags select _c) select 0), 1];
                        _c=_c+1;
                        _magcount = _magcount -1;
                    };
                    _c=0;
                    _fulls setPos _pos;
                    {
                        _mor removeMagazine _x
                    } forEach magazines _mor;
                } else {
                    _magcast = _mor nearObjects ["GroundWeaponHolder", 5];
                    _countgwh = count _magcast;
                    _found = count _magcast;
                    _a=0;
                    while {_countgwh > 0} do {
                        _search = magazinesAmmo (_magcast select _a);
                        _cntwpi0 = {
                            _x isEqualto ["HabFuze_M_6Rnd_60mm_SMOKE_0", 6]
                        } count _search;
                        _cntwpi1 = {
                            _x isEqualto ["HabFuze_M_6Rnd_60mm_SMOKE", 6]
                        } count _search;
                        _cnthe1 = {
                            _x isEqualto ["NDS_M_6Rnd_60mm_HE", 6]
                        } count _search;
                        _cnthe0 = {
                            _x isEqualto ["NDS_M_6Rnd_60mm_HE_0", 6]
                        } count _search;
                        _cntwp1 = {
                            _x isEqualto ["NDS_M_6Rnd_60mm_SMOKE", 6]
                        } count _search;
                        _cntill = {
                            _x isEqualto ["NDS_M_6Rnd_60mm_ILLUM", 6]
                        } count _search;
                        if (_cnthe1 + _cnthe0 + _cntwp1 +_cntill + _cntwpi0 + _cntwpi1 == 0) then {
                            _a=_a+1;
                            _countgwh = _countgwh -1;
                        } else {
                            _countgwh = 0;
                        };
                    };
                    if (_found == _a) exitwith {
                        hint "no ammoboxes!"
                    };
                    _foundbox = (_magcast select _a);
                    _ammoboxes = magazinesAmmo _foundbox;
                    _ammoboxcount = count _ammoboxes;

                    _mags = magazinesAmmo _mor;
                    _magcount = count _mags;

                    _forload = 6-_magcount;
                    _c=0;
                    _loaded=0;
                    if (_forload >=1) then {
                        while {_magcount <= 5 and _ammoboxcount >0} do {
                            _mor addMagazine (_ammoboxes select _c);
                            _magcount = _magcount + 1;
                            _ammoboxcount = _ammoboxcount -1;_loaded = _loaded + 1;_c = _c + 1;
                        };
                        _mags = magazinesAmmo _mor;
                        _pos = getPos _foundbox;
                        _dir = getDir _foundbox;
                        deletevehicle _foundbox;
                        _empties = "groundweaponholder" createvehicle _pos;
                        _empties addmagazineCargoGlobal ["NDS_M224_mag_empty_m", _loaded];
                        _empties setDamage 1;
                        deletevehicle _foundbox;
                        _ammoboxcount = count _ammoboxes;
                        _remain = _ammoboxcount - _loaded;

                        _fulls = "groundweaponholder" createvehicle _pos;
                        _fulls additemCargoGlobal [((_ammoboxes select _c) select 0), _remain];

                        _fulls setPos _pos;
                        _fulls setDir _dir;

                        _c=0;
                        _loaded=0;
                    } else {
                        hint "mortar fully loaded"
                    };
                };
            } else {
                PVM224rearm = _this;
                if (isDedicated) then {
                    (owner _mor) publicVariableClient "PVM224rearm";
                } else {
                    publicVariableServer "PVM224rearm";
                };
            };
        };
        "PVM224rearm" addpublicVariableEventHandler {
            (_this select 1) call fn_HabFuze_M224_rearm;
        };

        CH_fnc_findControl = {
            disableSerialization;
            _idc = _this select 0;

            _ret = controlnull;
            {
                if (!isNull (_x displayCtrl _idc)) exitwith {
                    _ret = _x displayCtrl _idc
                };
            } forEach (allDisplays + (uiNamespace getVariable "IGUI_Displays"));
            _ret;
            _ctrl = _ret;

            M224arc1 = _this select 1;
            M224arc15 = _this select 2;
            M224arc2 = _this select 3;
            M224arc25 = _this select 4;

            _ctrl ctrlremoveAllEventHandlers "Draw";
            _ctrl ctrlAddEventHandler ["Draw",
                {
                    _map = _this select 0;
                    _map drawLine [(position player), M224arc1, [0, 1, 0, 0.5]];
                    _map drawLine [(position player), M224arc2, [0, 1, 0, 0.5]];
                    _map drawTriangle [[(position player), M224arc1, M224arc15], [1, 0, 0, 0.5], "#(rgb, 1, 1, 1)color(1, 0, 0, 0.3)"];
                    _map drawTriangle [[(position player), M224arc2, M224arc25], [1, 0, 0, 0.5], "#(rgb, 1, 1, 1)color(1, 0, 0, 0.3)"];
                }];

                waitUntil {
                    !shownArtilleryComputer
                };
                waitUntil {
                    shownArtilleryComputer
                };
                _ctrl = [500, M224arc1, M224arc15, M224arc2, M224arc25] call CH_fnc_findControl;
            };