package decompiler.tags.doabc.cpools.multinames
{
	public final class MultinameKind
	{
		public static const CONSTANT_QName:int 			= 0x07;
		public static const CONSTANT_QNameA:int 		= 0x0D;
		public static const CONSTANT_RTQName:int 		= 0x0F;
		public static const CONSTANT_RTQNameA:int 		= 0x10;
		public static const CONSTANT_RTQNameL:int		= 0x11;
		public static const CONSTANT_RTQNameLA:int 		= 0x12;
		public static const CONSTANT_Multiname:int 		= 0x09;
		public static const CONSTANT_MultinameA:int 	= 0x0E;
		public static const CONSTANT_MultinameL:int 	= 0x1B;
		public static const CONSTANT_MultinameLA:int 	= 0x1C;
//		文档中无记载的MultinameKind:0x1D
//		vector相关
//		as3的类泛型
		public static const CONSTANT_GenericName:int 	= 0x1D;//貌似这个是更新的，但是文档中居然还没加进去
		
		public static function getNameByKind(kind:int):String
		{
			switch(kind)
			{
				case CONSTANT_QName:		return "CONSTANT_QName";
				case CONSTANT_QNameA:		return "CONSTANT_QNameA";
				case CONSTANT_RTQName:		return "CONSTANT_RTQName";
				case CONSTANT_RTQNameA:		return "CONSTANT_RTQNameA";
				case CONSTANT_RTQNameL:		return "CONSTANT_RTQNameL";
				case CONSTANT_RTQNameLA:	return "CONSTANT_RTQNameLA";
				case CONSTANT_Multiname:	return "CONSTANT_Multiname";
				case CONSTANT_MultinameA:	return "CONSTANT_MultinameA";
				case CONSTANT_MultinameL:	return "CONSTANT_MultinameL";
				case CONSTANT_MultinameLA:	return "CONSTANT_MultinameLA";
				case CONSTANT_GenericName:	return "CONSTANT_GenericName";
				default:					return "unkown MultiName Kind!";
			}
		}
	}
}