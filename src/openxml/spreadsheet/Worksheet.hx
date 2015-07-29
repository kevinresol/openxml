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
		
		var worksheet = xml.addElement('worksheet');
		worksheet.set('xmlns', Constants.SPREADSHEET_ML);
		worksheet.set('xmlns:r', Constants.RELATION_SCHEMA);
		
		
		
		var minRow = 1000000;
		var maxRow = 0;
		var minCol = 65536;
		var maxCol = 0;
		
		
		
		var rows:Array<Row> = [];
		
		for (cell in cells)
		{
			var row = rows.filter(function(r) return r.row == cell.row)[0];
			if (row == null) 
				rows.push(row = new Row(cell.row));
			
			if (cell.row < minRow) minRow = cell.row;
			if (cell.col < minCol) minCol = cell.col;
			if (cell.row > maxRow) maxRow = cell.row;
			if (cell.col > maxCol) maxCol = cell.col;
			
			row.addCell(cell);
		}
		
		var dimension = worksheet.addElement('dimension');
		dimension.set('ref', A1Reference.createRange(minRow, minCol, maxRow, maxCol));
		
		var sheetData = worksheet.addElement('sheetData');
		
		rows.sort(function(r1, r2) return r1.row - r2.row);
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