package openxml.spreadsheet;

import openxml.util.XmlObject;
using openxml.util.XmlTools;
/**
 * ...
 * @author Kevin
 */
class ExtendedProperties extends XmlObject
{

	public function new() 
	{
		super();
		
		
		
		//var headingPairs = p.addNewElement('HeadingPairs')
		
		
		
	}
	
	override public function toXml():Xml 
	{
		var xml = Xml.createDocument();
		xml.addProcessingInstruction('xml version="1.0" encoding="UTF-8"');
		
		var p = xml.addNewElement('Properties');
		p.set('xmlns', "http://schemas.openxmlformats.org/officeDocument/2006/extended-properties");
		p.set('xmlns:vt', "http://schemas.openxmlformats.org/officeDocument/2006/docPropsVTypes");
		
		p.addNewElement('Application', 'Microsoft Excel');
		p.addNewElement('DocSecurity', '0');
		p.addNewElement('ScaleCrop', 'false');
		
		return xml;
	}
	
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