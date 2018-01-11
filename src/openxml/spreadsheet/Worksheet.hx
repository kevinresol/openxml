package openxml.spreadsheet;

import xml.*;
import openxml.spreadsheet.Cell.A1Reference;
import openxml.util.IXml;
import openxml.XmlNameSpaces;


/**
 * ...
 * @author Kevin
 */
class Worksheet implements IXml {
	public var parent(default, null):Workbook;
	public var name:String;
	public var id:Int;
	
	var cells:Map<A1Reference, Cell>;
	
	public function new(workbook:Workbook, name:String) {
		parent = workbook;
		this.name = name;
		cells = new Map();
	}
	
	public function toXml():Xml {
		var doc = new Document(
			new ProcessingInstruction('xml version="1.0" encoding="UTF-8" standalone="yes"'),
			new Element('worksheet')
				.setAttribute('xmlns', XmlNameSpaces.spreadsheetml.MAIN)
				.setAttribute('xmlns:r', XmlNameSpaces.officeDocument.RELATIONSHIPS)
		);
		var minRow = 1000000;
		var maxRow = 0;
		var minCol = 65536;
		var maxCol = 0;
		
		var rows:Array<Row> = [];
		
		for (cell in cells) {
			var row = rows.filter(function(r) return r.row == cell.row)[0];
			if (row == null) 
				rows.push(row = new Row(cell.row));
			
			if (cell.row < minRow) minRow = cell.row;
			if (cell.col < minCol) minCol = cell.col;
			if (cell.row > maxRow) maxRow = cell.row;
			if (cell.col > maxCol) maxCol = cell.col;
			
			row.addCell(cell);
		}
		
		doc.root.add(
			new Element('dimension')
				.setAttribute('ref', A1Reference.createRange(minRow, minCol, maxRow, maxCol))
		);
		
		var sheetData = new Element('sheetData');
		doc.root.add(sheetData);
		
		rows.sort(function(r1, r2) return r1.row - r2.row);
		for (row in rows) sheetData.add(row.toXml());
		
		return doc.toXml();
	}
	
	public function getCell(row:Int, col:Int):Cell {
		var a1ref = A1Reference.create(row, col);
		if (!cells.exists(a1ref))
			cells[a1ref] = new Cell(this, row, col);
		
		return cells[a1ref];
	}
}