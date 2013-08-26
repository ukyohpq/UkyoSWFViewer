package decompiler.tags.doabc.instruction
{
	public class Alloc extends AbstractInstruction
	{
		public function Alloc()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 246;
		}
		
		override public function getName():String
		{
			return "alloc";
		}
		
		
	}
}