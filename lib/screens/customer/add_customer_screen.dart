import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evnet_agents/widgets/customer/add_customer_form.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddCustomerScreen extends StatefulWidget {
  static const routeName = '/add-customer';
  @override
  _AddCustomerScreenState createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
  final _auth = FirebaseAuth.instance;

  var _isLoading = false;

  void _submitAuthForm(
    String saleOrRental,
    String email,
    String customerName,
    String phoneNr,
    BuildContext ctx,
  ) async {
    String currentUserUid;

    try {
      setState(() {
        _isLoading = true;
      });
      // final ref = FirebaseStorage.instance
      //     .ref()
      //     .child('agent_images')
      //     .child(authResult.user.uid)
      //     .child(authResult.user.uid + '-logo.jpg');

      // await ref.putFile(File(image.path)).onComplete;

      // final url = await ref.getDownloadURL();

      currentUserUid = _auth.currentUser.uid;
      DocumentReference ds = await FirebaseFirestore.instance
          .collection('Agents')
          .doc(currentUserUid)
          .collection('Customers')
          .add({
        'customerName': customerName,
        'email': email,
        'phoneNr': phoneNr,
        'saleOrRental': saleOrRental,
        'startTime': Timestamp.fromDate(DateTime.now()),
      });

      if (ds != null) {
        Scaffold.of(ctx).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context).pickImageWarningMessage),
            backgroundColor: Theme.of(context).accentColor,
            duration: const Duration(seconds: 5),
          ),
        );
        // return;
        setState(() {
          _isLoading = false;
        });
      }
    } on PlatformException catch (err) {
      var message = AppLocalizations.of(context).connectionErrorMsg;

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
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final appBarColor = routeArgs['color'];
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).addCustomer),
        backgroundColor: appBarColor,
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          // color: Colors.white,
        ),
        child: AddCustomerForm(
          _submitAuthForm,
          _isLoading,
        ),
      ),
    );
  }
}
