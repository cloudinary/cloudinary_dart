import '../common.dart';
import 'effect_actions.dart';

class Effect extends Action {
    static Effect sepia([Sepia? sepia]) {
      if(sepia != null) {
        return sepia;
      }
      return Sepia();
    }
}