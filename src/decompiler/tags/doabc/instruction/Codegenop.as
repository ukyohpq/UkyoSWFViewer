package decompiler.tags.doabc.instruction
{
	public class Codegenop extends AbstractInstruction
	{
		public function Codegenop()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 253;
		}
		
		override public function getName():String
		{
			return "codegenop";
		}
		
		
	}
}