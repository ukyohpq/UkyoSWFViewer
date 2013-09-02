package decompiler.tags.doabc.reference
{
	/**
	 * 可以引用别的元素
	 * @author ukyohpq
	 * 
	 */
	public interface IReferenceable
	{
		/**
		 * 建立引用关系。一般是在abc文件解析完成之后进行关系建立，否则可能出现建立关系时空对象的情况
		 * 
		 */
		function creatRefrenceRelationship():void;
		function setProperty(name:String, value:Object, refreshReference:Boolean = true):void;
	}
}