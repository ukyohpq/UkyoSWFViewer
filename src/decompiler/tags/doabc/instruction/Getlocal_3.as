package decompiler.tags.doabc.instruction
{
	public class Getlocal_3 extends AbstractInstruction
	{
		public function Getlocal_3()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 211;
		}
		
		override public function getName():String
		{
			return "getlocal_3";
		}
		
		override public function deltaNumStack():int
		{
			return 1;
		}
	}
}