package openxml.wordprocessing;

import openxml.Relationships;
import openxml.util.IXml;
using openxml.util.XmlTools;
/**
 * ...
 * @author ...
 */
class Document implements IXml
{
	public var body:Body;
	public var relationships:Relationships;
	
	public function new() 
	{
		body = new Body();
		relationships = new Relationships();
	}
	
	public function toXml():Xml 
	{
		var xml = Xml.createDocument();
		xml.addProcessingInstruction('xml version="1.0" encoding="UTF-8" standalone="yes"');
		
		var xdoc = xml.addElement('w:document');
		
		xdoc.set('xmlns:r',  XmlNameSpaces.officeDocument.RELATIONSHIPS);
		xdoc.set('xmlns:w', XmlNameSpaces.wordprocessingml.MAIN);
		/*
		xmlns:wp = "http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing" 
		xmlns:m = "http://schemas.openxmlformats.org/officeDocument/2006/math" 
		xmlns:ve = "http://schemas.openxmlformats.org/markup-compatibility/2006"
		
		xmlns:w10 = "urn:schemas-microsoft-com:office:word" 
		xmlns:v = "urn:schemas-microsoft-com:vml" 
		xmlns:o = "urn:schemas-microsoft-com:office:office" 
		*/
		xdoc.addChild(body.toXml());
		
		return xml;
	}
	
}

class Body implements IXml
{
	var paragraphs:Array<Paragraph>;
	
	public function new()
	{
		paragraphs = [];
	}
	
	public function addParagraph(?text:String):Paragraph
	{
		var p = new Paragraph(text);
		paragraphs.push(p);
		return p;
	}
	
	public function toXml():Xml
	{
		var xml = Xml.createElement('w:body');
		
		for (p in paragraphs)
			xml.addChild(p.toXml());
			
		return xml;
	}
}

class Paragraph implements IXml
{
	public var text:String;
	
	public function new(?text:String)
	{
		this.text = text;
	}
	
	public function toXml():Xml 
	{
		var xml = Xml.createElement('w:p');
		
		if (text == null) text = '';
		
		var xr = xml.addElement('w:r');
		xr.addElement('w:t', text);
		
		return xml;
	}
}