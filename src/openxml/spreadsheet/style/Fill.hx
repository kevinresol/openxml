package openxml.spreadsheet.style;

import xml.*;
import openxml.util.Color;
import openxml.util.IXml;
import openxml.util.XmlArray;

/**
 * ...
 * @author ...
 */
class Fills extends XmlArray<Fill> {
	public function new() {
		super('fills');
		
		// excel overrides the first two fill entries
		addFill();
		addFill();
	}
	
	public function addFill():Fill {
		var fill = new Fill();
		push(fill);
		return fill;
	}
	
}

class Fill implements IXmlArrayItem {
	public var patternFill:PatternFill;
	
	public var id:Int;
	
	public function new() {
		patternFill = new PatternFill();
	}
	
	public function toXml():Xml {
		var xfill = Xml.createElement('fill');
		
		xfill.addChild(patternFill.toXml());
		
		return xfill;
	}
}

class PatternFill implements IXml {
	public var type:PatternType = PFNone;
	
	public var foregroundColor(get, null):Color;
	public var backgroundColor(get, null):Color;
	
	var hasForegroundColor:Bool = false;
	var hasBackgroundColor:Bool = false;
	
	public function new() {
		
	}
	
	public function toXml():Xml {
		var xpf = new Element('patternFill');
		
		switch type {
			case PFNone:			xpf.setAttribute('patternType', 'none');
			case PFGray0625:		xpf.setAttribute('patternType', 'gray0125');
			case PFGray125:			xpf.setAttribute('patternType', 'gray125');
			case PFMediumGray:		xpf.setAttribute('patternType', 'mediumGray');
			
			case PFDarkDown:		xpf.setAttribute('patternType', 'darkDown');
			case PFDarkGray:		xpf.setAttribute('patternType', 'darkGray');
			case PFDarkHorizontal:	xpf.setAttribute('patternType', 'darkHorizontal');
			case PFDarkTrellis:		xpf.setAttribute('patternType', 'darkTrellis');
			case PFDarkUp:			xpf.setAttribute('patternType', 'darkUp');
			case PFDarkVertical:	xpf.setAttribute('patternType', 'darkVertical');
			
			case PFLightDown:		xpf.setAttribute('patternType', 'lightDown');
			case PFLightGray:		xpf.setAttribute('patternType', 'lightGray');
			case PFLightHorizontal:	xpf.setAttribute('patternType', 'lightHorizontal');
			case PFLightTrellis	:	xpf.setAttribute('patternType', 'lightTrellis');
			case PFLightUp:			xpf.setAttribute('patternType', 'lightUp');
			case PFLightVertical:	xpf.setAttribute('patternType', 'lightVertical');
			
			case PFSolid(color):
				xpf.setAttribute('patternType', 'solid');
				foregroundColor.argb = color;
		}
		
		if (hasForegroundColor) xpf.add(foregroundColor.toXml());
		if (hasBackgroundColor) xpf.add(backgroundColor.toXml());
		
		return xpf;
	}
	
	private function get_foregroundColor():Color {
		if (foregroundColor == null) {
			foregroundColor = new Color('fgColor');
			hasForegroundColor = true;
		}
		return foregroundColor;
	}
	
	private function get_backgroundColor():Color{
		if (backgroundColor == null) {
			backgroundColor = new Color('bgColor');
			hasBackgroundColor = true;
		}
		return backgroundColor;
	}
}

enum PatternType {
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