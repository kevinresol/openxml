package openxml.util;

/**
 * ...
 * @author Kevin
 */
class XmlTools
{

	public static function addNewElement(xml:Xml, name:String, ?text:String):Xml 
	{
		var e = Xml.createElement(name);
		xml.addChild(e);
		if (text != null && text != "") setInnerText(e, text);
		return e;
	}
	
	public static inline function firstElementNamed(xml:Xml, name:String):Xml
	{
		return xml.elementsNamed('name').next();
	}
	
	public static inline function setInnerText(xml:Xml, text:String):Void
	{
		xml.addChild(Xml.createPCData(text));
	}
	
}