import 'package:jibber/core/base_view_model.dart';

class MainViewmodel extends BaseViewModel {
  int _currentIndex = 1;

  int get currentIndex => _currentIndex;

  setIndex(int value) {
    if (_currentIndex != value) {
      _currentIndex = value;
      notifyListeners();
    }
  }
}
