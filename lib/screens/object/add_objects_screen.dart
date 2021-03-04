import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:evnet_agents/widgets/object/add_object_form.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:evnet_agents/helpers/genRandomNumber_helper.dart';

class AddObjectScreen extends StatefulWidget {
  static const routeName = '/add-objects';
  @override
  _AddObjectScreenState createState() => _AddObjectScreenState();
}

class _AddObjectScreenState extends State<AddObjectScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;
  static int imagNr = 0;

  void _submitAuthForm(
    String title,
    String type,
    String saleOrRent,
    List<File> images,
    String description,
    String floor,
    String adress,
    String city,
    String postalCode,
    String district,
    GeoPoint location,
    String size,
    String amountRooms,
    String price,
    String age,
    bool pool,
    BuildContext ctx,
  ) async {
    String currentUserUid;
    try {
      setState(() {
        _isLoading = true;
      });
      currentUserUid = await _auth.currentUser.uid;

      String random6DigitNumberStr = GenRandomNumberHelper.randomDigits();

      DocumentReference firestoreRef = await FirebaseFirestore.instance
          .collection('Agents')
          .doc(currentUserUid)
          .collection('Objects')
          .add({
        'objectNr': random6DigitNumberStr,
        'title': title,
        'type': type,
        'saleOrRental': saleOrRent,
        'desccription': description,
        'floor': floor,
        'adress': adress,
        'city': city,
        'district': district,
        'postalCode': postalCode,
        'location': location,
        'size': size,
        'amountRooms': amountRooms,
        'price': price,
        'age': age,
        'pool': pool,
        'startTime': Timestamp.fromDate(DateTime.now()),
      });

      if (firestoreRef != null) {
        Scaffold.of(ctx).showSnackBar(
          SnackBar(
            content:
                Text(AppLocalizations.of(context).propertyAddedSuccesfully),
            backgroundColor: Theme.of(context).accentColor,
            duration: const Duration(seconds: 5),
          ),
        );
        // return;
        setState(() {
          _isLoading = false;
        });
      }
      var urls = <dynamic>[];
      for (final element in images) {
        imagNr++;
        final ref = FirebaseStorage.instance
            .ref()
            .child('agent_images')
            .child("objects")
            .child(firestoreRef.id)
            .child(firestoreRef.id + imagNr.toString() + '.jpg');
        // String filePath =
        //     await FlutterAbsolutePath.getAbsolutePath(element.identifier);
        await ref.putFile(element);

        final url = await ref.getDownloadURL();
        urls.add(url);
      }

      await FirebaseFirestore.instance
          .collection('Agents')
          .doc(currentUserUid)
          .collection('Objects')
          .doc(firestoreRef.id)
          .update({
        'image_urls': urls,
      });
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

      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(err),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final appBarColor = routeArgs['color'];
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text("Auth screen"),
        backgroundColor: appBarColor,
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          // color: Colors.white,
        ),
        child: AddObjectForm(
          _submitAuthForm,
          _isLoading,
        ),
      ),
    );
  }
}
