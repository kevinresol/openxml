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
		
		var f = File.write('output.docx', true);
		var w = new Writer(f);
		w.write(doc);
		f.close();
	}
	
}