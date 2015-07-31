package openxml.spreadsheet;
import openxml.util.IXml;

using openxml.util.XmlTools;
/**
 * ...
 * @author Kevin
 */
class Workbook implements IXml
{
	public var worksheets:Array<Worksheet>;
	public var relationships:Relationships;
	
	public function new() 
	{
		worksheets = [];
		relationships = new Relationships();
	}
	
	public function addWorksheet(name:String):Worksheet
	{
		var ws = new Worksheet(name);
		worksheets.push(ws);
		ws.id = worksheets.length;
		relationships.add(ws, RTWorksheet, 'worksheets/sheet${ws.id}.xml');
		return ws;
	}
	
	public function getWorksheet(name:String):Worksheet
	{
		for (ws in worksheets) if (ws.name == name) return ws;
		return null;
	}
	
	public function toXml()
	{
		var xml = Xml.createDocument();
		xml.addProcessingInstruction('xml version="1.0" encoding="UTF-8" standalone="yes"');
		
		var workbook = xml.addElement('workbook');
		workbook.set('xmlns', XmlNameSpaces.spreadsheetml.MAIN);
		workbook.set('xmlns:r', XmlNameSpaces.officeDocument.RELATIONSHIPS);
		
		var sheets = workbook.addElement('sheets');
		
		for (i in 0...worksheets.length)
		{
			var ws = worksheets[i];
			var id = i + 1;
			var sheet = sheets.addElement('sheet');
			sheet.set('name', ws.name);
			sheet.set('sheetId', '$id');
			sheet.set('r:id', 'rId$id');
		}
		
		return xml;
	}
}