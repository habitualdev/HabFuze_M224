	thisgun = _this select 0;
	
	thisgun addEventHandler ["GetIn", {
		params ["_vehicle", "_role", "_unit", "_turret"];
		_hp = "land_HelipadEmpty_F" createvehicle (getPos _vehicle);
		_hp setDir (getDir _vehicle);
    	_vehicle attachto [_hp];
		}];
	
	this addEventHandler ["GetOut", {
		params ["_vehicle", "_role", "_unit", "_turret", "_isEject"];
		_hp = attachedTo _vehicle;
		detach _vehicle;
        deleteVehicle _hp;
		}];
	
	private _gunName = getObjectID thisgun;
	explosionType = "NDS_A_60mm_HE";
	
	missionNamespace setVariable [_gunName,["IMPACT",1.0],true];
	
	thisgun addAction ["Edit Fuze Settings", {
		disableSerialization;
		private _thisObject = _this select 0;
		gunName = getObjectID _thisObject;
		publicVariable "gunName";
		private _display = findDisplay 46 createDisplay "RscDisplayEmpty";
		private _ctrlGroup = _display ctrlCreate ["RscControlsGroupNoScrollbars", -1];
		private _ctrlBackground = _display ctrlCreate ["RscTextMulti", -1, _ctrlGroup];
		private _fuze = missionNamespace getVariable gunName;
		IDD_EDIT_BOX = 123;
		private _ctrlEdit = _display ctrlCreate ["RscEditMulti", IDD_EDIT_BOX, _ctrlGroup];
		private _impactButton = _display ctrlCreate ["RscShortcutButton", -1, _ctrlGroup];
		private _timedButton = _display ctrlCreate ["RscShortcutButton", -1, _ctrlGroup];
		private _proxButton = _display ctrlCreate ["RscShortcutButton", -1, _ctrlGroup];
		_ctrlGroup ctrlSetPosition [0.5, 0.5, 0, 0];
		_ctrlGroup ctrlCommit 0;
		_ctrlBackground ctrlSetPosition [0, 0, 0.5, 0.3];
		_ctrlBackground ctrlSetBackgroundColor [0.5, 0.5, 0.5, 0.9];
		
		private _fuzeMod = _fuze select 1;
		private _fuzeType = _fuze select 0;
		
		_ctrlBackground ctrlSetText str _fuzeMod + "|" + _fuzeType;
		_ctrlBackground ctrlEnable false;
		_ctrlBackground ctrlCommit 0;
		_ctrlEdit ctrlSetPosition [0.01, 0.05, 0.48, 0.1];
		_ctrlEdit ctrlSetBackgroundColor [0, 0, 0, 0.5];
		_ctrlEdit ctrlCommit 0;
		
		_impactButton ctrlSetPosition [0.05, 0.21, 0.13, 0.05];
		_impactButton ctrlCommit 0;
		_impactButton ctrlSetText "IMPACT";
		_impactButton ctrlAddEventHandler ["ButtonClick",
		{
			params ["_ctrl"];
			_display = ctrlParent _ctrl;
			_text = ctrlText (_display displayCtrl IDD_EDIT_BOX);
			if (_text == "") then { _text = "10.0" };
			missionNamespace setVariable [gunName,["IMPACT", parseNumber _text],true];
		
			_display closeDisplay 1;
		}];
		
		_proxButton ctrlSetPosition [0.19, 0.21, 0.13, 0.05];
		_proxButton ctrlCommit 0;
		_proxButton ctrlSetText "PROX";
		_proxButton ctrlAddEventHandler ["ButtonClick",
		{
			params ["_ctrl"];
			_display = ctrlParent _ctrl;
			_text = ctrlText (_display displayCtrl IDD_EDIT_BOX);
			if (_text == "") then { _text = "10.0" };
			missionNamespace setVariable [gunName,["PROX", parseNumber _text],true];
			
			_display closeDisplay 1;
		}];
		
		_timedButton ctrlSetPosition [0.33, 0.21, 0.13, 0.05];
		_timedButton ctrlCommit 0;
		_timedButton ctrlSetText "TIMED";
		_timedButton ctrlAddEventHandler ["ButtonClick",
		{
			params ["_ctrl"];
			_display = ctrlParent _ctrl;
			_text = ctrlText (_display displayCtrl IDD_EDIT_BOX);
			if (_text == "") then { _text = "10.0" };
			
			missionNamespace setVariable [gunName,["TIMED", parseNumber _text],true];
		
			
			_display closeDisplay 1;
		}];
		
		ctrlSetFocus _ctrlEdit;
		_ctrlGroup ctrlSetPosition [0.25, 0.25, 0.5, 0.5];
		_ctrlGroup ctrlCommit 0.1;
		playSound "Hint3";
	}];
	
	
	
	thisgun addEventHandler ["Fired", 
	{_this spawn {
			private _thisObject = _this select 0;
			gunName = getObjectID _thisObject;
			private _fuze = missionNamespace getVariable gunName;
			if (_fuze select 0 isEqualTo "IMPACT") then {exit};
	        if (_fuze select 0 isEqualTo "PROX") then {
	        	private _thisGun =  _this select 0;
	        	private _gunPosition = getPosATL _thisGun;
	            private _shell = _this select 6;
	            private _explosionType = "NDS_A_60mm_HE";
				private _proxDistance = _fuze select 1;
	            waitUntil {
	                private _shellPos = getPos _shell;
	                private _distance = _shellPos distance _gunPosition;
	                _distance > 25;
	            };
	
	            while {alive _shell} do {
	                private _shellPos = getPos _shell;
	                private _shellGroundAlt = getPosATL _shell select 2;
	
	                if (_shellGroundAlt <= _proxDistance) then {
	                    _explosion = _explosionType createVehicle _shellPos;
	                    "habfuze_60mm" createVehicle _shellPos;
	                    deleteVehicle _shell;
	                    deleteVehicle _explosion;
	                };
	
	                sleep 0.01;
	            };
	        };
	        
	        if (_fuze select 0 isEqualTo "TIMED") then {
	        	private _shell = _this select 6;
	        	
				private _proxDistance = _fuze select 1;
				sleep _proxDistance;
				 private _shellPos = getPos _shell;
				_explosion = explosionType createVehicle _shellPos;
	            "habfuze_60mm" createVehicle _shellPos;
	            deleteVehicle _shell;
	            deleteVehicle _explosion;
	        
	        };
	        
	    };}];

