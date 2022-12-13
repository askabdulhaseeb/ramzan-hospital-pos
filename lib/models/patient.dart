

import '../function/time_date_function.dart';

class Patient {


  factory Patient.fromDocument2(Map<String, dynamic> doc) {
    return Patient(
      patientID: doc['patient_id'] ?? 'null',
      name: doc['name'] ?? 'null',
      phoneNumber: doc['phone_number'] ?? 'null',
      area: doc['area'] ?? 'null',
      address: doc['address'] ?? 'null',
      gender: doc['gender'] ?? 'null',
      dob: doc['date_of_birth'] ?? 'null',
      
      timestamp: doc['timestamp'] ?? 0,
    );
  }
  const Patient({
    required this.patientID,
    required this.name,
    required this.phoneNumber,
    required this.area,
    required this.address,
    required this.gender,
    required this.dob,
   
    this.timestamp,
  });
  final String patientID;
  final String name;
  final String phoneNumber;
  final String area;
  final String address;
  final String gender;
  final int dob;
  
  final int? timestamp;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'patient_id': patientID,
        'name': name,
        'phone_number': phoneNumber,
        'area': area,
        'address': address,
        'date_of_birth': dob,
        'gender': gender,
       
        'timestamp': TimeStamp.timestamp,
      };
}
