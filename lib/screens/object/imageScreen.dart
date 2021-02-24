import 'package:flutter/material.dart';
import 'package:pinch_zoom_image_last/pinch_zoom_image_last.dart';
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
    return Scaffold(
        appBar: AppBar(
          title: Text('The property images'),
        ),
        body: CarouselSlider(
          options: CarouselOptions(
            height: height,
            viewportFraction: 1.0,
            initialPage: widget.initialPageNr,
            enlargeCenterPage: false,
            // autoPlay: false,
          ),
          items: widget.imageUrls
              .map((item) => Container(
                    child: Center(
                        child: Image.network(
                      item,
                      fit: BoxFit.cover,
                      height: height,
                    )),
                  ))
              .toList(),
        ));
    //  PinchZoomImage(
    //   image: Image.network(url),
    //   zoomedBackgroundColor: Color.fromRGBO(240, 240, 240, 1.0),
    //   hideStatusBarWhileZooming: true,
    //   onZoomStart: () {
    //     print('Zoom started');
    //   },
    //   onZoomEnd: () {
    //     print('Zoom finished');
    //   },
    // ));
  }
}
