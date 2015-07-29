package openxml.spreadsheet;
import openxml.spreadsheet.Cell.A1Reference;
import openxml.util.IXml;

using openxml.util.XmlTools;
/**
 * ...
 * @author Kevin
 */
class Worksheet implements IXml
{
	public var name:String;
	public var id:Int;
	
	var cells:Map<A1Reference, Cell>;
	
	public function new(name:String) 
	{
		this.name = name;
		cells = new Map();
	}
	
	public function toXml():Xml 
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
				rows[cell.row] = new Row(cell.row);
			
			rows[cell.row].addCell(cell);
		}
		
		for (row in rows) 
			sheetData.addChild(row.toXml());
		
		return xml;
	}
	
	public function getCell(row:Int, col:Int):Cell
	{
		var a1ref = A1Reference.create(row, col);
		if (!cells.exists(a1ref))
			cells[a1ref] = new Cell(row, col);
		
		return cells[a1ref];
	}
}