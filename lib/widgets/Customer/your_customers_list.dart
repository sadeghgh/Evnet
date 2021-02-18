import 'package:flutter/material.dart';
import 'package:evnet_agents/screens/object/object_item_screen.dart';

class YourCustomersListTile extends StatefulWidget {
  final Map<String, dynamic> data;

  YourCustomersListTile(this.data);

  void selectCustomer(BuildContext ctx, Map<String, dynamic> data) {
    Navigator.of(ctx).pushNamed(
      ObjectItemScreen.routeName,
      arguments: data,
    );
  }

  @override
  _YourCustomersListTileState createState() => _YourCustomersListTileState();
}

class _YourCustomersListTileState extends State<YourCustomersListTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: widget.data['customerName'] != null
                ? Text(
                    widget.data['customerName'],
                    style: Theme.of(context).textTheme.headline6,
                  )
                : Text('Not added'),
          ),
          widget.data['phoneNr'] != null
              ? Text(
                  widget.data['phoneNr'],
                  style: Theme.of(context).textTheme.bodyText2,
                )
              : Text('Not added'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FlatButton(
                child: Text("Se or modify Properties"),
                onPressed: () => {},
              ),
              FlatButton(
                child: Text("Add Properties"),
                onPressed: () => {},
              ),
            ],
          )
        ],
      ),
    );
  }
}
