package openxml.spreadsheet;
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

	public function write(workbook:Workbook) 
	{
		var zipWriter = new ZipWriter(o);
		var entries = new List();
		var core = new CoreProperties();
		var app = new ExtendedProperties(AppExcel);
		var contentTypes = new ContentTypes();
		var relationships = new Relationships();
		
		contentTypes.addPart("/docProps/core.xml", CTCoreProperties);
		contentTypes.addPart("/docProps/app.xml", CTExtendedProperties);
		contentTypes.addPart('/xl/workbook.xml', CTWorkbook);
		contentTypes.addPart('/xl/sharedStrings.xml', CTSharedStrings);
		contentTypes.addPart('/xl/styles.xml', CTStyles);
		
		for (ws in workbook.worksheets)
		{
			entries.add(ws.toEntry('xl/worksheets/sheet${ws.id}.xml'));
			contentTypes.addPart('/xl/worksheets/sheet${ws.id}.xml', CTWorksheet);
		}
		
		relationships.add(RTExtendedProperties, "docProps/app.xml");
		relationships.add(RTCoreProperties, "docProps/core.xml");
		relationships.add(RTOfficeDocument, "xl/workbook.xml");
		
		workbook.relationships.add(RTSharedStrings, "sharedStrings.xml");
		workbook.relationships.add(RTStyles, "styles.xml");
		
		entries.add(relationships.toEntry('_rels/.rels'));
		entries.add(contentTypes.toEntry('[Content_Types].xml'));
		entries.add(core.toEntry('docProps/core.xml'));
		entries.add(app.toEntry('docProps/app.xml'));
		entries.add(workbook.toEntry('xl/workbook.xml'));
		entries.add(workbook.styles.toEntry('xl/styles.xml'));
		entries.add(workbook.relationships.toEntry('xl/_rels/workbook.xml.rels'));
		entries.add(SharedStrings.instance.toEntry('xl/sharedStrings.xml'));
		
		zipWriter.write(entries);
	}
}