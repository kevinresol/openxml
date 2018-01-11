package openxml.spreadsheet;

import xml.*;
import openxml.spreadsheet.Cell;
import openxml.util.IXml;

/**
 * ...
 * @author Kevin
 */
class Row implements IXml {
	public var row:Int;
	
	var cells:Array<Cell>;

	public function new(row:Int) {
		this.row = row;
		cells = [];
	}
	
	public function addCell(cell:Cell) {
		if(cells.indexOf(cell) == -1)
			cells.push(cell);
	}
	
	public function toXml():Xml {
		var xr = new Element('row')
			.setAttribute('r', row + 1);
		
		cells.sort(function(c1, c2) return c1.col - c2.col);
		for (cell in cells) {
			var xc = cell.toXml();
			if (xc != null) xr.add(xc);
		}
		
		return xr;
	}
}