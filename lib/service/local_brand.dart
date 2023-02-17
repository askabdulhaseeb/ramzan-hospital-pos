// import 'package:shared_preferences/shared_preferences.dart';

// import '../models/app_user.dart';

// class LocalAuth {
//   static late SharedPreferences? _preferences;
//   static Future<void> init() async =>
//       _preferences = await SharedPreferences.getInstance();

//   final String _uidKey = 'UID_KEY';
//   final String _brandIDKey = 'BRAND_ID_KEY';
//   final String _branchIDKey = 'BRANCH_ID_KEY';
//   final String _loginDateKey = 'LOGIN_DATE_KEY';

//   Future<void> setUID(String value) => _preferences!.setString(_uidKey, value);
//   Future<void> setBrandID(String value) =>
//       _preferences!.setString(_brandIDKey, value);
//   Future<void> setBranchID(String value) =>
//       _preferences!.setString(_branchIDKey, value);
//   Future<void> setLoginDate(String value) =>
//       _preferences!.setString(_loginDateKey, value);

//   String get uid => _preferences?.getString(_uidKey) ?? '';
//   String get brandID => _preferences?.getString(_brandIDKey) ?? '';
//   String get branchID => _preferences?.getString(_branchIDKey) ?? '';
//   String get logInDate => _preferences?.getString(_loginDateKey) ?? '';

//   login(AppUser value) {
//     setUID(value.uid);
//     setBrandID(value.brandID);
//     setBranchID(value.branchID);
//     setLoginDate(DateTime.now().day.toString());
//   }

//   signout() {
//     setUID('');
//     setBrandID('');
//     setBranchID('');
//     setLoginDate('');
//   }
// }
