import 'package:smash_and_fight/model/changenotifier/changenotifier.dart';

class SwipeWidgetNotifier extends ChangeNotifier {
  void notifyChanges() {
    notifyListeners();
  }
}
