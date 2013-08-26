package decompiler.tags.doabc.instruction
{
	/**
	 * Format
		typeof
	 * Pop a value off of the stack. Determine its type name according to the type of value:
		1. undefined = "undefined"
		2. null = "object"
		3. Boolean = "Boolean"
		4. Number | int | uint = "number"
		5. String = "string"
		6. Function = "function"
		7. XML | XMLList = "xml"
		8. Object = "object"
		Push typename onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Typeof extends AbstractInstruction
	{
		public function Typeof()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 149;
		}
		
		override public function getName():String
		{
			return "typeof";
		}
		
		
	}
}