package openxml.spreadsheet.style;

import xml.*;
import openxml.util.XmlArray;

/**
 * ...
 * @author ...
 */
class Borders extends XmlArray<Border> {
	
	public function new() {
		super('borders');
		
		addBorder();
	}
	
	public function addBorder():Border {
		var border = new Border();
		push(border);
		return border;
	}
}

class Border implements IXmlArrayItem {
	public var id:Int;
	
	public function new() {}
	
	public function toXml():Xml {
		return new Element('border')
			.add(new Element('left'))
			.add(new Element('right'))
			.add(new Element('top'))
			.add(new Element('bottom'))
			.add(new Element('diagonal'));
	}
}