package openxml.spreadsheet.style;
import openxml.util.Color;
import openxml.util.IXml;
import openxml.util.XmlArray;
using openxml.util.XmlTools;
/**
 * ...
 * @author ...
 */
class Fills extends XmlArray<Fill>
{
	public function new() 
	{
		super('fills');
		
		// excel overrides the first two fill entries
		addFill();
		addFill();
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
	public var type:PatternType = PFNone;
	
	public var foregroundColor(get, null):Color;
	public var backgroundColor(get, null):Color;
	
	var hasForegroundColor:Bool = false;
	var hasBackgroundColor:Bool = false;
	
	public function new()
	{
		
	}
	
	public function toXml():Xml
	{
		var xpf = Xml.createElement('patternFill');
		
		switch (type) 
		{
			case PFNone:			xpf.set('patternType', 'none');
			case PFGray0625:		xpf.set('patternType', 'gray0125');
			case PFGray125:			xpf.set('patternType', 'gray125');
			case PFMediumGray:		xpf.set('patternType', 'mediumGray');
			
			case PFDarkDown:		xpf.set('patternType', 'darkDown');
			case PFDarkGray:		xpf.set('patternType', 'darkGray');
			case PFDarkHorizontal:	xpf.set('patternType', 'darkHorizontal');
			case PFDarkTrellis:		xpf.set('patternType', 'darkTrellis');
			case PFDarkUp:			xpf.set('patternType', 'darkUp');
			case PFDarkVertical:	xpf.set('patternType', 'darkVertical');
			
			case PFLightDown:		xpf.set('patternType', 'lightDown');
			case PFLightGray:		xpf.set('patternType', 'lightGray');
			case PFLightHorizontal:	xpf.set('patternType', 'lightHorizontal');
			case PFLightTrellis	:	xpf.set('patternType', 'lightTrellis');
			case PFLightUp:			xpf.set('patternType', 'lightUp');
			case PFLightVertical:	xpf.set('patternType', 'lightVertical');
			
			case PFSolid(color):
				xpf.set('patternType', 'solid');
				foregroundColor.argb = color;
		}
		
		if (hasForegroundColor) xpf.addChild(foregroundColor.toXml());
		if (hasBackgroundColor) xpf.addChild(backgroundColor.toXml());
		
		return xpf;
	}
	
	private function get_foregroundColor():Color
	{
		if (foregroundColor == null) 
		{
			foregroundColor = new Color('fgColor');
			hasForegroundColor = true;
		}
		return foregroundColor;
	}
	
	private function get_backgroundColor():Color
	{
		if (backgroundColor == null) 
		{
			backgroundColor = new Color('bgColor');
			hasBackgroundColor = true;
		}
		return backgroundColor;
	}
}

enum PatternType
{
	PFNone;
	
	PFGray125;
	PFGray0625;
	PFMediumGray;
	
	PFSolid(color:Int);
	
	PFDarkDown;
	PFDarkGray;
	PFDarkHorizontal;
	PFDarkTrellis;
	PFDarkUp;
	PFDarkVertical;
	
	PFLightDown;
	PFLightGray;
	PFLightHorizontal;
	PFLightTrellis;
	PFLightUp;
	PFLightVertical;
	
}