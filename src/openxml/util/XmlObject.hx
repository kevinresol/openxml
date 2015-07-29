package openxml.util;

/**
 * ...
 * @author Kevin
 */
class XmlObject implements IXml
{
	var header:String;
	var xml:Xml;
	
	public function new() 
	{
		xml = Xml.createDocument();
	}
	
	public function toXmlString():String 
	{
		return header + xml.toString();
	}
	
}