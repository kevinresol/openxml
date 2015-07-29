package openxml.spreadsheet;
import openxml.util.IXml;
import openxml.util.XmlObject;

using openxml.util.XmlTools;
/**
 * ...
 * @author Kevin
 */
class ContentTypes extends XmlObject
{
	var types:Xml;
	public function new()
	{
		super();
		header = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>';
		types = xml.addNewElement('Types');
		types.set('xmlns', "http://schemas.openxmlformats.org/package/2006/content-types"); 
		types.set('xmlns:xsd', "http://www.w3.org/2001/XMLSchema");
		types.set('xmlns:xsi', "http://www.w3.org/2001/XMLSchema-instance");
		
		var d = types.addNewElement('Default');
		d.set('Extension', 'rels');
		d.set('ContentType', CTRelationships);
		
		var d = types.addNewElement('Default');
		d.set('Extension', 'xml');
		d.set('ContentType', CTXml);
	}
	
	public function addPart(partName:String, contentType:ContentType)
	{
		var o = types.addNewElement('Override');
		o.set('PartName', partName);
		o.set('ContentType', contentType);
	}
}

@:enum 
abstract ContentType(String) to String
{
	var CTRelationships = "application/vnd.openxmlformats-package.relationships+xml";
	var CTXml = "application/xml";
	var CTWorkbook = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet.main+xml";
	var CTWorksheet = "application/vnd.openxmlformats-officedocument.spreadsheetml.worksheet+xml";
	var CTCoreProperties = "application/vnd.openxmlformats-package.core-properties+xml";
	var CTExtendedProperties = "application/vnd.openxmlformats-officedocument.extended-properties+xml";
	
	//<Override PartName="/xl/theme/theme1.xml" ContentType="application/vnd.openxmlformats-officedocument.theme+xml"/>
	//<Override PartName="/xl/styles.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.styles+xml"/>	
	//<Override PartName="/docProps/app.xml" ContentType="application/vnd.openxmlformats-officedocument.extended-properties+xml"/>
	//<Override PartName="/docProps/core.xml" ContentType="application/vnd.openxmlformats-package.core-properties+xml"/>
}