package openxml.wordprocessing;
import format.zip.Tools;
import haxe.crypto.Crc32;
import haxe.io.Bytes;
import haxe.io.Output;
import haxe.zip.Entry;
import haxe.zip.Writer in ZipWriter;
import openxml.ContentTypes;
import openxml.CoreProperties;
import openxml.ExtendedProperties;
import openxml.Relationships;
import openxml.util.IXml;

using openxml.util.XmlTools;
/**
 * ...
 * @author Kevin
 */
class Writer
{
	var o:Output;
	public function new(o:Output)
	{
		this.o = o;
	}

	public function write(document:Document) 
	{
		var zipWriter = new ZipWriter(o);
		var entries = new List();
		var core = new CoreProperties();
		var app = new ExtendedProperties(AppWord);
		var contentTypes = new ContentTypes();
		var relationships = new Relationships();
		
		contentTypes.addPart("/docProps/core.xml", CTCoreProperties);
		contentTypes.addPart("/docProps/app.xml", CTExtendedProperties);
		contentTypes.addPart('/word/document.xml', CTDocument);
		
		relationships.add(app, RTExtendedProperties, "docProps/app.xml");
		relationships.add(core, RTCoreProperties, "docProps/core.xml");
		relationships.add(document, RTOfficeDocument, "word/document.xml");
		
		entries.add(relationships.toEntry('_rels/.rels'));
		entries.add(contentTypes.toEntry('[Content_Types].xml'));
		entries.add(core.toEntry('docProps/core.xml'));
		entries.add(app.toEntry('docProps/app.xml'));
		entries.add(document.toEntry('word/document.xml'));
		entries.add(document.relationships.toEntry('word/_rels/document.xml.rels'));
		
		zipWriter.write(entries);
	}
	
	
}