package decompiler.tags.doabc.instruction
{
	public class Setlocal_2 extends AbstractInstruction
	{
		public function Setlocal_2()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 214;
		}
		
		override public function getName():String
		{
			return "setlocal_2";
		}
		
		
	}
}