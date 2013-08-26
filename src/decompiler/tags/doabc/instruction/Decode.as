package decompiler.tags.doabc.instruction
{
	public class Decode extends AbstractInstruction
	{
		public function Decode()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 255;
		}
		
		override public function getName():String
		{
			return "decode";
		}
		
		
	}
}