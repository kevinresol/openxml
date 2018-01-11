package openxml.spreadsheet;

import xml.*;
import openxml.spreadsheet.style.Styles;
import openxml.util.IXml;
/**
 * ...
 * @author Kevin
 */
class Workbook implements IXml {
	public var worksheets:Array<Worksheet>;
	public var relationships:Relationships;
	public var styles:Styles;
	
	public function new() {
		worksheets = [];
		relationships = new Relationships();
		styles = new Styles();
	}
	
	public function addWorksheet(name:String):Worksheet {
		var ws = new Worksheet(this, name);
		worksheets.push(ws);
		ws.id = worksheets.length;
		relationships.add(RTWorksheet, 'worksheets/sheet${ws.id}.xml');
		return ws;
	}
	
	public function getWorksheet(name:String):Worksheet {
		for (ws in worksheets) if (ws.name == name) return ws;
		return null;
	}
	
	public function toXml() {
		var doc = new Document(
			new ProcessingInstruction('xml version="1.0" encoding="UTF-8" standalone="yes"'),
			new Element('workbook')
				.setAttribute('xmlns', XmlNameSpaces.spreadsheetml.MAIN)
				.setAttribute('xmlns:r', XmlNameSpaces.officeDocument.RELATIONSHIPS)
		);
		
		
		var sheets = new Element('sheets');
		doc.root.add(sheets);
		
		for (i in 0...worksheets.length) {
			var ws = worksheets[i];
			var id = i + 1;
			sheets.add(
				new Element('sheet')
					.setAttribute('name', ws.name)
					.setAttribute('sheetId', '$id')
					.setAttribute('r:id', 'rId$id')
			);
		}
		
		return doc.toXml();
	}
}