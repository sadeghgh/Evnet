import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImageScreen extends StatefulWidget {
  final List<dynamic> imageUrls;
  final int initialPageNr;
  ImageScreen(this.imageUrls, this.initialPageNr);

  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  // final String url;
  // _MyImageScreen(this.url);
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('The property images'),
      ),
      body: Center(
        child: Carousel(
          // boxFit: BoxFit.cover,
          autoplay: false,
          animationCurve: Curves.fastOutSlowIn,
          animationDuration: Duration(milliseconds: 1000),
          dotSize: 6.0,
          dotIncreasedColor: Color(0xFF1B5E20),
          dotBgColor: Colors.transparent,
          dotPosition: DotPosition.topRight,
          dotVerticalPadding: 10.0,
          showIndicator: true,
          indicatorBgPadding: 7.0,
          images: widget.imageUrls
              .map((item) => Container(
                    child: Center(
                      child: InteractiveViewer(
                        child: Image.network(
                          item,
                          fit: BoxFit.cover,
                          height: height,
                          width: width,
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
