package openxml;

import openxml.util.IXml;
using openxml.util.XmlTools;
/**
 * ...
 * @author Kevin
 */
class ExtendedProperties implements IXml
{
	var application:Application;
	
	public function new(application:Application) 
	{
		this.application = application;
	}
	
	public function toXml():Xml 
	{
		var xml = Xml.createDocument();
		xml.addProcessingInstruction('xml version="1.0" encoding="UTF-8"');
		
		var p = xml.addElement('Properties');
		p.set('xmlns', "http://schemas.openxmlformats.org/officeDocument/2006/extended-properties");
		p.set('xmlns:vt', "http://schemas.openxmlformats.org/officeDocument/2006/docPropsVTypes");
		
		p.addElement('Application', application);
		p.addElement('DocSecurity', '0');
		p.addElement('ScaleCrop', 'false');
		
		//var headingPairs = p.addElement('HeadingPairs')
		
		return xml;
	}
	
}

@:enum
abstract Application(String) to String
{
	var AppExcel = 'Microsoft Excel';
	var AppWord = 'Microsoft Office Word';
}

/*<Properties xmlns="http://schemas.openxmlformats.org/officeDocument/2006/extended-properties" xmlns:vt="http://schemas.openxmlformats.org/officeDocument/2006/docPropsVTypes">
	<Application>Microsoft Excel</Application>
	<DocSecurity>0</DocSecurity>
	<ScaleCrop>false</ScaleCrop>
	<HeadingPairs>
		<vt:vector size="2" baseType="variant">
			<vt:variant>
				<vt:lpstr>Worksheets</vt:lpstr>
			</vt:variant>
			<vt:variant>
				<vt:i4>1</vt:i4>
			</vt:variant>
		</vt:vector>
	</HeadingPairs>
	<TitlesOfParts>
		<vt:vector size="1" baseType="lpstr">
			<vt:lpstr>Sheet1</vt:lpstr>
		</vt:vector>
	</TitlesOfParts>
	<LinksUpToDate>false</LinksUpToDate>
	<SharedDoc>false</SharedDoc>
	<HyperlinksChanged>false</HyperlinksChanged>
	<AppVersion>12.0000</AppVersion>
</Properties>*/