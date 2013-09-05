package decompiler.tags.doabc.instruction
{
	/**
	 * Undocumented
	 * TypeError: Error #1034: 强制转换类型失败:无法将 true 转换为 Class。
	 * D0 30 24 0A 81 76 F2 29 47 
	 * 没找到，貌似会执行一下转型
	 * @author ukyohpq
	 * 
	 */
	public class Bkptline extends UndocumentedInstruction
	{
		public function Bkptline()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 242;
		}
		
		override public function getName():String
		{
			return "bkptline";
		}
		
	}
}