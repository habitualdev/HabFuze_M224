// M224
class CBA_Extended_EventHandlers_base;
class CfgVehicles {
	class LandVehicle;
	class StaticWeapon: LandVehicle {
	};
	class StaticMortar: StaticWeapon {
		
	};
	class Mortar_01_Base_F: StaticMortar {
		class Turrets
        		{
        			class MainTurret;
        		};
	};
	
	class NDS_M224_mortar_base : Mortar_01_Base_F{
	
	};
	
	class NDS_M224_mortar : NDS_M224_mortar_base{
		};
	
	class habfuze_m224_mortar : NDS_m224_mortar {
	
	displayname = "M224 VT Fuze";
		scopeCurator = 2;
		class EventHandlers {
			init = "(_this select 0) execVM ""\z\avm224\addons\mortar\scripts\NDS_M224_init.sqf""; _this call HAB_FUZE_M224_fnc_init_m224_fuzes";
			class CBA_Extended_EventHandlers: CBA_Extended_EventHandlers_base {};
		};
		class ACE_CSW {
            enabled = 1; // Enables ACE CSW for this weapon              
            proxyWeapon = "habfuze_m224_mortar_proxy"; // The proxy weapon created above
            magazineLocation = "_target selectionPosition 'zbytek'"; // Ammo handling interaction point location
            disassembleTo = "habfuze_m224_carry";
            disassembleWeapon = "";
            disassembleTurret = "";
            ammoLoadTime = 2;   // How long it takes in seconds to load ammo into the weapon           
            ammoUnloadTime = 2; // How long it takes in seconds to unload ammo from the weapon
            desiredAmmo = 1;  // When the weapon is reloaded it will try and reload to this ammo capacity
        };
	};
};
