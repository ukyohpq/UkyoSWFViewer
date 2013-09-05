package decompiler.tags.doabc.instruction.jump
{
	/**
	 * 需要跳转的操作码
	 * @author ukyohpq
	 * 
	 */
	public interface IJump
	{
		/**
		 * 根据增量以及是在跳转之前插入还是在之后来修改跳转的偏移量
		 * @param deltaOffset	插入的pcode的字节长度
		 * @param isAfter	是在插入到原始跳转pcode前面还是后面
		 * @param bytesLengthBetweenCurrentIndexAndInsertIndex	插入处索引和当前索引之间的pcode的字节长度
		 */
		function modifyOffset(deltaOffset:int, isAfter:Boolean, bytesLengthBetweenCurrentIndexAndInsertIndex:uint):void;
	}
}