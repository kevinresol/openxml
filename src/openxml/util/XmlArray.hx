package openxml.util;

using openxml.util.XmlTools;
/**
 * ...
 * @author ...
 */
class XmlArray<T:IXmlArrayItem> implements IXml
{
	public var length(get, never):Int;
	
	var array:Array<T>;
	var elementName:String;
	
	public function new(elementName:String) 
	{
		array = [];
		this.elementName = elementName;
	}
	
	public function push(item:T):Int
	{
		var i = array.push(item);
		item.id = i - 1;
		return i;
	}
	
	public inline function pop():T
	{
		return array.pop();
	}
	
	public inline function remove(item:T):Bool
	{
		var r = array.remove(item);
		
		if (r)
			for (i in 0...array.length) 
				array[i].id = i;
			
		return r;
	}
	
	public inline function iterator() 
	{
		return array.iterator();
	}
	
	public function toXml():Xml
	{
		var xml = Xml.createElement(elementName);
		xml.set('count', Std.string(array.length));
		for (i in array)
			xml.addChild(i.toXml());
		return xml;
	}
	
	private inline function get_length():Int
	{
		return array.length;
	}
	
}

interface IXmlArrayItem extends IXml
{
	var id:Int;
}