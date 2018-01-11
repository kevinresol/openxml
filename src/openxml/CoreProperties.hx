package openxml;

import xml.*;
import openxml.util.IXml;

/**
 * ...
 * @author Kevin
 */
class CoreProperties extends Document implements IXml {
	public function new() {
		super(
			new ProcessingInstruction('xml version="1.0" encoding="UTF-8"'),
			new Element('cp:coreProperties')
				.setAttribute('xmlns:cp', "http://schemas.openxmlformats.org/package/2006/metadata/core-properties")
				.setAttribute('xmlns:dc', "http://purl.org/dc/elements/1.1/")
				.setAttribute('xmlns:dcmitype', "http://purl.org/dc/dcmitype/")
				.setAttribute('xmlns:dcterms', "http://purl.org/dc/terms/")
				.setAttribute('xmlns:xsi', "http://www.w3.org/2001/XMLSchema-instance")
		);
	}
}