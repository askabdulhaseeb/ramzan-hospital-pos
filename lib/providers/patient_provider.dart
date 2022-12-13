import 'package:flutter/cupertino.dart';

import '../database/patient_api.dart';

import '../models/patient.dart';

class PatientProvider with ChangeNotifier {
  PatientProvider() {
    _load();
  }
  List<Patient> _patient = <Patient>[];
  List<Patient> get patient => _patient;
  String? _search;
  Future<void> _load() async {
    _patient = await PatientAPI().getPatient();
    notifyListeners();
  }

  onSearch(String? value) {
    _search = value;
    notifyListeners();
  }

  List<Patient> patientSearch() {
    final List<Patient> temp = <Patient>[];
    for (Patient element in _patient) {
      if (_search == null || (_search?.isEmpty ?? true)) {
        temp.add(element);
      } else if (element.name
          .toLowerCase()
          .startsWith((_search?.toLowerCase() ?? ''))) {
        temp.add(element);
      }
    }
    return temp;
  }

  Future<String> add(Patient value) async {
    _patient.insert(0, value);
    notifyListeners();
    return await PatientAPI().add(value);
  }

  void updatePatientScreen() {
    print(addPatiernt);
    addPatiernt = true;
    notifyListeners();
  }

  void selectPatient(Patient value) {
    _selectedPatient = value;
    notifyListeners();
  }

  bool addPatiernt = false;

  Patient _selectedPatient = Patient(
      patientID: '1',
      name: 'unknown',
      phoneNumber: 'unknown',
      address: 'unknown');
  Patient get selectedpatient => _selectedPatient;
}
