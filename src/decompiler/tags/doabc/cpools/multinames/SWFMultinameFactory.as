package decompiler.tags.doabc.cpools.multinames
{
	import decompiler.tags.doabc.ABCFile;

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
		
		public static function factory(kind:int, abcFile:ABCFile):SWFMultiname
		{
			switch(kind)
			{
				case MultinameKind.CONSTANT_Multiname: 		return abcFile.elementFactory(CMultiname) as CMultiname;
				case MultinameKind.CONSTANT_MultinameA: 	return abcFile.elementFactory(CMultinameA) as CMultinameA;
				case MultinameKind.CONSTANT_MultinameL: 	return abcFile.elementFactory(CMultinameL) as CMultinameL;
				case MultinameKind.CONSTANT_MultinameLA: 	return abcFile.elementFactory(CMultinameLA) as CMultinameLA;
				case MultinameKind.CONSTANT_QName: 			return abcFile.elementFactory(CQName) as CQName;
				case MultinameKind.CONSTANT_QNameA: 		return abcFile.elementFactory(CQNameA) as CQNameA;
				case MultinameKind.CONSTANT_RTQName: 		return abcFile.elementFactory(CRTQName) as CRTQName;
				case MultinameKind.CONSTANT_RTQNameA: 		return abcFile.elementFactory(CRTQNameA) as CRTQNameA;
				case MultinameKind.CONSTANT_RTQNameL: 		return abcFile.elementFactory(CRTQNameL) as CRTQNameL;
				case MultinameKind.CONSTANT_RTQNameLA: 		return abcFile.elementFactory(CRTQNameLA) as CRTQNameLA;
				case MultinameKind.CONSTANT_GenericName: 	return abcFile.elementFactory(CGenericName) as CGenericName;
				default:
					throw new Error("wrong Multiname kind:" + kind);
			}
		}
	}
}