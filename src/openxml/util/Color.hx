package openxml.util;

import xml.*;

/**
 * ...
 * @author ...
 */
class Color implements IXml {
	public var auto:Null<Bool>;
	public var argb:Null<Int>;
	
	var elementName:String;

	public function new(elementName:String)  {
		this.elementName = elementName;
	}
	
	public function toXml():Xml {
		var xc = new Element(elementName);
		
		if (auto != null) xc.setAttribute('auto', auto);
		if (argb != null) xc.setAttribute('rgb', StringTools.hex(argb));
		
		return xc;
	}
	
}

enum ColorType {
	
}