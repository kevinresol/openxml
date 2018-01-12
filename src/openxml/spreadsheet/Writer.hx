package openxml.spreadsheet;

import archive.*;
import archive.zip.*;
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

	public function write(workbook:Workbook):RealSource {
		var entries = [];
		var core = new CoreProperties();
		var app = new ExtendedProperties(AppExcel);
		var contentTypes = new ContentTypes();
		var relationships = new Relationships();
		
		contentTypes.addPart("/docProps/core.xml", CTCoreProperties);
		contentTypes.addPart("/docProps/app.xml", CTExtendedProperties);
		contentTypes.addPart('/xl/workbook.xml', CTWorkbook);
		contentTypes.addPart('/xl/sharedStrings.xml', CTSharedStrings);
		contentTypes.addPart('/xl/styles.xml', CTStyles);
		
		for (ws in workbook.worksheets) {
			entries.push(toEntry(ws, 'xl/worksheets/sheet${ws.id}.xml'));
			contentTypes.addPart('/xl/worksheets/sheet${ws.id}.xml', CTWorksheet);
		}
		
		relationships.add(RTExtendedProperties, "docProps/app.xml");
		relationships.add(RTCoreProperties, "docProps/core.xml");
		relationships.add(RTOfficeDocument, "xl/workbook.xml");
		
		workbook.relationships.add(RTSharedStrings, "sharedStrings.xml");
		workbook.relationships.add(RTStyles, "styles.xml");
		
		entries.push(toEntry(relationships, '_rels/.rels'));
		entries.push(toEntry(contentTypes, '[Content_Types].xml'));
		entries.push(toEntry(core, 'docProps/core.xml'));
		entries.push(toEntry(app, 'docProps/app.xml'));
		entries.push(toEntry(workbook, 'xl/workbook.xml'));
		entries.push(toEntry(workbook.styles, 'xl/styles.xml'));
		entries.push(toEntry(workbook.relationships, 'xl/_rels/workbook.xml.rels'));
		entries.push(toEntry(SharedStrings.instance, 'xl/sharedStrings.xml'));
		
		return zip.pack(Stream.ofIterator(entries.iterator()));
		// zipWriter.write(entries);
	}
	
	function toEntry(obj:IXml, path:String):Entry<Noise> {
		var xml = obj.toXml().toString();
		return {
			name: path,
			size: xml.length,
			source: xml
		}
	}
}