import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/services.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evnet_agents/widgets/object/object_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ObjectItemScreen extends StatelessWidget {
  static const routeName = '/object-item';

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final Map data = routeArgs;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(data['title']),
        backgroundColor: Color(0xFF00695C),
      ),
      body: ObjectItem(data),
    );
  }
}
