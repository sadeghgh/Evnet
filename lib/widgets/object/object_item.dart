import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:evnet_agents/screens/object/imageScreen.dart';

class ObjectItem extends StatefulWidget {
  final Map<String, dynamic> data;
  Color iconColor;

  ObjectItem(
    @required this.data,
  ) {
    this.iconColor = Color(0xFF0097A7);
  }

  @override
  _ObjectItemState createState() => _ObjectItemState();
}

class _ObjectItemState extends State<ObjectItem> {
  List<dynamic> imageUrls;
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    // final double height = MediaQuery.of(context).size.height;
    imageUrls = widget.data['image_urls'];

    List<Widget> imageSliders;
    if (imageUrls != null) {
      List<String> imageUrlsAsStr = imageUrls.map((s) => s as String).toList();
      imageSliders = imageUrls
          .map((item) => Container(
                child: Container(
                  margin: EdgeInsets.all(5.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      child: Stack(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.push<Widget>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ImageScreen(
                                      imageUrlsAsStr, imageUrls.indexOf(item)),
                                ),
                              );
                            },
                            child: Image.network(
                              item,
                              fit: BoxFit.cover,
                              width: 1000.0,
                              height: 1000.0,
                            ),
                          ),
                          Positioned(
                            bottom: 0.0,
                            left: 0.0,
                            right: 0.0,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color.fromARGB(200, 0, 0, 0),
                                    Color.fromARGB(0, 0, 0, 0)
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                              child: Center(
                                child: Text(
                                  '${imageUrls.indexOf(item) + 1} (${imageUrls.length})',
                                  style: TextStyle(
                                    color: Colors.white,
                                    // fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              ))
          .toList();
    }
    return SingleChildScrollView(
      child: Container(
        color: Color(0xFFC8E6C9),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Container(
                      child: Column(
                    children: <Widget>[
                      imageSliders != null
                          ? CarouselSlider(
                              options: CarouselOptions(
                                  // autoPlay: true,
                                  aspectRatio: 2.0,
                                  enlargeCenterPage: true,
                                  initialPage: 0,
                                  viewportFraction: 0.8,
                                  enlargeStrategy:
                                      CenterPageEnlargeStrategy.height),
                              items: imageSliders,
                            )
                          : Image.asset('assets/images/evnet-noimage.jpg'),
                    ],
                  )),
                )

                // Positioned(
                //   bottom: 20,
                //   right: 10,
                //   child: Container(
                //     // width: 300,
                //     color: Colors.black54,
                //     padding: EdgeInsets.symmetric(
                //       vertical: 5,
                //       horizontal: 20,
                //     ),
                //     child: Text(
                //       title,
                //       style: TextStyle(
                //         fontSize: 26,
                //         color: Colors.white,
                //       ),
                //       softWrap: true,
                //       overflow: TextOverflow.fade,
                //     ),
                //   ),
                // )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.home,
                            color: widget.iconColor,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          widget.data['size'] != null
                              ? Text(widget.data['size'] + " m²")
                              : Text("Not added"),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.pool,
                            color: this.widget.iconColor,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          widget.data['pool'] != null
                              ? Text(widget.data['pool'] == true ? 'Yes' : 'No')
                              : Text("Not added"),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.money,
                            color: this.widget.iconColor,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          widget.data['price'] != null
                              ? Text(widget.data['price'])
                              : Text("Not added"),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.stairs,
                            color: this.widget.iconColor,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          widget.data['floor'] != null
                              ? Text(widget.data['floor'])
                              : Text("Not added"),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.date_range,
                            color: this.widget.iconColor,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          widget.data['age'] != null
                              ? Text(widget.data['age'])
                              : Text("Not added"),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.house,
                            color: this.widget.iconColor,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          widget.data['type'] != null
                              ? Text(widget.data['type'])
                              : Text("Not added"),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  elevation: 4.0,
                  // color: Color(0xFF81D4FA),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: widget.data['saleOrRental'] != null
                        ? Text(
                            'For ' + widget.data['saleOrRental'],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        : Text("Not info"),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  elevation: 4.0,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: widget.data['adress'] != null
                        ? Text(
                            widget.data['adress'],
                            style: Theme.of(context).textTheme.bodyText1,
                          )
                        : Text("Not added"),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 4.0,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: widget.data['desccription'] != null
                        ? Text(widget.data['desccription'],
                            style: Theme.of(context).textTheme.bodyText1)
                        : Text("Not added"),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FlatButton(
                    child: Text("Edit Property"),
                    onPressed: () => {},
                  ),
                  Column(
                    children: [
                      Text("Delivered:"),
                      Switch(
                        value: isSwitched,
                        onChanged: (value) {
                          setState(() {
                            isSwitched = value;
                          });
                        },
                        // activeTrackColor: Colors.lightGreenAccent,
                        activeColor: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                  FlatButton(
                    child: Text("Delete Property"),
                    onPressed: () => {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
