package openxml.spreadsheet.style;
import openxml.util.XmlArray;
using openxml.util.XmlTools;
/**
 * ...
 * @author ...
 */
class Borders extends XmlArray<Border>
{
	
	public function new()
	{
		super('borders');
		
		addBorder();
	}
	
	public function addBorder():Border
	{
		var border = new Border();
		push(border);
		return border;
	}
	
	
}

class Border implements IXmlArrayItem
{
	public var id:Int;
	
	public function new()
	{
		
	}
	
	public function toXml():Xml
	{
		var xb = Xml.createElement('border');
		xb.addElement('left');
		xb.addElement('right');
		xb.addElement('top');
		xb.addElement('bottom');
		xb.addElement('diagonal');
		return xb;
	}
}