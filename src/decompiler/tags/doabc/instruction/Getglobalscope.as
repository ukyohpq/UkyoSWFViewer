package decompiler.tags.doabc.instruction
{
	public class Getglobalscope extends AbstractInstruction
	{
		public function Getglobalscope()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 100;
		}
		
		override public function getName():String
		{
			return "getglobalscope";
		}
		
		override public function deltaNumStack():int
		{
			return 1;
		}
	}
}