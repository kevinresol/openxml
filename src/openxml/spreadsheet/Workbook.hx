package openxml.spreadsheet;
import openxml.util.XmlObject;

using openxml.util.XmlTools;
/**
 * ...
 * @author Kevin
 */
class Workbook extends XmlObject
{
	public var worksheets:Array<Worksheet>;
	public var relationships:Relationships;
	
	var sheets:Xml;
	
	public function new() 
	{
		super();
		header = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>';
		worksheets = [];
		relationships = new Relationships();
		
		var workbook = xml.addNewElement('workbook');
		workbook.set('xmlns', Constants.SPREADSHEET_ML);
		workbook.set('xmlns:r', Constants.RELATION_SCHEMA);
		
		sheets = workbook.addNewElement('sheets');
	}
	
	public function addWorksheet(name:String):Worksheet
	{
		var ws = new Worksheet(name);
		worksheets.push(ws);
		ws.id = worksheets.length;
		relationships.add(ws, RTWorksheet, 'worksheets/sheet${ws.id}.xml');
		return ws;
	}
	
	override public function toXmlString()
	{
		for (i in 0...worksheets.length)
		{
			var ws = worksheets[i];
			var id = i + 1;
			var sheet = sheets.addNewElement('sheet');
			sheet.set('name', ws.name);
			sheet.set('sheetId', '$id');
			sheet.set('r:id', 'rId$id');
		}
		return super.toXmlString();
	}
}