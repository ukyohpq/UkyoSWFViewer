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
		/**
		 * 设置属性值
		 * 这个接口将废弃
		 * @param name	要设置的属性名
		 * @param value	要设置的值
		 * @param refreshReference	是否调整引用
		 * 
		 */
		function setProperty(name:String, value:Object, refreshReference:Boolean = true):void;
	}
}