package;

import openxml.wordprocessing.Document;
import openxml.wordprocessing.Writer;

@:asserts
class TestWordprocessing {
	public function new() {}
	
	public function testOutput() {
		var doc = new Document();
		doc.body.addParagraph("My paragraph.");
		
		var path = 'bin/output.docx';
		
		var w = new Writer(new archive.zip.NodeZip());
		var path = 'bin/output.docx';
		w.write(doc).pipeTo(tink.io.Sink.ofNodeStream('name', js.node.Fs.createWriteStream(path)))
			.handle(function(o) {
				asserts.assert(RunTests.runValidator('wordprocessing', path) == 0);
				asserts.done();
			});
		
		return asserts;
	}
}