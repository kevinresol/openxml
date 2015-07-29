package openxml.spreadsheet;
import openxml.util.IXml;
using openxml.util.XmlTools;
/**
 * ...
 * @author Kevin
 */
class Cell implements IXml
{
	public var content:CellContent;
	public var row:Int;
	public var col:Int;
	public var address:A1Reference;
	public var dataType:DataType;

	
	public function new(row:Int, col:Int) 
	{
		this.row = row;
		this.col = col;
		address = A1Reference.create(row, col);
	}
	
	public function clearContent()
	{
		content = null;
	}
	
	public function toXml():Xml 
	{
		if (content == null) return null;
		
		var c = Xml.createElement('c');
		c.set('r', address);
		
		switch (content) 
		{
			case CBool(value): 
				c.set('t', DTBool);
				c.addNewElement('v', Std.string(value));
			case CNumber(value): 
				c.set('t', DTNumber);
				c.addNewElement('v', Std.string(value));
			case CFormula(formula): 
				c.set('t', DTString);
				c.addNewElement('f', Std.string(formula));
			case CString(value): 
				var index = SharedStrings.instance.addString(value);
				c.set('t', DTSharedString);
				c.addNewElement('v', Std.string(index));
		}
		
		return c;
	}
}

abstract A1Reference(String) to String
{
	public static inline function create(row:Int, col:Int):A1Reference
	{
		var address = columnNumToLetter(col) + (row + 1);
		return new A1Reference(address);
	}
	
	inline function new(ref:String) 
	{
		this = ref;
	}
	
	static function columnNumToLetter(col:Int):String
	{
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
abstract DataType(String) to String
{
	var DTBool = 'b';
	var DTError = 'e';
	var DTInlineString = 'inlineStr';
	var DTNumber = 'n';
	var DTSharedString = 's'; // shared string
	var DTString = 'str'; // formula string
}

enum CellContent
{
	CBool(value:Bool);
	CNumber(value:Float);
	CFormula(formula:String);
	CString(value:String);
}