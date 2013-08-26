package decompiler.tags.doabc.instruction
{
	public class Prologue extends AbstractInstruction
	{
		public function Prologue()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 249;
		}
		
		override public function getName():String
		{
			return "prologue";
		}
		
		
	}
}