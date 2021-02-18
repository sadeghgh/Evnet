import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:evnet_agents/widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(
    String email,
    String password,
    String username,
    PickedFile image,
    bool isLogin,
    String taxNr,
    String companyName,
    String adress,
    String phoneNr,
    String rentalLegalInfo,
    String saleLegalInfo,
    BuildContext ctx,
  ) async {
    UserCredential authResult;

    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        final ref = FirebaseStorage.instance
            .ref()
            .child('agent_images')
            .child(authResult.user.uid)
            .child(authResult.user.uid + '-logo.jpg');

        await ref.putFile(File(image.path)).onComplete;

        final url = await ref.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('Agents')
            .doc(authResult.user.uid)
            .set({
          'username': username,
          'email': email,
          'image_url': url,
          'taxNr': taxNr,
          'companyName': companyName,
          'adress': adress,
          'phoneNr': phoneNr,
          'startTime': Timestamp.fromDate(DateTime.now()),
          'rentalLegalInfo': rentalLegalInfo,
          'saleLegalInfo': saleLegalInfo,
        });
      }
    } on PlatformException catch (err) {
      var message = 'An error occurred, pelase check your credentials!';

      if (err.message != null) {
        message = err.message;
      }

      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print(err);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text("Auth screen"),
        backgroundColor: Color(0xFF00695C),
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          // color: Colors.white,
        ),
        child: AuthForm(
          _submitAuthForm,
          _isLoading,
        ),
      ),
    );
  }
}
