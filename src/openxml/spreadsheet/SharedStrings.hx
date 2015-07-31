package openxml.spreadsheet;

import openxml.util.IXml;
using openxml.util.XmlTools;
/**
 * ...
 * @author Kevin
 */
class SharedStrings implements IXml
{
	public static var instance:SharedStrings = new SharedStrings();
	
	var strings:Array<{value:String, count:Int}>;
	var index:Int;
	
	function new() 
	{
		strings = [];
	}
	
	public function addString(str:String):Int
	{
		var index = getIndex(str);
		
		if (index == -1) 
			index = strings.push({value:str, count:1}) - 1;
		else
			strings[index].count ++;
		
		return index;
	}
	
	public function removeString(str:String)
	{
		var index = getIndex(str);
		if (index != -1) strings[index].count --;
	}
	
	public function getIndex(str:String):Int
	{
		for (i in 0...strings.length) if (strings[i].value == str) return i;
		return -1;
	}
	
	public function toXml():Xml 
	{
		var xml = Xml.createDocument();
		xml.addProcessingInstruction('xml version="1.0" encoding="UTF-8" standalone="yes"');
		
		var xsst = xml.addElement('sst');
		xsst.set('xmlns', XmlNameSpaces.SPREADSHEET_ML);
		
		var count = 0;
		for (s in strings)
		{
			count += s.count;
			var xsi = xsst.addElement('si');
			xsi.addElement('t', s.value);
		}
		
		xsst.set('count', Std.string(count));
		xsst.set('uniqueCount', Std.string(strings.length));
		
		return xml;
	}
}