

import '../function/time_date_function.dart';

class Patient {


  factory Patient.fromDocument2(Map<String, dynamic> doc) {
    return Patient(
      patientID: doc['patient_id'] ?? 'null',
      name: doc['name'] ?? 'null',
      phoneNumber: doc['phone_number'] ?? 'null',
      
      address: doc['address'] ?? 'null',
    
      
      timestamp: doc['timestamp'] ?? 0,
    );
  }
  const Patient({
    required this.patientID,
    required this.name,
    required this.phoneNumber,
   
    required this.address,
  
   
    this.timestamp,
  });
  final String patientID;
  final String name;
  final String phoneNumber;

  final String address;

  
  final int? timestamp;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'patient_id': patientID,
        'name': name,
        'phone_number': phoneNumber,
    
        'address': address,
      
       
        'timestamp': TimeStamp.timestamp,
      };
}
