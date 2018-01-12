package openxml.util;
import archive.Entry;
using haxe.xml.Printer;
using openxml.util.XmlTools;

using tink.CoreApi;

/**
 * ...
 * @author Kevin
 */
class XmlTools
{

	public static function addElement(xml:Xml, name:String, ?text:String, ?attr:Dynamic):Xml 
	{
		var e = Xml.createElement(name);
		xml.addChild(e);
		
		if (text != null && text != "") 
			e.setInnerText(text);
		
		if (attr != null)
		{
			for (a in Reflect.fields(attr))
				xml.setAttr(a, Reflect.field(attr, a));
		}
		
		return e;
	}
	
	public static function addProcessingInstruction(xml:Xml, data:String):Xml
	{
		var pi = Xml.createProcessingInstruction(data);
		xml.addChild(pi);
		return pi;
	}
	
	public static inline function firstElementNamed(xml:Xml, name:String):Xml
	{
		return xml.elementsNamed('name').next();
	}
	
	public static inline function setInnerText(xml:Xml, text:String):Void
	{
		xml.addChild(Xml.createPCData(text));
	}
	
	public static inline function setAttr(xml:Xml, name:String, value:Dynamic):Void
	{
		xml.set(name, Std.string(value));
	}
	
	public static function toEntry(obj:IXml, path:String):Entry<Noise> {
		var xml = obj.toXml().toString();
		return {
			name: path,
			size: xml.length,
			source: xml
		}
	}
	
}