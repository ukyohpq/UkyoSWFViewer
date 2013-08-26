package decompiler.core
{
	import flash.utils.ByteArray;

	/**
	 * 基本接口，所有swf里面的元素，例如swf头，swftag，swfRect等
	 * 都可以编码成byteArray，都要实现这个接口
	 * @author ukyohpq
	 * 
	 */
	public interface ISWFElement extends IToXMLable
	{
		function encode():ByteArray;
	}
}