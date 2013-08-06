package decompiler.core.instruction
{
	public class Throw_ extends AbstractInstruction
	{
		public function Throw_()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 3;
		}
		
		override public function getName():String
		{
			return "throw";
		}
		
		
	}
}