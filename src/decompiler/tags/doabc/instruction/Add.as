package decompiler.tags.doabc.instruction
{
	/**
	 * Format
		add
	 * Pop value1 and value2 off of the stack and add them together as specified in ECMA-262 section 
	 * 11.6 and as extended in ECMA-357 section 11.4. The algorithm is briefly described below.
	 * 1. If value1 and value2 are both Numbers, then set value3 to the result of adding the two number values. 
	 * See ECMA-262 section 11.6.3 for a description of adding number values. 
	 * 
	 * 2. If value1 or value2 is a String or a Date, 
	 * convert both values to String using the ToString algorithm described in ECMA-262 section 9.8. 
	 * Concatenate the string value of value2 to the string value of value1 and set value3 to the new concatenated String. 
	 * 
	 * 3. If value1 and value2 are both of type XML or XMLList, construct a new XMLList object,
	 * then call [[Append]](value1), and then [[Append]](value2). Set value3 to the new XMLList.
	 * See ECMA-357 section 9.2.1.6 for a description of the [[Append]] method.
	 * 
	 * 4. If none of the above apply, convert value1 and value2 to primitives. 
	 * This is done by calling ToPrimitive with no hint. This results in value1_primitive and value2_primitive. 
	 * If value1_primitive or value2_primitive is a String then 
	 * convert both to Strings using the ToString algorithm (ECMA-262 section 9.8), 
	 * concatenate the results, and set value3 to the concatenated String. 
	 * Otherwise convert both to Numbers using the ToNumber algorithm 
	 * (ECMA-262 section 9.3), add the results, and set value3 to the result of the addition. 
	 * 
	 * Push value3 onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Add extends AbstractInstruction
	{
		public function Add()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 160;
		}
		
		override public function getName():String
		{
			return "add";
		}
		
		override public function deltaNumStack():int
		{
			return -1;
		}
	}
}