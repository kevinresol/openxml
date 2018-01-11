package openxml.spreadsheet.style;

import xml.*;
import openxml.util.IXml;
import openxml.util.XmlArray;

/**
 * ...
 * @author ...
 */
class Fonts extends XmlArray<Font> {
	
	public function new() {
		super('fonts');
		addFont();
	}
	
	public function addFont():Font {
		var font = new Font();
		push(font);
		return font;
	}
	
	
}

@:allow(openxml.spreadsheet)
class Font implements IXml implements IXmlArrayItem {
	public var bold:Bool = false;
	public var italic:Bool = false;
	public var size:Int = 8;
	public var family:Int = 0;
	public var name:String = "Arial";
	
	public var id:Int;
	
	function new() {}
	
	public function toXml():Xml {
		var xml = new Element('font');
		
		if (bold) xml.add(new Element('b'));
		if (italic) xml.add(new Element('i'));
		
		xml
			.add(
				new Element('sz')
					.setAttribute('val', Std.string(size))
			)
			.add(
				new Element('family')
					.setAttribute('val', Std.string(family))
			);
		
		// xml.add(
		// 	new Element('name')
		// 		.setAttribute('val', name)
		// );
		
		return xml;
	}
}

