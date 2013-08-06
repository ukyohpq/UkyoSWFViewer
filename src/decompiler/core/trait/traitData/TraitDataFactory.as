package decompiler.core.trait.traitData
{
	/**
	 * 	Type 			Value
		Trait_Slot 			0
		Trait_Method 		1
		Trait_Getter 		2
		Trait_Setter 		3
		Trait_Class 		4
		Trait_Function 		5
		Trait_Const 		6
	 * @author ukyohpq
	 * 
	 */
	public final class TraitDataFactory
	{
		public static function creatTrait(kind:int):AbstractTraitData
		{
			switch(kind)
			{
				case 0: return new TraitSlot;
				case 1: return new TraitMethod;
				case 2: return new TraitGetter;
				case 3: return new TraitSetter;
				case 4: return new TraitClass;
				case 5: return new TraitFunction;
				case 6: return new TraitConst;
				default: throw new Error("unkown trait kind:" + kind);
			}
		}
	}
}