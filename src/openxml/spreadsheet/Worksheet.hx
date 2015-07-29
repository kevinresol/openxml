package openxml.spreadsheet;
import openxml.spreadsheet.Cell.A1Reference;
import openxml.util.XmlObject;

using openxml.util.XmlTools;
/**
 * ...
 * @author Kevin
 */
class Worksheet extends XmlObject
{
	public var name:String;
	public var id:Int;
	
	var cells:Map<A1Reference, Cell>;
	
	public function new(name:String) 
	{
		super();
		
		this.name = name;
		cells = new Map();
	}
	
	override public function toXml():Xml 
	{
		var xml = Xml.createDocument();
		xml.addProcessingInstruction('xml version="1.0" encoding="UTF-8" standalone="yes"');
		
		var worksheet = xml.addNewElement('worksheet');
		worksheet.set('xmlns', Constants.SPREADSHEET_ML);
		worksheet.set('xmlns:r', Constants.RELATION_SCHEMA);
		
		var dimension = worksheet.addNewElement('dimension');
		dimension.set('ref', 'A1');
		
		var sheetData = worksheet.addNewElement('sheetData');
		
		var rows = new Map<Int, Row>();
		for (cell in cells)
		{
			if (!rows.exists(cell.row))
			{
				rows[cell.row] = new Row(cell.row);
			}
			
			var row = rows[cell.row];
			row.addCell(cell);
		}
		
		for (row in rows) sheetData.addChild(row.toXml());
		
		return xml;
	}
	
	public function getCell(row:Int, col:Int):Cell
	{
		var cell = new Cell(row, col);
		return cell;
	}
}