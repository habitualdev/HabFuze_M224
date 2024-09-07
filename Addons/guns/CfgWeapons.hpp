class CfgWeapons {
class NDS_W_M224_mortar;
    class habfuze_m224_mortar_proxy: NDS_W_M224_mortar {
        magazineReloadTime = 0.5;
    };
     class Launcher;
    class Launcher_Base_F: Launcher {
        class WeaponSlotsInfo;
    };
    class habfuze_m224_carry: Launcher_Base_F {
        displayName = "M224 (VT Fuze) Gun Bag";
        author = "habitual";
        model = "\z\ace\addons\apl\ACE_CSW_Bag.p3d";
        picture = "NDS_M224_mortar\cannon\data\ui\NDS_M224_icon_ca.paa";
        scope = 2;
        modes[] = {};
        class ACE_CSW {
            type = "mount"; // Use "weapon" for weapons or "mount" for tripods - see below
            deployTime = 2;  // How long it takes to deploy the weapon onto the tripod
            pickupTime = 2;  // How long it takes to disassemble weapon from the tripod
            deploy = "habfuze_m224_mortar";
        };
         class WeaponSlotsInfo: WeaponSlotsInfo {
            // One WeaponSlot with a positive value for iconScale forces game to use icon overlay method
            // Required, because the inventory icon has no accessory variants
            class MuzzleSlot {
                iconScale = 0.1;
            };

            // Don't forget to set mass to a reasonable value
            // We use mass in pounds * 10
            mass = 180; // 84 lb / 38 kg
        };
};
};
