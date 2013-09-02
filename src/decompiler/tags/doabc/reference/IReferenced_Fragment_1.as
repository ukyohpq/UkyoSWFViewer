import decompiler.tags.doabc.events.ABCFileEvent;

import flash.events.Event;
import flash.utils.getQualifiedClassName;

try{
	creatRefrenceRelationship();
}catch(err:Error)
{
	trace("引用建立出错，遇到了调整后的引用关系，通常这里可能被加入扰码. " + getQualifiedClassName(this));
	$abcFile.addEventListener(ABCFileEvent.PARSE_COMPLETE,onParseComplete);
}

function onParseComplete(event:Event):void
{
	$abcFile.removeEventListener(ABCFileEvent.PARSE_COMPLETE,onParseComplete);
	creatRefrenceRelationship();
}