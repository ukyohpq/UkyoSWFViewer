package decompiler.tags.doabc.instruction
{
	public class Wb extends AbstractInstruction
	{
		public function Wb()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 248;
		}
		
		override public function getName():String
		{
			return "wb";
		}
		
		
	}
}