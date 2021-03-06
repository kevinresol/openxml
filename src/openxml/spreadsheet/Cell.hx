package openxml.spreadsheet;

import xml.*;
import openxml.spreadsheet.style.Format.CellFormat;
import openxml.util.IXml;

/**
 * ...
 * @author Kevin
 */
class Cell implements IXml {
	public var parent(default, null):Worksheet;
	public var content:CellContent;
	public var row:Int;
	public var col:Int;
	public var address:A1Reference;
	public var dataType:DataType;
	public var format(get, null):CellFormat;
	
	
	public function new(worksheet:Worksheet, row:Int, col:Int) {
		parent = worksheet;
		this.row = row;
		this.col = col;
		address = A1Reference.create(row, col);
	}
	
	public function clearContent() {
		content = null;
	}
	
	public function toXml():Xml  {
		if (content == null) return null;
		
		var c = new Element('c')
			.setAttribute('r', address);
		
		switch content {
			case CBool(value): 
				c.setAttribute('t', DTBool)
				 .add(new Element('v').addText(Std.string(value)));
			case CNumber(value): 
				c.setAttribute('t', DTNumber)
				 .add(new Element('v').addText(Std.string(value)));
			case CFormula(formula): 
				c.setAttribute('t', DTString)
				 .add(new Element('f').addText(Std.string(formula)));
			case CString(value): 
				var index = SharedStrings.instance.addString(value);
				c.setAttribute('t', DTSharedString)
				 .add(new Element('v').addText(Std.string(index)));
		}
		
		if (format != null)
			c.setAttribute('s', format.id);
		
		return c;
	}
	
	private inline function get_format() {
		if (format == null) format = cast parent.parent.styles.cellFormats.addFormat();
		return format;
	}
}

abstract A1Reference(String) to String to AttributeValue {
	public static inline function create(row:Int, col:Int):A1Reference {
		var address = columnNumToLetter(col) + (row + 1);
		return new A1Reference(address);
	}
	
	public static inline function createRange(row1:Int, col1:Int, row2:Int, col2:Int):A1Reference {
		if (row1 == row2 && col1 == col2) return create(row1, col1);
		
		var minR = row1;
		var maxR = row2;
		var minC = col1;
		var maxC = col2;
		
		if (row1 > row2) { minR = row2; maxR = row1; }
		if (col1 > col2) { minC = col2; maxC = col1; }
		
		return new A1Reference(columnNumToLetter(minC) + (minR + 1) + ":" + columnNumToLetter(maxC) + (maxR + 1));
	}
	
	inline function new(ref:String) {
		this = ref;
	}
	
	static function columnNumToLetter(col:Int):String {
		var d = col + 1;
		var name = "";
		var m = 0;
		
		while (d > 0)
		{
			m = (d - 1) % 26;
			name = String.fromCharCode(m + 65) + name;
			d = Std.int((d - m) / 26);
		}
		return name;
	}
}

@:enum
abstract DataType(String) to String to AttributeValue {
	var DTBool = 'b';
	var DTError = 'e';
	var DTInlineString = 'inlineStr';
	var DTNumber = 'n';
	var DTSharedString = 's'; // shared string
	var DTString = 'str'; // formula string
}

enum CellContent {
	CBool(value:Bool);
	CNumber(value:Float);
	CFormula(formula:String);
	CString(value:String);
}