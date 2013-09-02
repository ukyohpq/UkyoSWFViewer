package decompiler.tags.doabc.instruction
{
	public class Getlocal_1 extends AbstractInstruction
	{
		public function Getlocal_1()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 209;
		}
		
		override public function getName():String
		{
			return "getlocal_1";
		}
		
		override public function deltaNumStack():int
		{
			return 1;
		}
	}
}