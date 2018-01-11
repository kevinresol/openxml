package openxml;

import xml.*;
import openxml.util.IXml;

/**
 * ...
 * @author Kevin
 */
class Relationships extends Document implements IXml {
	var counter = 0;
	
	public function add(type:RelationshipType, target:String) {
		root.add(
			new Element('Relationship')
				.setAttribute('Id', 'rId${counter++}')
				.setAttribute('Type', type)
				.setAttribute('Target', target)
		);
	}
	
	public function new() {
		super(
			new ProcessingInstruction('xml version="1.0" encoding="UTF-8"'),
			new Element('Relationships')
				.setAttribute('xmlns', XmlNameSpaces.pack.RELATIONSHIPS)
		);
	}
}

@:enum
abstract RelationshipType(String) to String
{
	// common
	var RTCoreProperties 		= "http://schemas.openxmlformats.org/package/2006/relationships/metadata/core-properties";
	
	var RTExtendedProperties 	= "http://schemas.openxmlformats.org/officeDocument/2006/relationships/extended-properties";
	var RTOfficeDocument 		= "http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument";
	
	// spreadsheet
	var RTWorksheet 			= "http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet";
	var RTSharedStrings 		= "http://schemas.openxmlformats.org/officeDocument/2006/relationships/sharedStrings";
	var RTStyles				= "http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles";
	
	// wordprocessing
	
}

typedef Relationship =
{
	object:IXml,
	type:RelationshipType,
	target:String,
}