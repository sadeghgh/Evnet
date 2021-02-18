import 'package:flutter/material.dart';
import 'package:evnet_agents/screens/object/object_item_screen.dart';

class YourObjectsListTile extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String adress;
  final Map<String, dynamic> data;

  YourObjectsListTile(this.imageUrl, this.title, this.adress, this.data);

  void selectObject(BuildContext ctx, Map<String, dynamic> data) {
    Navigator.of(ctx).pushNamed(
      ObjectItemScreen.routeName,
      arguments: data,
    );
  }

  @override
  _YourObjectsListTileState createState() => _YourObjectsListTileState();
}

class _YourObjectsListTileState extends State<YourObjectsListTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        // shape: ShapeBorder.lerp(3, 5, 7),
        // contentPadding: const EdgeInsets.all(1),
        // tileColor: Colors.amber,
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey,
          backgroundImage: NetworkImage(widget.imageUrl),
        ),
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          widget.adress,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        trailing: Icon(
          Icons.navigate_next_sharp,
          size: 50,
          color: Theme.of(context).accentColor,
        ),
        isThreeLine: true,
        dense: false,
        onTap: () => widget.selectObject(context, widget.data),
      ),
    );
  }
}
