package decompiler.core.instruction
{
	public class Decode extends AbstractInstruction
	{
		public function Decode()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 255;
		}
		
		override public function getName():String
		{
			return "decode";
		}
		
		
	}
}