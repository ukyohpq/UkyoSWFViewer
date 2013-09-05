package decompiler.tags.doabc.instruction.jump
{
	/**
	 * Format
		jump
		offset
	 * 	offset is an s24 that is the number of bytes to jump. Jump the number of bytes indicated by
		offset and resume execution there.
	 * @author ukyohpq
	 * 
	 */
	public class Jump extends JumpSet
	{
		public function Jump()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 16;
		}
		
		override public function getName():String
		{
			return "jump";
		}
		
//		override public function toString():String
//		{
//			// TODO Auto Generated method stub
//			return "[ jump offset:" + offset + " ]";
//		}
		
	}
}