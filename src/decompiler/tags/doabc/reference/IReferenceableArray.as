package decompiler.tags.doabc.reference
{
	public interface IReferenceableArray extends IReferenceable
	{
		function setValueAt(value:uint, index:uint = -1, refreshReference:Boolean = true):void;
	}
}