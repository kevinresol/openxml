package;

import openxml.spreadsheet.Workbook;
import openxml.spreadsheet.Writer;
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
		ws.getCell(1, 1).content = CString("hihi");
		ws.getCell(1, 2).content = CString("hihi");
		ws.getCell(3, 3).content = CString("hihi2");
		ws.getCell(3, 4).content = CString("hihi2");
		ws.getCell(4, 4).content = CFormula("A1+A2");
		ws.getCell(4, 5).content = CNumber(1.262234936);
		
		
		var ws = wb.addWorksheet('SheetB');
		ws.getCell(1, 1).content = CString("hihi");
		ws.getCell(1, 2).content = CString("hihi");
		ws.getCell(3, 3).content = CString("hihi2");
		ws.getCell(3, 4).content = CString("hihi2");
		ws.getCell(3, 4).clearContent();
		ws.getCell(4, 4).content = CFormula("A1+A2");
		ws.getCell(4, 5).content = CNumber(1.262234936);
		
		var f = File.write('output.xlsx', true);
		var w = new Writer(f);
		w.write(wb);
		f.close();
	}
	
}