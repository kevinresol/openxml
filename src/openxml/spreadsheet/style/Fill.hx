package openxml.spreadsheet.style;
import openxml.util.IXml;
import openxml.util.XmlArray;
using openxml.util.XmlTools;
/**
 * ...
 * @author ...
 */
class Fills extends XmlArray<Fill>
{
	public var defaultFill(default, null):Fill;
	
	public function new() 
	{
		super('fills');
		var defaultFill = addFill();
	}
	
	public function addFill():Fill
	{
		var fill = new Fill();
		push(fill);
		return fill;
	}
	
}

class Fill implements IXmlArrayItem
{
	public var patternFill:PatternFill;
	
	public var id:Int;
	
	public function new()
	{
		patternFill = new PatternFill();
	}
	
	public function toXml():Xml
	{
		var xfill = Xml.createElement('fill');
		
		xfill.addChild(patternFill.toXml());
		
		return xfill;
	}
}

class PatternFill implements IXml
{
	public var patternType:PatternType = PFNone;
	
	public function new()
	{
		
	}
	
	public function toXml():Xml
	{
		var xpf = Xml.createElement('patternFill');
		
		switch (patternType) 
		{
			case PFNone:
				xpf.set('patternType', 'none');
			case PFGray125:
				xpf.set('patternType', 'gray125');
				
		}
		
		return xpf;
	}
	
}

enum PatternType
{
	PFNone;
	PFGray125;
}