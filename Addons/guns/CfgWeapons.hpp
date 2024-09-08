class CfgWeapons {
    class mortar_82mm;
        class NDS_W_M224_mortar: mortar_82mm {
            magazines[] =
            {
                "NDS_M_6Rnd_60mm_HE",
                "NDS_M_6Rnd_60mm_HE_0",
                "NDS_M_6Rnd_60mm_ILLUM",
                "avm224_M_6Rnd_60mm_ILLUM_IR",
                "NDS_M_6Rnd_60mm_SMOKE",
                "HabFuze_M_6Rnd_60mm_SMOKE_0",
                "HabFuze_M_6Rnd_60mm_SMOKE"
            };
        };
    class habfuze_m224_mortar_proxy: NDS_W_M224_mortar {
        magazines[] =
                    {
                        "NDS_M_6Rnd_60mm_HE",
                        "NDS_M_6Rnd_60mm_HE_0",
                        "NDS_M_6Rnd_60mm_ILLUM",
                        "avm224_M_6Rnd_60mm_ILLUM_IR",
                        "NDS_M_6Rnd_60mm_SMOKE",
                        "HabFuze_M_6Rnd_60mm_SMOKE_0",
                        "HabFuze_M_6Rnd_60mm_SMOKE"
                    };
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
