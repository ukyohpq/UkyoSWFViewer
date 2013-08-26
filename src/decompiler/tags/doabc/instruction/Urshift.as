package decompiler.tags.doabc.instruction
{
	public class Urshift extends AbstractInstruction
	{
		public function Urshift()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 167;
		}
		
		override public function getName():String
		{
			return "urshift";
		}
		
		
	}
}