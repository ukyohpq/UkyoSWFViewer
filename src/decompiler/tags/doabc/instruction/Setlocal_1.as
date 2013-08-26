package decompiler.tags.doabc.instruction
{
	public class Setlocal_1 extends AbstractInstruction
	{
		public function Setlocal_1()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 213;
		}
		
		override public function getName():String
		{
			return "setlocal_1";
		}
		
		
	}
}