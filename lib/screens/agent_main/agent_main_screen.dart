import 'package:flutter/material.dart';

import '../../widgets/agent_main/main_meny_data.dart';
import '../../widgets/agent_main/main_meny_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AgentMainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text("Main Meny"),
        backgroundColor: Color(0xFF00695C),
        actions: [
          DropdownButton(
            dropdownColor: Color(0xFF00695C).withOpacity(0.5),
            underline: Container(),
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem(
                child: Container(
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(10),
                  //   color: Colors.blue,
                  // ),
                  child: Row(
                    children: <Widget>[
                      const Icon(Icons.exit_to_app),
                      SizedBox(width: 8),
                      Text(
                        AppLocalizations.of(context).logout,
                        style: TextStyle(
                          color: Colors.black,
                          // backgroundColor: Colors.green
                        ),
                      ),
                    ],
                  ),
                ),
                value: 'logout',
              ),
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          ),
        ],
      ),
      body: GridView(
        padding: const EdgeInsets.all(25),
        children: MAIN_MENY_DATA
            .map(
              (catData) => MainMentItem(catData.id, catData.title,
                  catData.color, catData.nextPage, catData.imagePath),
            )
            .toList(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
      ),
    );
  }
}
