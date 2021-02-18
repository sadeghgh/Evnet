import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:evnet_agents/screens/object/object_item_screen.dart';
import 'package:evnet_agents/widgets/Customer/your_customers_list.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class YourCusromerScreen extends StatefulWidget {
  static const routeName = '/your-customers';
  void selectObject(BuildContext ctx, Map<String, dynamic> data) {
    Navigator.of(ctx).pushNamed(
      ObjectItemScreen.routeName,
      arguments: data,
    );
  }

  @override
  _YourCusromerScreenState createState() => _YourCusromerScreenState();
}

class _YourCusromerScreenState extends State<YourCusromerScreen> {
  final currentUserUid = FirebaseAuth.instance.currentUser.uid;
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final appBarColor = routeArgs['color'];
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text("Your Customers screen"),
        backgroundColor: appBarColor,
        // backgroundColor: Color(0xFF00695C),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Agents')
            .doc(currentUserUid)
            .collection('Customers')
            .orderBy(
              'startTime',
              descending: true,
            )
            .snapshots(),
        builder: (ctx, AsyncSnapshot<QuerySnapshot> objectsSnapsshot) {
          if (objectsSnapsshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final customerstDocs = objectsSnapsshot.data.docs;
          // testId = agentDocs[0].id.toString();
          return Container(
            child: ListView.builder(
                reverse: false,
                itemCount: customerstDocs.length,
                itemBuilder: (ctx, index) => YourCustomersListTile(
                      customerstDocs[index].data(),
                    )),
          );
        },
      ),
    );
  }
}
