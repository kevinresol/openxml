package;

import openxml.spreadsheet.Workbook;
import openxml.spreadsheet.Writer;
import openxml.wordprocessing.Document;
import sys.io.File;

/**
 * ...
 * @author Kevin
 */

class Main 
{
	
	static function main() 
	{
		var wb = new Workbook();
		var ws = wb.addWorksheet('SheetA');
		ws.getCell(1, 1).content = CString("A string value");
		ws.getCell(1, 2).content = CString("Same string value");
		ws.getCell(3, 3).content = CString("Same string value");
		ws.getCell(4, 4).content = CFormula("A1+A2");
		ws.getCell(4, 5).content = CNumber(1.262234936);
		
		var ws = wb.addWorksheet('SheetB');
		
		var cell = ws.getCell(3, 3);
		cell.content = CString("Same string value");
		cell.clearContent();
		
		ws.getCell(4, 4).content = CFormula("A1+A2");
		ws.getCell(4, 5).content = CNumber(1.262234936);
		
		var f = File.write('output.xlsx', true);
		var w = new openxml.spreadsheet.Writer(f);
		w.write(wb);
		f.close();
		
		var doc = new Document();
		doc.body.addParagraph("My paragraph.");
		
		var f = File.write('output.docx', true);
		var w = new openxml.wordprocessing.Writer(f);
		w.write(doc);
		f.close();
	}
	
}