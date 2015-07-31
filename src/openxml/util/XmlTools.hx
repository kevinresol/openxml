package openxml.util;
import format.zip.Data.Entry;
import format.zip.Tools;
import haxe.crypto.Crc32;
import haxe.io.Bytes;
using haxe.xml.Printer;
using openxml.util.XmlTools;

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
	
	public static function toEntry(object:IXml, fileName:String):Entry
	{
		var xmlString = object.toXml().print(false);
		var data = Bytes.ofString(xmlString);
		var e = {
			fileName: fileName,
			fileSize: data.length,
			data: data,
			fileTime: Date.now(),
			compressed: false,
			dataSize: data.length,
			crc32: Crc32.make(data),
		}
		Tools.compress(e, 9);
		return e;
	}
	
}