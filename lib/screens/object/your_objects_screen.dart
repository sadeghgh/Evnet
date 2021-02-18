import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:evnet_agents/screens/object/object_item_screen.dart';
import 'package:evnet_agents/widgets/object/your_objects_list.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class YourObjectsScreen extends StatefulWidget {
  static const routeName = '/your-objects';
  void selectObject(BuildContext ctx, Map<String, dynamic> data) {
    Navigator.of(ctx).pushNamed(
      ObjectItemScreen.routeName,
      arguments: data,
    );
  }

  @override
  _YourObjectsScreenState createState() => _YourObjectsScreenState();
}

class _YourObjectsScreenState extends State<YourObjectsScreen> {
  final currentUserUid = FirebaseAuth.instance.currentUser.uid;
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final appBarColor = routeArgs['color'];
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text("Your Objects screen"),
        backgroundColor: appBarColor,
        // backgroundColor: Color(0xFF00695C),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Agents')
            .doc(currentUserUid)
            .collection('Objects')
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
          final objectDocs = objectsSnapsshot.data.docs;
          // testId = agentDocs[0].id.toString();
          return Container(
            child: ListView.builder(
                reverse: false,
                itemCount: objectDocs.length,
                itemBuilder: (ctx, index) => YourObjectsListTile(
                      objectDocs[index].data()['image_urls'][0],
                      objectDocs[index].data()["title"],
                      objectDocs[index].data()["adress"],
                      objectDocs[index].data(),
                    )),
          );
        },
      ),
    );
  }
}
