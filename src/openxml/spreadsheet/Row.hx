package openxml.spreadsheet;

import openxml.spreadsheet.Cell;
import openxml.util.IXml;

using openxml.util.XmlTools;

/**
 * ...
 * @author Kevin
 */
class Row implements IXml
{
	public var row:Int;
	
	var cells:Array<Cell>;

	public function new(row:Int) 
	{
		this.row = row;
		cells = [];
	}
	
	public function addCell(cell:Cell)
	{
		if(cells.indexOf(cell) == -1)
			cells.push(cell);
	}
	
	public function toXml():Xml 
	{
		var xr = Xml.createElement('row');
		xr.set('r', Std.string(row + 1));
		
		cells.sort(function(c1, c2) return c1.col - c2.col);
		for (cell in cells)
			xr.addChild(cell.toXml());
		
		return xr;
	}
}