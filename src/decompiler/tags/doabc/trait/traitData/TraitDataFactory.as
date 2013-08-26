package decompiler.tags.doabc.trait.traitData
{
	import decompiler.tags.doabc.ABCFile;

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
		public static function creatTrait(kind:int, abcFile:ABCFile):AbstractTraitData
		{
			switch(kind)
			{
				case 0: return abcFile.elementFactory(TraitSlot) as TraitSlot;
				case 1: return abcFile.elementFactory(TraitMethod) as TraitMethod;
				case 2: return abcFile.elementFactory(TraitGetter) as TraitGetter;
				case 3: return abcFile.elementFactory(TraitSetter) as TraitSetter;
				case 4: return abcFile.elementFactory(TraitClass) as TraitClass;
				case 5: return abcFile.elementFactory(TraitFunction) as TraitFunction;
				case 6: return abcFile.elementFactory(TraitConst) as TraitConst;
				default: throw new Error("unkown trait kind:" + kind);
			}
		}
		
		public static function getTypeNameByKind(kind:int):String
		{
			switch(kind)
			{
				case 0:	return "Trait_Slot";
				case 1:	return "Trait_Method";
				case 2:	return "Trait_Getter";
				case 3:	return "Trait_Setter";
				case 4:	return "Trait_Class";
				case 5:	return "Trait_Function";
				case 6:	return "Trait_Const";
				default:return "unkownTraitKind";
			}
		}
	}
}