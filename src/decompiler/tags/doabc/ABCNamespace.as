package decompiler.tags.doabc
{
	public final class ABCNamespace
	{
		public var kind:int;
		public var name:int;
		public function ABCNamespace(kind:int, name:int)
		{
			this.kind = kind;
			this.name = name;
		}
		
		public function toString():String
		{
			return "kind:" + kind + " name:" + name;
		}
	}
}