package decompiler.tags.doabc.cpools.multinames
{

	public class CRTQNameLA extends SWFMultiname
	{
		public function CRTQNameLA()
		{
			super(MultinameKind.CONSTANT_RTQNameLA);
		}
		
		override public function needNumParams():int
		{
			return 2;
		}
	}
}