package;

import documentformat.openxml.packaging.*;
import documentformat.openxml.validation.*;
import documentformat.openxml.wordprocessing.*;

class Validator {
	static function main() {
		trace('Starting Validator');
		var args = Sys.args();
		var type = args[0];
		var path = args[1];
		
		var isValid = switch type {
			case 'wordprocessing': validateWordprocessing(path);
			case 'spreadsheet': validateSpreadsheet(path);
			default: false;
		}
		
		Sys.exit(isValid ? 0 : 500);
	}
	static function validateWordprocessing(path:String) {
		trace('Validating Wordprocessing: $path');
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
		return !hasError;
	}
	static function validateSpreadsheet(path:String) {
		trace('Validating Spreadsheet: $path');
		var doc = SpreadsheetDocument.Open(path, false);
		var validator = new OpenXmlValidator();
		var errors = validator.Validate(doc);
		
		var hasError = false;
		var enumerator = errors.GetEnumerator();
		while(enumerator.MoveNext()) {
			if(!hasError) {
				hasError = true;
				trace('Spreadsheet is invalid');
			}
			var error = enumerator.Current;
			trace('Error description: ' + error.Description);
			trace('Content type of part with error: ' + error.Part.ContentType);
			trace('Location of error: ' + error.Path.XPath);
		}
		if(!hasError) trace('Spreadsheet is valid');
		return !hasError;
	}
}