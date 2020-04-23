import 'package:Conversat/components/buttons.dart';
import 'package:Conversat/services/auth.dart';
import 'package:Conversat/shared/forms.dart';
import 'package:Conversat/shared/validators.dart';
import 'package:Conversat/styles/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _autovalidate = false;
  final _formKey = GlobalKey<FormState>();
  AuthService auth = AuthService();

  Map<String, String> user = {
    'userName': '',
    'bio': '',
  };

  @override
  Widget build(BuildContext context) {
    return Consumer<FirebaseUser>(
      builder: (context, user, child) {
        return  Scaffold(
            backgroundColor: AppColors.grey1,
            body: Container(
              padding: EdgeInsets.all(20),
              child: Center(
                child: Form(
                    autovalidate: _autovalidate,
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Finish Signup',
                          style: TextStyles.h1Primary,
                        ),
                        SizedBox(height: 20,),
                        FormFields.genericFormField(context, fieldSaveFunction('userName'), Validators.generic, 'Username'),
                        SizedBox(height: 20,),
                        FormFields.genericFormField(
                          context,
                          fieldSaveFunction('bio'),
                          Validators.notEmpty,
                          'Bio',
                          minLines: 8,
                          keyboardType: TextInputType.multiline,
                        ),
                        SizedBox(height: 20,),
                        PurpleButton(
                          child: Container(
                            padding: EdgeInsets.all(20),

                            child: Text(
                                'Complete Profile',
                              style: TextStyles.h2White,
                            ),
                          ),
                          onPressed: () async => submitForm(context),)
                      ],
                    )
                ),
              ),
            )
        );
      }
    );
  }

  void submitForm(context) async {

  }

  fieldSaveFunction(String key) {
    return (value) => user[key] = value;
  }
}
