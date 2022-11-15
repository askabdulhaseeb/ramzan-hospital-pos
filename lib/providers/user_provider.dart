import 'package:flutter/material.dart';

import '../models/app_user.dart';

class UserProvider extends ChangeNotifier {
  UserProvider() {
    _load();
  }
  AppUser user(String uidValue) {
    final int index =
        _users.indexWhere((AppUser element) => element.uid == uidValue);
    return index < 0 ? _null : _users[index];
  }

  List<AppUser> _users = <AppUser>[];
  _load() {
    _users = <AppUser>[
      AppUser(uid: '1', name: 'name 1', contact: '1111'),
      AppUser(uid: '2', name: 'name 2', contact: '2222'),
      AppUser(uid: '3', name: 'name 3', contact: '3333'),
    ];
  }

  AppUser get _null => AppUser(uid: 'null', name: 'null');
}
