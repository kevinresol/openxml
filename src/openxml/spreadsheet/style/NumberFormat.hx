package openxml.spreadsheet.style;
import openxml.util.IXml;
import openxml.util.XmlArray;
using openxml.util.XmlTools;

/**
 * ...
 * @author ...
 */
class NumberFormats extends XmlArray<NumberFormat>
{
	
	public function new()
	{
		super('numberFormats');
		addNumberFormat();
	}
	
	public function addNumberFormat():NumberFormat
	{
		var numberFormat = new NumberFormat();
		push(numberFormat);
		return numberFormat;
	}
	
	
}
 
class NumberFormat implements IXmlArrayItem
{
	public var id:Int;
	public function new() 
	{
		
	}
	
	public function toXml():Xml
	{
		var xf = Xml.createElement('numberFormat');
		return xf;
	}
	
}