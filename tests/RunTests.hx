package;

import haxe.unit.TestRunner;

class RunTests {

  static function main() {
    
    var runner = new TestRunner();
    runner.add(new TestWordprocessing());
    
    travix.Logger.exit(runner.run() ? 0 : 500);
  }
  
  
  
}