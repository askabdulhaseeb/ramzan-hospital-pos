import 'package:firedart/firedart.dart';
import '../models/patient.dart';


class PatientAPI {
  CollectionReference collection = Firestore.instance.collection('patients');

  Future<String> add(Patient patient) async {
    String res = 'start';
    try {
      await collection.document(patient.patientID).set(patient.toJson());
      res = 'Success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<List<Patient>> getPatient() async {
    List<Patient> patient = <Patient>[];
    List<Document> lis =
        (await collection.orderBy('timestamp', descending: true).get());
    for (int i = 0; i < lis.length; i++) {
      patient.add(Patient.fromDocument2(lis[i].map));
    }
    return patient;
  }
}