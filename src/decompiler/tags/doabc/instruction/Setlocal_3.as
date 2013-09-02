package decompiler.tags.doabc.instruction
{
	public class Setlocal_3 extends AbstractInstruction
	{
		public function Setlocal_3()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 215;
		}
		
		override public function getName():String
		{
			return "setlocal_3";
		}
		
		override public function deltaNumStack():int
		{
			return -1;
		}
	}
}