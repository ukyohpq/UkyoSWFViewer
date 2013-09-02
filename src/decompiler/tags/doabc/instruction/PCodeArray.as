package decompiler.tags.doabc.instruction
{
	import flash.utils.ByteArray;

	/**
	 * 暂时没用到的类
	 * @author ukyohpq
	 * 
	 */
	public final class PCodeArray
	{
		private var _list:Object;
		private var _position:int;

		public function get position():int
		{
			return _position;
		}

		public function set position(value:int):void
		{
			_position = value;
		}

		public function PCodeArray()
		{
		}
		
		public function setList(list:Object):void
		{
			if(
				(list is Array)
				|| (list is Vector.<Number>)
				|| (list is Vector.<int>)
				|| (list is Vector.<uint>)
			)
			{
				_list = list;
			}else{
				throw new Error("必须是数组或者是Number,int,uint类型的Vector数组.");
			}
		}
		
		public function readInt():int
		{
			return _list[ _position++ ];
		}
		
		public function get length():int
		{
			return _list.length;
		}
		
		public function get intAvailable():Boolean
		{
			return _position < _list.length;
		}
	}
}