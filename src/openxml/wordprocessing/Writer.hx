package openxml.wordprocessing;

import archive.zip.Zip;
import openxml.ContentTypes;
import openxml.CoreProperties;
import openxml.ExtendedProperties;
import openxml.Relationships;
import openxml.util.IXml;
import tink.streams.Stream;

using openxml.util.XmlTools;
using tink.io.Source;
using tink.CoreApi;
/**
 * ...
 * @author Kevin
 */
class Writer {
	var zip:Zip;
	
	public function new(zip) {
		this.zip = zip;
	}

	public function write(document:Document) {
		
		var entries = [];
		var core = new CoreProperties();
		var app = new ExtendedProperties(AppWord);
		var contentTypes = new ContentTypes();
		var relationships = new Relationships();
		
		contentTypes.addPart("/docProps/core.xml", CTCoreProperties);
		contentTypes.addPart("/docProps/app.xml", CTExtendedProperties);
		contentTypes.addPart('/word/document.xml', CTDocument);
		
		relationships.add(RTExtendedProperties, "docProps/app.xml");
		relationships.add(RTCoreProperties, "docProps/core.xml");
		relationships.add(RTOfficeDocument, "word/document.xml");
		
		entries.push(relationships.toEntry('_rels/.rels'));
		entries.push(contentTypes.toEntry('[Content_Types].xml'));
		entries.push(core.toEntry('docProps/core.xml'));
		entries.push(app.toEntry('docProps/app.xml'));
		entries.push(document.toEntry('word/document.xml'));
		entries.push(document.relationships.toEntry('word/_rels/document.xml.rels'));
		
		
		return zip.pack(Stream.ofIterator(entries.iterator()));
	}
	
	
}