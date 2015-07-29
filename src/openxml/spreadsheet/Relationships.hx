package openxml.spreadsheet;
import openxml.util.IXml;
using openxml.util.XmlTools;
/**
 * ...
 * @author Kevin
 */
class Relationships implements IXml
{
	var relationships:Array<Relationship>;
	
	public function new() 
	{
		relationships = [];
	}
	
	public function add(object:IXml, type:RelationshipType, target:String)
	{
		if (get(object) == null)
			relationships.push( { object:object, type:type, target:target } );
	}
	
	public function get(object:IXml):Relationship
	{
		for (o in relationships) if (o.object == object) return o;
		return null;
	}
	
	public function toXml():Xml 
	{
		var xml = Xml.createDocument();
		xml.addProcessingInstruction('xml version="1.0" encoding="UTF-8"');
		
		var xrs = xml.addNewElement('Relationships');
		xrs.set('xmlns', Constants.RELATION_SCHEMA);
		
		for (i in 0...relationships.length)
		{
			var id = i + 1;
			var r = relationships[i];
			var xr = xrs.addNewElement('Relationship');
			xr.set('Id', 'rId$id');
			xr.set('Type', r.type);
			xr.set('Target', r.target);
		}
		
		return xml;
	}
}

@:enum
abstract RelationshipType(String) to String
{
	var RTWorksheet = "http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet";
	var RTExtendedProperties = "http://schemas.openxmlformats.org/officeDocument/2006/relationships/extended-properties";
	var RTCoreProperties = "http://schemas.openxmlformats.org/package/2006/relationships/metadata/core-properties";
	var RTOfficeDocument = "http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument";
	var RTSharedStrings = "http://schemas.openxmlformats.org/officeDocument/2006/relationships/sharedStrings";
}

typedef Relationship =
{
	object:IXml,
	type:RelationshipType,
	target:String,
}