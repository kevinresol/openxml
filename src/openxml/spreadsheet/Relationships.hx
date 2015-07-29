package openxml.spreadsheet;
import openxml.util.XmlObject;
using openxml.util.XmlTools;
/**
 * ...
 * @author Kevin
 */
class Relationships extends XmlObject
{
	var relationships:Array<Relationship>;
	
	public function new() 
	{
		super();
		header = '<?xml version="1.0" encoding="UTF-8"?>';
		
		relationships = [];
	}
	
	public function add(object:XmlObject, type:RelationshipType, target:String)
	{
		if (get(object) == null)
			relationships.push( { object:object, type:type, target:target } );
	}
	
	public function get(object:XmlObject):Relationship
	{
		for (o in relationships) if (o.object == object) return o;
		return null;
	}
	
	override public function toXmlString():String 
	{
		xml = Xml.createDocument();
		
		var xrs = xml.addNewElement('Relationships');
		xrs.set('xmlns', 'http://schemas.openxmlformats.org/package/2006/relationships');
		
		for (i in 0...relationships.length)
		{
			var id = i + 1;
			var r = relationships[i];
			var xr = xrs.addNewElement('Relationship');
			xr.set('Id', 'rId$id');
			xr.set('Type', r.type);
			xr.set('Target', r.target);
		}
		
		return xml.toString();
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

typedef Relationship =
{
	object:XmlObject,
	type:RelationshipType,
	target:String,
}