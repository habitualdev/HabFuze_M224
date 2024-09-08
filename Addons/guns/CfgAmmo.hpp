class CfgAmmo{
    class Sh_82mm_AMOS;
	class NDS_A_60mm_HE;
	class habfuze_60mm: NDS_A_60mm_HE {
    explosionTime = 0.0001;
	};

	class HabFuze_A_60mm_SMOKE: Sh_82mm_AMOS
    	{
    	    ace_frag_metal = 10;
    	    ace_frag_charge = 10;
    		hit=50;
    		indirectHit=30;
    		indirectHitRange=6;
    		dangerRadiusHit=-1;
    		suppressionRadiusHit=15;
    		CraterEffects="HEShellCrater";
    		CraterWaterEffects="ImpactEffectsWaterHE";
    		ExplosionEffects="HabFuze_WPExplosion";
    		artilleryCharge=0.50999999;
    	};
    class HabFuze_A_60mm_SMOKE_0 : HabFuze_A_60mm_SMOKE
    {
        artilleryCharge = 0.50999999;
    };
};
