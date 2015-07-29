package openxml.util;

/**
 * ...
 * @author Kevin
 */
class XmlTools
{

	public static function addNewElement(xml:Xml, name:String):Xml 
	{
		var e = Xml.createElement(name);
		xml.addChild(e);
		return e;
	}
	
	public static inline function firstElementNamed(xml:Xml, name:String):Xml
	{
		return xml.elementsNamed('name').next();
	}
	
}