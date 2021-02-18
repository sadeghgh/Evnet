import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AgentScreen extends StatelessWidget {
  var testId = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Agents')
            .orderBy(
              'startTime',
              descending: true,
            )
            .snapshots(),
        builder: (ctx, AsyncSnapshot<QuerySnapshot> agentSnapsshot) {
          if (agentSnapsshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final agentDocs = agentSnapsshot.data.docs;
          testId = agentDocs[0].id.toString();
          return Container(
            child: ListView.builder(
              reverse: false,
              itemCount: agentDocs.length,
              itemBuilder: (ctx, index) => Container(
                child: Text(
                  agentDocs[index].data().toString(),
                  textAlign: TextAlign.center,
                ),
                padding: const EdgeInsets.all(8),
                key: ValueKey(agentDocs[index].id),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('Agents')
              .doc(testId)
              .collection('Customers')
              .add({'name': 'CustomerByCode6'});
        },
      ),
    );
  }
}
