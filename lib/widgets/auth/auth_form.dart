import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../pickers/user_image_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthForm extends StatefulWidget {
  AuthForm(
    this.submitFn,
    this.isLoading,
  );

  final bool isLoading;
  final void Function(
    String email,
    String password,
    String userName,
    PickedFile image,
    bool isLogin,
    String taxNr,
    String companyName,
    String adresss,
    String phoneNr,
    String rentalLegalInfo,
    String saleLegalInfo,
    BuildContext ctx,
  ) submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _isForgottPsw = false;
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';
  var _taxNr = '';
  var _companyName = '';
  var _adress = '';
  var _phoneNr = '';
  var _rentalLegalInfo = '';
  var _saleLegalInfo = '';
  PickedFile _userImageFile;

  void _pickedImage(PickedFile image) {
    _userImageFile = image;
  }

  final _auth = FirebaseAuth.instance;
  @override
  void resetPassword() async {
    _formKey.currentState.save();
    await _auth.sendPasswordResetEmail(email: _userEmail.trim());
    setState(() {
      _isForgottPsw = false;
      _isLogin = true;
    });
  }

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (_userImageFile == null && !_isLogin) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).pickImageWarningMessage),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }

    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(
        _userEmail.trim(),
        _userPassword.trim(),
        _userName.trim(),
        _userImageFile,
        _isLogin,
        _taxNr.trim(),
        _companyName.trim(),
        _adress,
        _phoneNr,
        _rentalLegalInfo,
        _saleLegalInfo,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (!_isLogin) UserImagePicker(_pickedImage),
                  TextFormField(
                    key: ValueKey('email'),
                    autocorrect: false,
                    textCapitalization: TextCapitalization.none,
                    enableSuggestions: false,
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return AppLocalizations.of(context)
                            .emailAdressWarningMsg;
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context).emailAdressLable,
                    ),
                    onSaved: (value) {
                      _userEmail = value;
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('username'),
                      autocorrect: true,
                      textCapitalization: TextCapitalization.words,
                      enableSuggestions: false,
                      validator: (value) {
                        if (value.isEmpty || value.length < 4) {
                          return 'Please enter at least 4 characters';
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'Username'),
                      onSaved: (value) {
                        _userName = value;
                      },
                    ),
                  if (!_isForgottPsw)
                    TextFormField(
                      key: ValueKey('password'),
                      validator: (value) {
                        if (value.isEmpty || value.length < 7) {
                          return 'Password must be at least 7 characters long.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      onSaved: (value) {
                        _userPassword = value;
                      },
                    ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('companyName'),
                      decoration:
                          InputDecoration(labelText: 'Your Company name'),
                      obscureText: false,
                      onSaved: (value) {
                        _companyName = value;
                      },
                    ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('taxNr'),
                      decoration:
                          InputDecoration(labelText: 'Your Company Tax number'),
                      obscureText: false,
                      onSaved: (value) {
                        _taxNr = value;
                      },
                    ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('adress'),
                      decoration: InputDecoration(labelText: 'Adress'),
                      obscureText: false,
                      onSaved: (value) {
                        _adress = value;
                      },
                    ),
                  if (!_isLogin)
                    IntlPhoneField(
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context).phoneNr,
                        // border: OutlineInputBorder(
                        //   borderSide: BorderSide(),
                        // ),
                      ),
                      initialCountryCode: 'TR',
                      onSaved: (value) {
                        _phoneNr = value.completeNumber;
                      },
                    ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('legal information rental'),
                      keyboardType: TextInputType.multiline,
                      maxLines: 8,
                      maxLength: 1000,
                      autocorrect: true,
                      textCapitalization: TextCapitalization.words,
                      enableSuggestions: false,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter legal terms for rental properties';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Legal information rental'),
                      onSaved: (value) {
                        _rentalLegalInfo = value;
                      },
                    ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('legal information sale'),
                      keyboardType: TextInputType.multiline,
                      maxLines: 8,
                      maxLength: 1000,
                      autocorrect: true,
                      textCapitalization: TextCapitalization.words,
                      enableSuggestions: false,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter legal terms for sale properties';
                        }
                        return null;
                      },
                      decoration:
                          InputDecoration(labelText: 'Legal information sale'),
                      onSaved: (value) {
                        _saleLegalInfo = value;
                      },
                    ),
                  SizedBox(height: 12),
                  if (widget.isLoading) CircularProgressIndicator(),
                  if (!widget.isLoading)
                    if (!_isForgottPsw)
                      RaisedButton(
                        child: Text(_isLogin
                            ? AppLocalizations.of(context).login
                            : AppLocalizations.of(context).signup),
                        onPressed: _trySubmit,
                      ),
                  if (!widget.isLoading)
                    if (!_isForgottPsw)
                      FlatButton(
                        textColor: Theme.of(context).primaryColor,
                        child: Text(_isLogin
                            ? AppLocalizations.of(context).createAccount
                            : AppLocalizations.of(context).haveAccount),
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                            _isForgottPsw = false;
                          });
                        },
                      ),
                  if (!widget.isLoading)
                    if ((_isLogin) && (!_isForgottPsw))
                      FlatButton(
                        textColor: Theme.of(context).primaryColor,
                        child: Text(AppLocalizations.of(context).forgottPsw),
                        onPressed: () {
                          setState(() {
                            _isForgottPsw = !_isForgottPsw;
                          });
                        },
                      ),
                  if (_isForgottPsw)
                    RaisedButton(
                      child: Text("Reset Password"),
                      onPressed: resetPassword,
                    ),
                  if (_isForgottPsw)
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      child: Text("Back to login"),
                      onPressed: () {
                        setState(() {
                          _isForgottPsw = !_isForgottPsw;
                          _isLogin = true;
                        });
                      },
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
