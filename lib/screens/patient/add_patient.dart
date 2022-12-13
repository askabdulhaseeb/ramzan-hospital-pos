import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:uuid/uuid.dart';

import '../../function/time_date_function.dart';
import '../../models/patient.dart';
import '../../providers/patient_provider.dart';
import '../../utilities/custom_validator.dart';
import '../../widgets/custom_widgets/custom_textformfield.dart';
import '../../widgets/custom_widgets/custom_toast.dart';



class AddPatientUi extends StatefulWidget {
  const AddPatientUi({super.key});

  @override
  State<AddPatientUi> createState() => _AddPatientUiState();
}

class _AddPatientUiState extends State<AddPatientUi> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phoneno = TextEditingController();
  final TextEditingController _area = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final String uuid = const Uuid().v4();
  bool _isloading = false;
  String select = 'Male';
  List<String> gender = <String>['Male', 'Female'];
  void uploadpatient() async {
    setState(() {
      _isloading = true;
    });
    final Patient patient = Patient(
        dob: _dateTime.microsecondsSinceEpoch,
        patientID: uuid,
        name: _name.text.trim(),
        phoneNumber: _phoneno.text.trim(),
        area: _area.text.trim(),
        address: _address.text.trim(),
        timestamp: TimeStamp.timestamp,
        gender: select);
    final String added =
        await Provider.of<PatientProvider>(context, listen: false).add(patient);
    if (mounted) {
      if (added == 'Success') {
        CustomToast.successSnackBar(
            context: context, text: 'Patient Added Succesfully');
        _name.clear();
        _phoneno.clear();
        _area.clear();
        _address.clear();
      } else {
        CustomToast.errorSnackBar(context: context, text: added);
      }

      setState(() {
        _isloading = false;
      });
    }
  }

  DateTime _dateTime = DateTime.now();
  Future<void> _showDatePicker(BuildContext context) async {
    await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ).then((DateTime? value) {
      if (mounted) {
        setState(() {
          _dateTime = value!;
        });
      }
    });
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
                validator: (String? value) =>
                    CustomValidator.lessThen4(value),
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: _area,
                hint: 'area',
                validator: (String? value) => CustomValidator.lessThen3(value),
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: _address,
                hint: 'address',
                validator: (String? value) => CustomValidator.lessThen3(value),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    addRadioButton(0, 'Male'),
                    addRadioButton(1, 'female'),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  const Text('Date Of Birth'),
                  SizedBox(
                    width: 150,
                    height: 30,
                    child: Center(
                      child: Text(
                          '''${_dateTime.day} / ${_dateTime.month} / ${_dateTime.year}'''),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () => _showDatePicker(context),
                      child: const Text(
                        'Date Pick',
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
              const SizedBox(height: 30),
              _isloading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () {
                        final bool isvalidform =
                            _formkey.currentState!.validate();
                        if (isvalidform) {
                          uploadpatient();
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

  addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        // ignore: always_specify_types
        Radio(
            activeColor: Theme.of(context).primaryColor,
            value: gender[btnValue],
            groupValue: select,
            onChanged: (String? value) {
              setState(() {
                select = value!;
              });
            }),
        Text(title),
      ],
    );
  }
}
