package decompiler.utils
{
	public final class BitUtil
	{
		/**
		 * 为一个整数的指定index的bit位上赋值，只能是0或1
		 * @param num		要赋值的数
		 * @param bitIndex	指定的bit位
		 * @param value		只能是0或者1
		 * @return 
		 * 
		 */
		public static function setNumBitValue(num:int, bitIndex:int, value:int):int
		{
			var mask:int = 1 << bitIndex;
			return value?(num | mask):((num | mask) ^ mask);//两种算法，先把这位放上1，然后抑或一下变成0
			return value?(num | mask):(num & ~mask);//先拿到一个反数，然后再与一下成0，都是两次位运算，应该一样
		}
	}
}