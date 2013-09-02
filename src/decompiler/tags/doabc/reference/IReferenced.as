package decompiler.tags.doabc.reference
{
	/**
	 * 在abc文件中可以被引用的，例如常量，方法等
	 * @author ukyohpq
	 * 
	 */
	public interface IReferenced
	{
		function addReference(element:IReferenceable, propertyName:String, param:int = 0):void;
		function removeReference(element:IReferenceable, propertyName:String, param:int = 0):void;
		function get references():Vector.<Reference>;
	}
}