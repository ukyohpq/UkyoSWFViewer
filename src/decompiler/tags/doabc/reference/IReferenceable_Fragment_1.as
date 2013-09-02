if(refreshReference)
{
	this[name] = value;
}else{
	this["_" + name] = value;
}