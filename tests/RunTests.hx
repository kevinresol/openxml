package;

import haxe.unit.TestRunner;

class RunTests {

	static function main() {
		
		var runner = new TestRunner();
		runner.add(new TestWordprocessing());
		runner.add(new TestSpreadsheet());
		
		travix.Logger.exit(runner.run() ? 0 : 500);
	}
	
	public static function runValidator(type:String, path:String) {
		return switch Sys.systemName() {
			case 'Windows': Sys.command('"bin/validator/bin/Validator.exe"', ['wordprocessing', path]);
			default: Sys.command('mono', ['"bin/validator/bin/Validator.exe"', 'wordprocessing', path]);
		}
	}
	
}