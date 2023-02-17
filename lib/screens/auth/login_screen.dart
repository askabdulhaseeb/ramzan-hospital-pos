import 'package:firedart/auth/user_gateway.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';

import '../../database/user_api.dart';
import '../../models/app_user.dart';
import '../../utilities/custom_validator.dart';
import '../../widgets/custom_widgets/custom_border_widget.dart';
import '../../widgets/custom_widgets/custom_label_widget.dart';
import '../../widgets/custom_widgets/custom_textform_field.dart';
import '../../widgets/custom_widgets/loader.dart';
import '../../widgets/custom_widgets/password_textformfield.dart';
import '../sale_screen/sale_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  static const String routeName = '/sign-in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool isLoading = false;
  bool isError = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: FittedBox(
                        child: Text(
                          'Welcome Back!',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    'Login with your Ramzan clinic email and password',
                    style: TextStyle(color: Colors.grey),
                  ),
                  RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodySmall,
                      children: const <TextSpan>[
                        TextSpan(
                          text: 'Developed By: ',
                          style: TextStyle(color: Colors.grey),
                        ),
                        TextSpan(
                          text: ' Dev',
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                        TextSpan(
                          text: 'Markaz',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 1,
            height: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 32),
            color: Colors.grey.shade300,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Form(
                key: _key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Sign In!',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    CustomBorderWidget(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          CustomLableTextFormField(
                            lable: 'Email',
                            hint: 'you@ramzanclinic.com',
                            validator: (value) => CustomValidator.email(value),
                            controller: _email,
                          ),
                          const Divider(),
                          CustomLableWidget(
                            lable: 'Password',
                            child: PasswordTextFormField(controller: _password),
                          ),
                          SizedBox(
                            height: isError ? null : 8,
                            child: isError
                                ? const Text(
                                    'Invalid Password',
                                    style: TextStyle(color: Colors.red),
                                  )
                                : null,
                          ),
                          isLoading
                              ? const Loader()
                              : ElevatedButton(
                                  onPressed: () async {
                                    if (!_key.currentState!.validate()) return;
                                    setState(() {
                                      isLoading = true;
                                    });
                                    try {
                                      final FirebaseAuth auth =
                                          FirebaseAuth.instance;
                                      final User user = await auth.signIn(
                                          _email.text, _password.text);
                                      final AppUser appUser =
                                          await UserAPI().user(user.id);

                                      if (!mounted) return;
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                              SaleScreen.routeName);
                                    } catch (e) {
                                      setState(() {
                                        isError = true;
                                        isLoading = false;
                                      });
                                    }
                                  },
                                  style: ButtonStyle(
                                    iconColor:
                                        MaterialStateProperty.all(Colors.white),
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.blue),
                                    padding: MaterialStateProperty.all(
                                      const EdgeInsets.symmetric(
                                          vertical: 16, horizontal: 32),
                                    ),
                                    textStyle: MaterialStateProperty.all(
                                      const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  child: const Text(
                                    'Sign In',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
