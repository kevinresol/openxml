package openxml;
import openxml.util.IXml;

using openxml.util.XmlTools;
/**
 * ...
 * @author Kevin
 */
class ContentTypes implements IXml
{
	var overrides:Array<{partName:String, contentType:ContentType}>;
	public function new()
	{
		overrides = [];
	}
	
	public function addPart(partName:String, contentType:ContentType)
	{
		overrides.push({partName:partName, contentType:contentType});
	}
	
	public function toXml():Xml 
	{
		var xml = Xml.createDocument();
		xml.addProcessingInstruction('xml version="1.0" encoding="UTF-8" standalone="yes"');
		
		var types = xml.addElement('Types');
		types.set('xmlns', "http://schemas.openxmlformats.org/package/2006/content-types"); 
		types.set('xmlns:xsd', "http://www.w3.org/2001/XMLSchema");
		types.set('xmlns:xsi', "http://www.w3.org/2001/XMLSchema-instance");
		
		var d = types.addElement('Default');
		d.set('Extension', 'rels');
		d.set('ContentType', CTRelationships);
		
		var d = types.addElement('Default');
		d.set('Extension', 'xml');
		d.set('ContentType', CTXml);
		
		for (o in overrides)
		{
			var xo = types.addElement('Override');
			xo.set('PartName', o.partName);
			xo.set('ContentType', o.contentType);
		}
		
		return xml;
	}
}

@:enum 
abstract ContentType(String) to String
{
	var CTXml = "application/xml";
	
	var CTRelationships = "application/vnd.openxmlformats-package.relationships+xml";
	var CTCoreProperties = "application/vnd.openxmlformats-package.core-properties+xml";
	
	var CTExtendedProperties = "application/vnd.openxmlformats-officedocument.extended-properties+xml";
	var CTTheme = "application/vnd.openxmlformats-officedocument.theme+xml";
	
	var CTWorkbook = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet.main+xml";
	var CTWorksheet = "application/vnd.openxmlformats-officedocument.spreadsheetml.worksheet+xml";
	var CTSharedStrings = "application/vnd.openxmlformats-officedocument.spreadsheetml.sharedStrings+xml";
	var CTStyles = "application/vnd.openxmlformats-officedocument.spreadsheetml.styles+xml";
}

