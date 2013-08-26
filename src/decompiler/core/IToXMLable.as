package decompiler.core
{
	import decompiler.utils.SWFXML;

	public interface IToXMLable
	{
		function toXML(name:String = null):SWFXML;
	}
}