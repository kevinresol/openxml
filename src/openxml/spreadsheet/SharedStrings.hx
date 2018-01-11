package openxml.spreadsheet;

import xml.*;
import openxml.util.IXml;

/**
 * ...
 * @author Kevin
 */
class SharedStrings implements IXml {
	public static var instance:SharedStrings = new SharedStrings();
	
	var strings:Array<{value:String, count:Int}>;
	var index:Int;
	
	function new() {
		strings = [];
	}
	
	public function addString(str:String):Int {
		var index = getIndex(str);
		
		if (index == -1) 
			index = strings.push({value:str, count:1}) - 1;
		else
			strings[index].count ++;
		
		return index;
	}
	
	public function removeString(str:String) {
		var index = getIndex(str);
		if (index != -1) strings[index].count --;
	}
	
	public function getIndex(str:String):Int {
		for (i in 0...strings.length) if (strings[i].value == str) return i;
		return -1;
	}
	
	public function toXml():Xml {
		var doc = new Document(
			new ProcessingInstruction('xml version="1.0" encoding="UTF-8" standalone="yes"'),
			new Element('sst')
				.setAttribute('xmlns', XmlNameSpaces.spreadsheetml.MAIN)
		);
		
		
		var count = 0;
		for (s in strings) {
			count += s.count;
			doc.root.add(
				new Element('si')
					.add(new Element('t').addText(s.value))
			);
		}
		
		doc.root
			.setAttribute('count', Std.string(count))
			.setAttribute('uniqueCount', Std.string(strings.length));
		
		return doc.toXml();
	}
}