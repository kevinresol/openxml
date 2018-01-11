package openxml.spreadsheet.style;

import xml.*;
import openxml.spreadsheet.style.Border.Borders;
import openxml.spreadsheet.style.Fill.Fills;
import openxml.spreadsheet.style.Font.Fonts;
import openxml.spreadsheet.style.Format.CellFormats;
import openxml.spreadsheet.style.Format.FormattingRecords;
import openxml.spreadsheet.style.NumberFormat.NumberFormats;
import openxml.util.IXml;
/**
 * ...
 * @author ...
 */
@:allow(openxml.spreadsheet)
class Styles implements IXml {
	public var fonts:Fonts;
	public var fills:Fills;
	public var borders:Borders;
	public var numberFormats:NumberFormats;
	
	var formattingRecords:FormattingRecords;
	var cellFormats:CellFormats;
	
	public function new() {
		fonts = new Fonts();
		fills = new Fills();
		borders = new Borders();
		numberFormats = new NumberFormats();
		
		formattingRecords = new FormattingRecords(this);
		cellFormats = new CellFormats(this);
	}
	
	public function toXml():Xml {
		var doc = new Document(
			new ProcessingInstruction('xml version="1.0" encoding="UTF-8" standalone="yes"'),
			new Element('styleSheet')
				.setAttribute('xmlns', XmlNameSpaces.spreadsheetml.MAIN)
				.add(fonts.toXml())
				.add(fills.toXml())
				.add(borders.toXml())
				//.add(numberFormats.toXml())
				.add(formattingRecords.toXml())
				.add(cellFormats.toXml())
		);
		return doc.toXml();
		
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

