import 'package:flutter/material.dart';
import 'package:jibber/core/enums.dart';

class BaseViewModel extends ChangeNotifier {
  ViewState _viewState = ViewState.idle;

  ViewState get viewState => _viewState;

  setState(ViewState state) {
    _viewState = state;
    notifyListeners();
  }
}
