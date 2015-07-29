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
		
		var contentTypes = new ContentTypes();
		contentTypes.addPart("/docProps/core.xml", CTCoreProperties);
		contentTypes.addPart("/docProps/app.xml", CTExtendedProperties);
		
		var xlRelationships = new Relationships();

		
		var entries = new List();
		entries.add(workbook.toEntry('xl/workbook.xml'));
		contentTypes.addPart('/xl/workbook.xml', CTWorkbook);
		
		for (i in 0...workbook.worksheets.length)
		{
			var ws = workbook.worksheets[i];
			var id = i + 1;
			entries.add(ws.toEntry('xl/worksheets/sheet$id.xml'));
			contentTypes.addPart('/xl/worksheets/sheet$id.xml', CTWorksheet);
			xlRelationships.addRelationship('rId$id', RTWorksheet, 'worksheets/sheet$id.xml');
		}
		
		entries.add(contentTypes.toEntry('[Content_Types].xml'));
		entries.add(xlRelationships.toEntry('xl/_rels/workbook.xml.rels'));
		
		var relationships = new Relationships();
		relationships.addRelationship("rId3", RTExtendedProperties, "docProps/app.xml");
		relationships.addRelationship("rId2", RTCoreProperties, "docProps/core.xml");
		relationships.addRelationship("rId1", RTOfficeDocument, "xl/workbook.xml");
		entries.add(relationships.toEntry('_rels/.rels'));
		
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