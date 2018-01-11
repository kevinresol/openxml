package openxml;

import xml.*;
import openxml.util.IXml;

/**
 * ...
 * @author Kevin
 */
class ExtendedProperties extends Document implements IXml
{
	var application:Application;
	
	public function new(application:Application) {
		this.application = application;
		super(
			new ProcessingInstruction('xml version="1.0" encoding="UTF-8"'),
			new Element('Properties')
				.setAttribute('xmlns', "http://schemas.openxmlformats.org/officeDocument/2006/extended-properties")
				.setAttribute('xmlns:vt', "http://schemas.openxmlformats.org/officeDocument/2006/docPropsVTypes")
				.add(new Element('Application').add(new PCData(application)))
				.add(new Element('DocSecurity').add(new PCData('0')))
				.add(new Element('ScaleCrop').add(new PCData('false')))
		);
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