import 'dart:developer';

import 'package:jibber/core/base_view_model.dart';
import 'package:jibber/core/enums.dart';
import 'package:jibber/core/models/user_model.dart';
import 'package:jibber/core/services/database_service.dart';

class ChatsViewmodel extends BaseViewModel {
  final DatabaseService _db;
  final UserModel _currentUser;

  ChatsViewmodel(this._db, this._currentUser) {
    fetchUsers();
  }

  List<UserModel> _users = [];
  List<UserModel> _filteredUsers = [];

  List<UserModel> get users => _users;
  List<UserModel> get filteredUsers => _filteredUsers;

  search(String value) {
    _filteredUsers =
        _users.where((e) => e.name!.toLowerCase().contains(value)).toList();
    notifyListeners();
  }

  fetchUsers() async {
    try {
      setState(ViewState.loading);

      _db.fetchUserStream(_currentUser.uid!).listen((data) {
        _users = data.docs.map((e) => UserModel.fromMap(e.data())).toList();
        _filteredUsers = users;
        notifyListeners();
      });

      setState(ViewState.idle);
    } catch (e) {
      setState(ViewState.idle);
      log("Error Fetching Users: $e");
    }
  }
}
