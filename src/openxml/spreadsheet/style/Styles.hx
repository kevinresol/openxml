package openxml.spreadsheet.style;

import openxml.spreadsheet.style.Border.Borders;
import openxml.spreadsheet.style.Fill.Fills;
import openxml.spreadsheet.style.Font.Fonts;
import openxml.spreadsheet.style.Format.CellFormats;
import openxml.spreadsheet.style.Format.FormattingRecords;
import openxml.spreadsheet.style.NumberFormat.NumberFormats;
import openxml.util.IXml;
using openxml.util.XmlTools;
/**
 * ...
 * @author ...
 */
@:allow(openxml.spreadsheet)
class Styles implements IXml
{
	public var fonts:Fonts;
	public var fills:Fills;
	public var borders:Borders;
	public var numberFormats:NumberFormats;
	
	var formattingRecords:FormattingRecords;
	var cellFormats:CellFormats;
	
	public function new() 
	{
		fonts = new Fonts();
		fills = new Fills();
		borders = new Borders();
		numberFormats = new NumberFormats();
		
		formattingRecords = new FormattingRecords(this);
		cellFormats = new CellFormats(this);
	}
	
	public function toXml():Xml 
	{
		var xml = Xml.createDocument();
		
		var xss = xml.addElement('styleSheet');
		xss.set('xmlns', XmlNameSpaces.spreadsheetml.MAIN);
		
		xss.addChild(fonts.toXml());
		xss.addChild(fills.toXml());
		xss.addChild(borders.toXml());
		//xss.addChild(numberFormats.toXml());
		xss.addChild(formattingRecords.toXml());
		xss.addChild(cellFormats.toXml());
			
		return xml;
		
	}
}

/*class Style implements IXml
{
	var styleTypes:Array<StyleType>;
	
	public function new()
	{
		styleTypes = [];
	}
	
	public function toXml():Xml
	{
		
	}
}*/

