package openxml.spreadsheet;

import openxml.spreadsheet.Cell;
import openxml.util.XmlObject;

using openxml.util.XmlTools;

/**
 * ...
 * @author Kevin
 */
class Row extends XmlObject
{
	public var rowIndex:Int;
	
	var cells:Array<Cell>;

	public function new(rowIndex:Int) 
	{
		super();
		
		this.rowIndex = rowIndex;
		cells = [];
	}
	
	public function addCell(cell:Cell)
	{
		if(cells.indexOf(cell) == -1)
			cells.push(cell);
	}
	
	override public function toXml():Xml 
	{
		var xr = Xml.createElement('row');
		xr.set('r', Std.string(rowIndex));
		
		for (cell in cells)
		{
			var xc = xr.addNewElement('c');
			
		}
		
		
		
		return xr;
	}
	
	
	
}