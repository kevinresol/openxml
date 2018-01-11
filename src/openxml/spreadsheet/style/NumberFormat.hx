package openxml.spreadsheet.style;

import xml.*;
import openxml.util.IXml;
import openxml.util.XmlArray;

/**
 * ...
 * @author ...
 */
class NumberFormats extends XmlArray<NumberFormat> {
	
	public function new() {
		super('numberFormats');
		addNumberFormat();
	}
	
	public function addNumberFormat():NumberFormat {
		var numberFormat = new NumberFormat();
		push(numberFormat);
		return numberFormat;
	}
}
 
class NumberFormat implements IXmlArrayItem {
	public var id:Int;
	public function new()  {
		
	}
	
	public function toXml():Xml {
		return new Element('numberFormat');
	}
	
}