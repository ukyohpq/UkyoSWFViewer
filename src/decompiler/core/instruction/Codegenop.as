package decompiler.core.instruction
{
	public class Codegenop extends AbstractInstruction
	{
		public function Codegenop()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 253;
		}
		
		override public function getName():String
		{
			return "codegenop";
		}
		
		
	}
}