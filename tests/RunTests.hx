package;

import tink.unit.*;
import tink.testrunner.*;

class RunTests {

	static function main() {
		
		Runner.run(TestBatch.make([
			new TestSpreadsheet(),
		])).handle(Runner.exit);
	}
	
	public static function runValidator(type:String, path:String) {
		trace(Sys.getCwd());
		return switch Sys.systemName() {
			case 'Windows': Sys.command('"./bin/validator/bin/Validator.exe"', [type, path]);
			default: Sys.command('mono', ['./bin/validator/bin/Validator.exe', type, path]);
		}
	}
	
}