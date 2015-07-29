package openxml.spreadsheet;
import openxml.util.XmlObject;

using openxml.util.XmlTools;
/**
 * ...
 * @author Kevin
 */
class Worksheet extends XmlObject
{
	public var name:String = "Sheet";
	
	
	public function new() 
	{
		super();
		header = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>';
		
		var worksheet = xml.addNewElement('worksheet');
		worksheet.set('xmlns', Constants.SPREADSHEET_ML);
		worksheet.set('xmlns:r', Constants.RELATION_SCHEMA);
		
		var dimension = worksheet.addNewElement('dimension');
		dimension.set('ref', 'A1');
		
		var sheetData = worksheet.addNewElement('sheetData');
		
		
	}
}