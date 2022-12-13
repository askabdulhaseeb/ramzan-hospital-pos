import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:uuid/uuid.dart';

import '../../function/time_date_function.dart';
import '../../models/patient.dart';
import '../../providers/patient_provider.dart';
import '../../utilities/custom_validator.dart';
import '../custom_widgets/custom_textformfield.dart';
import '../custom_widgets/custom_toast.dart';

class AddPatientUi extends StatefulWidget {
  const AddPatientUi({super.key});

  @override
  State<AddPatientUi> createState() => _AddPatientUiState();
}

class _AddPatientUiState extends State<AddPatientUi> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phoneno = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final String uuid = const Uuid().v4();
  bool _isloading = false;

  void uploadpatient() async {
    setState(() {
      _isloading = true;
    });
    final Patient patient = Patient(
      patientID: uuid,
      name: _name.text.trim(),
      phoneNumber: _phoneno.text.trim(),
      address: _address.text.trim(),
      timestamp: TimeStamp.timestamp,
    );
    final String added =
        await Provider.of<PatientProvider>(context, listen: false).add(patient);
    if (mounted) {
      if (added == 'Success') {
        CustomToast.successSnackBar(
            context: context, text: 'Patient Added Succesfully');
        _name.clear();
        _phoneno.clear();

        _address.clear();
      } else {
        CustomToast.errorSnackBar(context: context, text: added);
      }

      setState(() {
        _isloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _formkey,
      child: Padding(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text('Add patient'),
                IconButton(
                    onPressed: () {
                      //slipPro.onChanged(false);
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.clear,
                      color: Colors.red,
                    )),
              ],
            ),
            const SizedBox(height: 30),
            CustomTextFormField(
              controller: _name,
              hint: 'name',
              validator: (String? value) => CustomValidator.lessThen4(value),
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
              controller: _phoneno,
              hint: 'Phone Number',
              validator: (String? value) => CustomValidator.lessThen4(value),
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
              controller: _address,
              hint: 'address',
              validator: (String? value) => CustomValidator.lessThen3(value),
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 30),
            _isloading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      final bool isvalidform =
                          _formkey.currentState!.validate();
                      if (isvalidform) {
                        uploadpatient();
                        Navigator.of(context).pop();
                        // slipPro.onChanged(false);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        fixedSize: const Size(100, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50))),
                    child: const Text(
                      'Add',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
