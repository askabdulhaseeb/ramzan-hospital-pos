// import 'package:flutter/cupertino.dart';

// import '../model/department.dart';
// import '../model/doctor.dart';
// import '../model/patient.dart';
// import '../model/selected_test.dart';
// import '../model/test.dart';

// class SlipProvider with ChangeNotifier {
//   bool changedvalue = false;
//   double discountpri = 0;
//   double payamount = 0;
//   bool histroyCheck = false;
//   void payAmount(double value) {
//     payamount = value;
//     notifyListeners();
//   }

//   void histroyPayAmount(double value) {
//     payamount = value;
//     notifyListeners();
//   }

//   double remaingAmount() {
//     double temp = totalPrice();
//     return temp - payamount;
//   }

//   void onDepartmentUpdate(Department? value) {
//     _department = value;
//     _doctor = null;
//     notifyListeners();
//   }

//   void onDoctorUpdate(Doctor? value) {
//     _doctor = value;
//     notifyListeners();
//   }

//   void onPatientUpdate(Patient? value) {
//     _patient = value;
//     notifyListeners();
//   }

//   onTestDiscount(SelectedTest testValue, String? discountValue) {
//     final int index = _indexOfSelectedIndex(testValue.test.testID);
//     _selectedTest[index].discount = double.parse(discountValue ?? '0.0');
//     notifyListeners();
//   }

//   double afterDiscountTestPrice(SelectedTest value) {
//     discountpri = value.test.fee * value.quantity - value.discount;
//     return value.test.fee * value.quantity - value.discount;
//   }

//   double totalPrice() {
//     double totalBill = 0;
//     for (int i = 0; i < _selectedTest.length; i++) {
//       totalBill += afterDiscountTestPrice(_selectedTest[i]);
//     }
//     return totalBill;
//   }

//   void onTestUpdate(Test value) {
//     final int index = _indexOfSelectedIndex(value.testID);
//     if (index >= 0) {
//       _selectedTest[index].quantity = _selectedTest[index].quantity + 1;
//     } else {
//       SelectedTest temp = SelectedTest(test: value, quantity: 1, discount: 0);
//       _selectedTest.add(temp);
//     }

//     notifyListeners();
//   }

//   bool histroyAdded = false;
//   onHistroy(List<SelectedTest> test) {
//     histroyCheck = true;
//     // _selectedTest.add(test);
//     print(histroyAdded);
//     if (histroyAdded == false) {
//       for (int i = 0; i < test.length; i++) {
//         _selectedTest.add(test[i]);
//       }
//     }
//     histroyAdded = true;
//     notifyListeners();
//   }

//   void onQuantityUpdate(String str, Test value) {
//     final int index = _indexOfSelectedIndex(value.testID);
//     int a = int.parse(str);
//     if (a < 1) {
//       _selectedTest[index].quantity = 1;
//     } else {
//       _selectedTest[index].quantity = a;
//     }
//     notifyListeners();
//   }

//   void onDiscountUpdate(String str, Test value) {
//     final int index = _indexOfSelectedIndex(value.testID);
//     double a = double.parse(str);
//     if (discountpri < a) {
//       _selectedTest[index].discount = 0;
//     } else {
//       _selectedTest[index].discount = a;
//     }
//     notifyListeners();
//   }

//   onChanged(bool value) {
//     changedvalue = value;
//     notifyListeners();
//   }

//   int _indexOfSelectedIndex(String testID) {
//     return _selectedTest
//         .indexWhere((SelectedTest element) => element.test.testID == testID);
//   }

//   //getters
//   Department? get department => _department;
//   Doctor? get doctor => _doctor;
//   Patient? get patient => _patient;
//   List<SelectedTest> get selectedTest => _selectedTest;
//   //variables
//   Department? _department;
//   Doctor? _doctor;
//   Patient? _patient;
//   final List<SelectedTest> _selectedTest = <SelectedTest>[];
// }
