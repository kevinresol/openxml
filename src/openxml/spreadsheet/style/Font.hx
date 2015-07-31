package openxml.spreadsheet.style;
import openxml.util.IXml;
import openxml.util.XmlArray;

using openxml.util.XmlTools;
/**
 * ...
 * @author ...
 */
class Fonts extends XmlArray<Font>
{
	public var defaultFont(default, null):Font;
	
	public function new()
	{
		super('fonts');
		defaultFont = new Font();
		push(defaultFont);
	}
	
	public function addFont():Font
	{
		var font = new Font();
		push(font);
		return font;
	}
	
	
}

@:allow(openxml.spreadsheet)
class Font implements IXml implements IXmlArrayItem
{
	public var bold:Bool = false;
	public var size:Int = 12;
	public var family:Int = 0;
	public var name:String = "Arial";
	
	public var id:Int;
	
	function new()
	{
		
	}
	
	public function toXml():Xml
	{
		var xml = Xml.createElement('font');
		
		if (bold) xml.addElement('b');
		
		var xsize = xml.addElement('sz');
		xsize.setAttr('val', size);
		
		var xfamily = xml.addElement('family');
		xfamily.setAttr('val', family);
		
		var xname = xml.addElement('name');
		xname.setAttr('val', name);
		
		return xml;
	}
}

