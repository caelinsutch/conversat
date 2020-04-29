import 'dart:io';

import 'package:Conversat/components/buttons.dart';
import 'package:Conversat/services/auth.dart';
import 'package:Conversat/services/model.dart';
import 'package:Conversat/shared/actions.dart';
import 'package:Conversat/shared/forms.dart';
import 'package:Conversat/shared/globals.dart';
import 'package:Conversat/shared/validators.dart';
import 'package:Conversat/styles/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _autovalidate = false;
  final _formKey = GlobalKey<FormState>();
  File _image;
  String _uploadedFileUrl;
  AuthService auth = AuthService();

  Map<String, String> updatedUser = {
    'username': '',
    'bio': '',
  };

  @override
  Widget build(BuildContext context) {
    return Consumer2<FirebaseUser, UserPublic>(
        builder: (context, user, userPublic, child) {
      this._uploadedFileUrl = user.photoUrl;
      return Scaffold(
          backgroundColor: AppColors.grey1,
          body: SingleChildScrollView(
            child: Container(
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
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: chooseImage,
                          child: CircleAvatar(
                            backgroundImage:
                                NetworkImage(this._uploadedFileUrl),
                            radius: 40,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        FormFields.genericFormField(
                          context: context,
                          saveFunction: fieldSaveFunction('username'),
                          validatorFunction: Validators.notEmpty,
                          hint: 'Username',
                          minLines: 1,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.multiline,
                          initialValue: userPublic?.username,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        FormFields.genericFormField(
                          context: context,
                          saveFunction: fieldSaveFunction('bio'),
                          validatorFunction: Validators.notEmpty,
                          hint: 'Bio',
                          minLines: 8,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.multiline,
                          initialValue: userPublic?.bio,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        PurpleButton(
                          child: Container(
                            padding: EdgeInsets.all(20),
                            child: Text(
                              'Complete Profile',
                              style: TextStyles.h2White,
                            ),
                          ),
                          onPressed: () async => submitForm(context),
                        )
                      ],
                    )),
              ),
            ),
          ));
    });
  }

  void chooseImage() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image = image;
      });
    });
  }

  Future uploadImage() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('users/${DateTime.now().toString()}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    storageReference.getDownloadURL().then((fileUrl) {
      setState(() {
        _uploadedFileUrl = fileUrl;
      });
    });
  }

  void submitForm(context) async {
    _autovalidate = true;
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      if (_image != null) {
        await uploadImage();
      }
      try {
        await Global.userRef.upsertUserPublic(
            {...updatedUser, 'profilePhoto': _uploadedFileUrl});
        Navigator.pushReplacementNamed(context, '/home');
      } catch (e) {
        FlutterActions.purpleSnackBarTop(context, 'Error submitting form!');
      }
    } else {
      FlutterActions.purpleSnackBarTop(context, 'Form not valid!');
    }
  }

  fieldSaveFunction(String key) {
    return (value) => updatedUser[key] = value;
  }
}
