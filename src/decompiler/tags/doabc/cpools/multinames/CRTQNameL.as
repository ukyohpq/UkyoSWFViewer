package decompiler.tags.doabc.cpools.multinames
{
	import flash.utils.ByteArray;
	

	/**
	 * multiname_kind_RTQNameL
					{
					}
	 * @author ukyohpq
	 * 
	 */
	public class CRTQNameL extends SWFMultiname
	{
		public function CRTQNameL()
		{
			super(MultinameKind.CONSTANT_RTQNameL);
		}
		
		override public function needNumParams():int
		{
			return 2;
		}
	}
}