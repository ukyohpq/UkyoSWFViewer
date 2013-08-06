package decompiler.core.instruction
{
	public class Urshift extends AbstractInstruction
	{
		public function Urshift()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 167;
		}
		
		override public function getName():String
		{
			return "urshift";
		}
		
		
	}
}