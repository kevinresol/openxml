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
	
	var sheets:Xml;
	
	public function new() 
	{
		super();
		header = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>';
		worksheets = [];
		
		var workbook = xml.addNewElement('workbook');
		workbook.set('xmlns', Constants.SPREADSHEET_ML);
		workbook.set('xmlns:r', Constants.RELATION_SCHEMA);
		
		sheets = workbook.addNewElement('sheets');
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