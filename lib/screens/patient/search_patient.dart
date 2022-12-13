import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/patient.dart';
import '../../providers/patient_provider.dart';

class PatientSearchUi extends StatelessWidget {
  const PatientSearchUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PatientProvider>(
        builder: (BuildContext context, PatientProvider patPro, _) {
      final List<Patient> patient = patPro.patientSearch();
      return Column(children: <Widget>[
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Container(
            height: 40,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              color: Theme.of(context).cardColor,
            ),
            child: const Center(child: Text('patient')),
          ),
        ),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: const Color.fromARGB(255, 66, 66, 66).withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: TextField(
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search...'),
              onChanged: (String val) => patPro.onSearch(val),
            ),
          ),
        ),
        const SizedBox(height: 15),
        RichText(
            text: TextSpan(
          text: '+ Add Patient',
          style: const TextStyle(color: Colors.white, fontSize: 18),
          // recognizer: TapGestureRecognizer()
          //   ..onTap = () {
          //     slipPro.onChanged(true);
          //   },
        )),
        // const ForText(
        //   name: '+ Add Patient',
        //   fontsize: 18,
        //   isbold: false,
        //   color: Colors.white,
        // ),
        const SizedBox(height: 20),
        patPro.patient.isEmpty
            ? const Center(
                child: Text('NO patient'),
              )
            : SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: patient.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: ListTile(
                            onTap: () {
                              // slipPro.onPatientUpdate(patient[index]);
                              // slipPro.onChanged(false);
                            },
                            title: Text(
                              patient[index].name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              patient[index].phoneNumber,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      );
                    }),
              )
      ]);
    });
  }
}
