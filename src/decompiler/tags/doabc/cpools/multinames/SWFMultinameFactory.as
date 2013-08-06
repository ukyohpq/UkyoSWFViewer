package decompiler.tags.doabc.cpools.multinames
{

	/**
	 * Multiname Kind 			Value
		CONSTANT_QName 			0x07
		CONSTANT_QNameA 		0x0D
		CONSTANT_RTQName 		0x0F
		CONSTANT_RTQNameA 		0x10
		CONSTANT_RTQNameL 		0x11
		CONSTANT_RTQNameLA 		0x12
		CONSTANT_Multiname 		0x09
		CONSTANT_MultinameA 	0x0E
		CONSTANT_MultinameL 	0x1B
		CONSTANT_MultinameLA 	0x1C
		CONSTANT_GenericName	0x1D
	 * @author ukyohpq
	 * 
	 */
	public final class SWFMultinameFactory
	{
		public function SWFMultinameFactory()
		{
		}
		
		public static function factory(kind:int):SWFMultiname
		{
			switch(kind)
			{
				case MultinameKind.CONSTANT_Multiname: 		return new CMultiname;
				case MultinameKind.CONSTANT_MultinameA: 	return new CMultinameA;
				case MultinameKind.CONSTANT_MultinameL: 	return new CMultinameL;
				case MultinameKind.CONSTANT_MultinameLA: 	return new CMultinameLA;
				case MultinameKind.CONSTANT_QName: 			return new CQName;
				case MultinameKind.CONSTANT_QNameA: 		return new CQNameA;
				case MultinameKind.CONSTANT_RTQName: 		return new CRTQName;
				case MultinameKind.CONSTANT_RTQNameA: 		return new CRTQNameA;
				case MultinameKind.CONSTANT_RTQNameL: 		return new CRTQNameL;
				case MultinameKind.CONSTANT_RTQNameLA: 		return new CRTQNameLA;
				case MultinameKind.CONSTANT_GenericName: 	return new CGenericName;
				default:
					throw new Error("wrong Multiname kind:" + kind);
			}
		}
	}
}