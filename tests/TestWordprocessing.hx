package;

import haxe.unit.TestCase;

import openxml.wordprocessing.Document;
import openxml.wordprocessing.Writer;
import sys.io.File;

class TestWordprocessing extends TestCase {
    public function testOutput() {
        var doc = new Document();
        doc.body.addParagraph("My paragraph.");
        
        var path = 'bin/output.docx';
        var f = File.write(path, true);
        var w = new Writer(f);
        w.write(doc);
        f.close();
        
        assertEquals(0, Sys.command('bin/validator/bin/Validator.exe', [path]));
    }
}