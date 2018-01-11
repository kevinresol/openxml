package openxml.spreadsheet.style;

import xml.*;
import haxe.CallStack;
import openxml.util.IXml;
import openxml.util.XmlArray;

/**
 * ...
 * @author ...
 */
class Formats extends XmlArray<Format> {
	var parent:Styles;
	
	public function new(parent:Styles, elementName:String) {
		super(elementName);
		this.parent = parent;
	}
	
	public function addFormat():Format {
		var format = new Format();
		push(format);
		return format;
	}
}

class FormattingRecords extends Formats {
	public var defaultFormat(default, null):Format;
	
	public function new(styles:Styles) {
		super(styles, 'cellStyleXfs');
		
		defaultFormat = new Format();
		push(defaultFormat);
	}
}

class CellFormats extends Formats {
	public var defaultCellFormat(default, null):CellFormat;
	
	public function new(styles:Styles) {
		super(styles, 'cellXfs');
		defaultCellFormat = cast addFormat();
	}
	
	override public function addFormat():Format {
		var format = new CellFormat();
		format.format = parent.formattingRecords.defaultFormat;
		push(format);
		return format;
	}
}

class Format implements IXml implements IXmlArrayItem {
	public var applyAlignment:Bool;
	public var applyBorder:Bool;
	public var applyFill:Bool;
	public var applyFont:Bool;
	public var applyNumberFormat:Bool;
	public var applyProtection:Bool;
	
	public var font:Font;
	public var border:Border;
	public var fill:Fill;
	public var numberFormat:NumberFormat;
	
	public var pivotButton:Bool;
	public var quotePrefix:Bool;
	
	public var id:Int;
	
	public function new() {
		
	}
	
	public function toXml():Xml  {
		return new Element('xf')
			.setAttribute('borderId', border == null ? '0' : Std.string(border.id))
			.setAttribute('fillId', fill == null ? '0' : Std.string(fill.id))
			.setAttribute('fontId', font == null ? '0' : Std.string(font.id))
			.setAttribute('numFmtId', numberFormat == null ? '0' : Std.string(numberFormat.id));
	}
} 

class CellFormat extends Format {
	public var format:Format;
	
	override public function toXml():Xml  {
		var xml:Element = cast super.toXml();
		if(border != null) xml.setAttribute('applyBorder', '1');
		if(fill != null) xml.setAttribute('applyFill', '1');
		if(font != null) xml.setAttribute('applyFont', '1');
		if(numberFormat != null) xml.setAttribute('applyNumberFormat', '1');
		
		xml.setAttribute('xfId', Std.string(format.id));
		
		return xml;
	}
}