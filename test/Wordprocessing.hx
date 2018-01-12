package;

import openxml.wordprocessing.Document;
import openxml.wordprocessing.Writer;
import sys.io.File;

/**
 * ...
 * @author Kevin
 */

class Wordprocessing 
{
	
	static function main() 
	{
		var doc = new Document();
		doc.body.addParagraph("My paragraph.");
		
		var w = new Writer(new archive.zip.NodeZip());
		w.write(doc).pipeTo(tink.io.Sink.ofNodeStream('name', js.node.Fs.createWriteStream('output.docx')))
			.handle(function(o) {
				trace(o);
				Sys.exit(0);
			});
	}
	
}