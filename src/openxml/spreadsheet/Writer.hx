package openxml.spreadsheet;
import format.zip.Tools;
import haxe.crypto.Crc32;
import haxe.io.Bytes;
import haxe.io.Output;
import haxe.zip.Writer in ZipWriter;
import haxe.zip.Entry;
import openxml.spreadsheet.ContentTypes;
import openxml.spreadsheet.Relationships;
import openxml.util.IXml;

using openxml.util.XmlTools;
using openxml.spreadsheet.Writer;
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
		var app = new ExtendedProperties();
		var contentTypes = new ContentTypes();
		var relationships = new Relationships();
		
		contentTypes.addPart("/docProps/core.xml", CTCoreProperties);
		contentTypes.addPart("/docProps/app.xml", CTExtendedProperties);
		contentTypes.addPart('/xl/workbook.xml', CTWorkbook);
		
		for (ws in workbook.worksheets)
		{
			entries.add(ws.toEntry('xl/worksheets/sheet${ws.id}.xml'));
			contentTypes.addPart('/xl/worksheets/sheet${ws.id}.xml', CTWorksheet);
		}
		
		relationships.add(app, RTExtendedProperties, "docProps/app.xml");
		relationships.add(core, RTCoreProperties, "docProps/core.xml");
		relationships.add(workbook, RTOfficeDocument, "xl/workbook.xml");
		
		entries.add(workbook.toEntry('xl/workbook.xml'));
		entries.add(relationships.toEntry('_rels/.rels'));
		entries.add(contentTypes.toEntry('[Content_Types].xml'));
		entries.add(workbook.relationships.toEntry('xl/_rels/workbook.xml.rels'));
		entries.add(core.toEntry('docProps/core.xml'));
		entries.add(app.toEntry('docProps/app.xml'));
		
		zipWriter.write(entries);
	}
	
	static function toEntry(xml:IXml, fileName:String):Entry
	{
		var data = Bytes.ofString(xml.toXmlString());
		var e = {
			fileName: fileName,
			fileSize: data.length,
			data: data,
			fileTime: Date.now(),
			compressed: false,
			dataSize: data.length,
			crc32: Crc32.make(data),
		}
		Tools.compress(e, 9);
		return e;
	}
}