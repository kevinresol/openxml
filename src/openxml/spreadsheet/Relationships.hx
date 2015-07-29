package openxml.spreadsheet;
import openxml.util.IXml;
import openxml.util.XmlObject;
using openxml.util.XmlTools;
/**
 * ...
 * @author Kevin
 */
class Relationships extends XmlObject
{
	var relationships:Xml;
	
	public function new() 
	{
		super();
		header = '<?xml version="1.0" encoding="UTF-8"?>';
		relationships = xml.addNewElement('Relationships');
		relationships.set('xmlns', 'http://schemas.openxmlformats.org/package/2006/relationships');
	}
	
	public function addRelationship(rId:String, relationshipType:RelationshipType, target:String)
	{
		var r = relationships.addNewElement('Relationship');
		r.set('Id', rId);
		r.set('Type', relationshipType);
		r.set('Target', target);
		//<Relationship Id="rId1" Type= Target="worksheets/sheet1.xml" />
	}
}

@:enum
abstract RelationshipType(String) to String
{
	var RTWorksheet = "http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet";
	var RTExtendedProperties = "http://schemas.openxmlformats.org/officeDocument/2006/relationships/extended-properties";
	var RTCoreProperties = "http://schemas.openxmlformats.org/package/2006/relationships/metadata/core-properties";
	var RTOfficeDocument = "http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument";

}