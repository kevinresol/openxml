package;

import openxml.spreadsheet.style.Font;
import openxml.spreadsheet.Workbook;
import openxml.spreadsheet.Writer;

@:asserts
class TestSpreadsheet {
	public function new() {}
	
	public function testOutput() {
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
		
		
		var w = new Writer(new archive.zip.NodeZip());
		var path = 'bin/output.xlsx';
		w.write(wb).pipeTo(tink.io.Sink.ofNodeStream('name', js.node.Fs.createWriteStream(path)))
			.handle(function(o) {
				asserts.assert(RunTests.runValidator('spreadsheet', path) == 0);
				asserts.done();
			});
		
		return asserts;
	}
	
}