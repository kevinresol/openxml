package openxml.spreadsheet.style;
import haxe.CallStack;
import openxml.util.IXml;
import openxml.util.XmlArray;

using openxml.util.XmlTools;
/**
 * ...
 * @author ...
 */
class Formats extends XmlArray<Format>
{
	var parent:Styles;
	
	public function new(parent:Styles, elementName:String)
	{
		super(elementName);
		this.parent = parent;
	}
	
	public function addFormat():Format
	{
		var format = new Format();
		push(format);
		return format;
	}
}

class FormattingRecords extends Formats
{
	public var defaultFormat(default, null):Format;
	
	public function new(styles:Styles)
	{
		super(styles, 'cellStyleXfs');
		
		defaultFormat = new Format();
		push(defaultFormat);
	}
}

class CellFormats extends Formats
{
	public var defaultCellFormat(default, null):CellFormat;
	
	public function new(styles:Styles)
	{
		super(styles, 'cellXfs');
		defaultCellFormat = cast addFormat();
	}
	
	override public function addFormat():Format
	{
		var format = new CellFormat();
		format.format = parent.formattingRecords.defaultFormat;
		push(format);
		return format;
	}
}

class Format implements IXml implements IXmlArrayItem
{
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
	
	public function new()
	{
		
	}
	
	public function toXml():Xml 
	{
		var xxf = Xml.createElement('xf');
		
		xxf.setAttr('borderId', border == null ? 0 : border.id);
		xxf.setAttr('fillId', fill == null ? 0 : fill.id);
		xxf.setAttr('fontId', font == null ? 0 : font.id);
		xxf.setAttr('numFmtId', numberFormat == null ? 0 : numberFormat.id);
		
		return xxf;
	}
} 

class CellFormat extends Format
{
	public var format:Format;
	
	override public function toXml():Xml 
	{
		var xml = super.toXml();
		if(border != null) xml.setAttr('applyBorder', 1);
		if(fill != null) xml.setAttr('applyFill', 1);
		if(font != null) xml.setAttr('applyFont', 1);
		if(numberFormat != null) xml.setAttr('applyNumberFormat', 1);
		
		xml.setAttr('xfId', format.id);
		
		return xml;
	}
}