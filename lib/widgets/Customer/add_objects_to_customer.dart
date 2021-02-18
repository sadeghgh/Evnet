import 'package:flutter/material.dart';
import 'package:evnet_agents/screens/object/object_item_screen.dart';

class AddObjectsToCustomerList extends StatefulWidget {
  final Map<String, dynamic> data;

  AddObjectsToCustomerList(this.data);

  // void selectCustomer(BuildContext ctx, Map<String, dynamic> data) {
  //   Navigator.of(ctx).pushNamed(
  //     ObjectItemScreen.routeName,
  //     arguments: data,
  //   );
  // }

  @override
  _AddObjectsToCustomerListState createState() =>
      _AddObjectsToCustomerListState();
}

class _AddObjectsToCustomerListState extends State<AddObjectsToCustomerList> {
  @override
  Widget build(BuildContext context) {
    bool _isChecked = false;

    return Card(
      child: CheckboxListTile(
        title: Text(widget.data['title']),
        subtitle: Text(widget.data['adress']),
        secondary: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey,
          backgroundImage: NetworkImage(widget.data['image_urls'][0]),
        ),
        value: _isChecked,
        onChanged: (bool value) {
          setState(() {
            _isChecked = value;
          });
        },
      ),
    );
  }
}
