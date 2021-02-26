import 'package:flutter/material.dart';
import 'package:evnet_agents/screens/object/object_item_screen.dart';

class YourObjectsListTile extends StatefulWidget {
  final Map<String, dynamic> data;

  YourObjectsListTile(this.data);

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
      elevation: 4.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            // shape: ShapeBorder.lerp(3, 5, 7),
            // contentPadding: const EdgeInsets.all(1),
            // tileColor: Colors.amber,
            leading: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              child: widget.data['image_urls'] != null
                  ? Image.network(
                      widget.data['image_urls'][0],
                      fit: BoxFit.cover,
                      width: 80.0,
                      height: 80.0,
                    )
                  : Image.asset('assets/images/evnet-noimage.jpg'),
            ),
            title: Text(
              widget.data['title'] != null ? widget.data['title'] : 'Not added',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.pin_drop_sharp,
                        color: Theme.of(context).accentColor,
                        size: 20,
                      ),
                      Text(
                        widget.data['city'] != null
                            ? widget.data['city']
                            : 'Not added',
                        style: Theme.of(context).textTheme.bodyText2,
                        textScaleFactor: 0.8,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      widget.data['price'] != null
                          ? widget.data['price'] + ' TL'
                          : 'Not added',
                      style: Theme.of(context).textTheme.subtitle2,
                      textScaleFactor: 0.9,
                    ),
                  ),
                ],
              ),
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
          Card(
            elevation: 8.0,
            child: Container(
              color: Color(0xFFC8E6C9),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.data['size'] != null
                          ? widget.data['size'] + " m²"
                          : 'Not added',
                      style: Theme.of(context).textTheme.bodyText2,
                      // textScaleFactor: 0.8,
                    ),
                    Text(
                      ((widget.data['size'] != null) &&
                              (widget.data['price'] != null))
                          ? (num.parse(widget.data['price']) /
                                      num.parse(widget.data['size']))
                                  .toStringAsFixed(0) +
                              " TL / m²"
                          : 'Not added',
                      style: Theme.of(context).textTheme.bodyText2,
                      // textScaleFactor: 0.8,
                    ),
                    Text(
                      widget.data['amountRooms'] != null
                          ? widget.data['amountRooms']
                          : 'Not added',
                      style: Theme.of(context).textTheme.bodyText2,
                      // textScaleFactor: 0.8,
                    ),
                    Text(
                      widget.data['objectNr'] != null
                          ? 'Nr: ' + widget.data['objectNr']
                          : 'Not added',
                      style: Theme.of(context).textTheme.bodyText2,
                      // textScaleFactor: 0.8,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
