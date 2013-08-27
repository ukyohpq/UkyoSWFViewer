package decompiler.tags.doabc
{
	public interface IReferenceableArray extends IReferenceable
	{
		function setValueAt(value:uint, index:uint = -1):void;
	}
}