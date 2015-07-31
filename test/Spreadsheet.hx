package;

import openxml.spreadsheet.style.Font;
import openxml.spreadsheet.Workbook;
import openxml.spreadsheet.Writer;
import sys.io.File;

/**
 * ...
 * @author Kevin
 */

class Spreadsheet 
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
		
		var cell = ws.getCell(4, 4);
		cell.content = CFormula("A1+A2");
		var font = wb.styles.fonts.addFont();
		font.size = 50;
		cell.format.font = font;
		
		var fill = wb.styles.fills.addFill();
		fill.patternFill.type = PFDarkGray;
		cell.format.fill = fill;
		
		ws.getCell(4, 5).content = CNumber(1.262234936);
		var fill = wb.styles.fills.addFill();
		fill.patternFill.type = PFSolid(0xffff0000);
		ws.getCell(4, 5).format.fill = fill;
		
		var f = File.write('output.xlsx', true);
		var w = new Writer(f);
		w.write(wb);
		f.close();
	}
	
}