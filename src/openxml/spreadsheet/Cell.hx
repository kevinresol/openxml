package openxml.spreadsheet;
import openxml.util.XmlObject;
using openxml.util.XmlTools;
/**
 * ...
 * @author Kevin
 */
class Cell extends XmlObject
{
	public var formula:String;
	public var value:String;
	public var row:Int;
	public var col:Int;
	public var address:A1Reference;
	public var dataType:DataType;

	public function new(row:Int, col:Int) 
	{
		super();
		this.row = row;
		this.col = col;
		address = A1Reference.create(row, col);
	}
	
	override public function toXml():Xml 
	{
		var c = Xml.createElement('c');
		c.set('r', address);
		c.set('t', dataType);
		
		if (value != null) c.addNewElement('v', value);
		if (formula != null) c.addNewElement('f', formula);
		
		return c;
	}
	
}

abstract A1Reference(String) to String
{
	public static inline function create(row:Int, col:Int):A1Reference
	{
		var address = columnNumToLetter(col) + row;
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