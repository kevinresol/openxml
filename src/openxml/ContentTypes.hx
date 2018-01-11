package openxml;

import xml.*;
import openxml.util.IXml;

/**
 * ...
 * @author Kevin
 */
class ContentTypes extends Document implements IXml {
	
	public function new() {
		super(
			new ProcessingInstruction('xml version="1.0" encoding="UTF-8" standalone="yes"'),
			new Element('Types')
				.setAttribute('xmlns', XmlNameSpaces.pack.CONTENT_TYPES)
				.setAttribute('xmlns:xsd', "http://www.w3.org/2001/XMLSchema")
				.setAttribute('xmlns:xsi', "http://www.w3.org/2001/XMLSchema-instance")
				.add(
					new Element('Default')
						.setAttribute('Extension', 'rels')
						.setAttribute('ContentType', CTRelationships)
				)
				.add(
					new Element('Default')
						.setAttribute('Extension', 'xml')
						.setAttribute('ContentType', CTXml)
				)
		);
	}
	
	public function addPart(partName:String, contentType:ContentType) {
		root.add(
			new Element('Override')
				.setAttribute('PartName', partName)
				.setAttribute('ContentType', contentType)
		);
	}
}

@:enum 
abstract ContentType(String) to String
{
	var CTXml 					= "application/xml";
	
	var CTRelationships 		= "application/vnd.openxmlformats-package.relationships+xml";
	var CTCoreProperties 		= "application/vnd.openxmlformats-package.core-properties+xml";
	
	var CTExtendedProperties 	= "application/vnd.openxmlformats-officedocument.extended-properties+xml";
	var CTTheme 				= "application/vnd.openxmlformats-officedocument.theme+xml";
	
	var CTWorkbook 				= "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet.main+xml";
	var CTWorksheet 			= "application/vnd.openxmlformats-officedocument.spreadsheetml.worksheet+xml";
	var CTSharedStrings			= "application/vnd.openxmlformats-officedocument.spreadsheetml.sharedStrings+xml";
	var CTStyles 				= "application/vnd.openxmlformats-officedocument.spreadsheetml.styles+xml";
	
	var CTDocument				= "application/vnd.openxmlformats-officedocument.wordprocessingml.document.main+xml";
	
}

