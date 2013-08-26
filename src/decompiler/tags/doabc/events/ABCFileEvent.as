package decompiler.tags.doabc.events
{
	import flash.events.Event;
	
	public class ABCFileEvent extends Event
	{
		public static const PARSE_COMPLETE:String = "parseComplete";
		public function ABCFileEvent(type:String)
		{
			super(type);
		}
	}
}