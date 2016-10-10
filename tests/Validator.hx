package;


import documentformat.openxml.packaging.*;
import documentformat.openxml.validation.*;
import documentformat.openxml.wordprocessing.*;

class Validator {
	static function main() {
		var path = Sys.args()[0];
		var doc = WordprocessingDocument.Open(path, false);
		var validator = new OpenXmlValidator();
		var errors = validator.Validate(doc);
		
		var hasError = false;
		var enumerator = errors.GetEnumerator();
		while(enumerator.MoveNext()) {
			if(!hasError) {
				hasError = true;
				trace('Document is invalid');
			}
			var error = enumerator.Current;
			trace('Error description: ' + error.Description);
			trace('Content type of part with error: ' + error.Part.ContentType);
			trace('Location of error: ' + error.Path.XPath);
		}
		if(!hasError) trace('Document is valid');
	}
}