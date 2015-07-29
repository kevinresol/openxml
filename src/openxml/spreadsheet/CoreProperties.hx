package openxml.spreadsheet;

import openxml.util.IXml;
using openxml.util.XmlTools;
/**
 * ...
 * @author Kevin
 */
class CoreProperties implements IXml
{

	public function new() 
	{
		
	}
	
	public function toXml():Xml 
	{
		var xml = Xml.createDocument();
		xml.addProcessingInstruction('xml version="1.0" encoding="UTF-8"');
		
		var cp = xml.addElement('cp:coreProperties');
		cp.set('xmlns:cp', "http://schemas.openxmlformats.org/package/2006/metadata/core-properties");
		cp.set('xmlns:dc', "http://purl.org/dc/elements/1.1/");
		cp.set('xmlns:dcmitype', "http://purl.org/dc/dcmitype/");
		cp.set('xmlns:dcterms', "http://purl.org/dc/terms/");
		cp.set('xmlns:xsi', "http://www.w3.org/2001/XMLSchema-instance");
		
		return xml;
	}
}