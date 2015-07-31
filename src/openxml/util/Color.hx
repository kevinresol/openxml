package openxml.util;

using openxml.util.XmlTools;
/**
 * ...
 * @author ...
 */
class Color implements IXml
{
	public var auto:Null<Bool>;
	public var argb:Null<Int>;
	
	var elementName:String;

	public function new(elementName:String) 
	{
		this.elementName = elementName;
	}
	
	public function toXml():Xml
	{
		var xc = Xml.createElement(elementName);
		
		if (auto != null) xc.setAttr('auto', auto);
		if (argb != null) xc.setAttr('rgb', StringTools.hex(argb));
		
		return xc;
	}
	
}

enum ColorType
{
	
}