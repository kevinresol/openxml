package;

import format.zip.Reader;
import format.zip.Tools;
import openxml.spreadsheet.Workbook;
import openxml.spreadsheet.Worksheet;
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
		
		var f = File.write('output.xlsx', true);
		var w = new Writer(f);
		w.write(wb);
		f.close();
	}
	
}