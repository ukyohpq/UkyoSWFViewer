package decompiler.tags.doabc.instruction.jump
{
	public interface IJumpSet extends IJump
	{
		function get offset():int;
		function set offset(value:int):void;
	}
}