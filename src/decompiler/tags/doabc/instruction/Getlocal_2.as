package decompiler.tags.doabc.instruction
{
	public class Getlocal_2 extends AbstractInstruction
	{
		public function Getlocal_2()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 210;
		}
		
		override public function getName():String
		{
			return "getlocal_2";
		}
		
		override public function deltaNumStack():int
		{
			return 1;
		}
	}
}