import 'package:flutter/material.dart';

class MainMeny {
  final String id;
  final String title;
  final Color color;
  final String nextPage;

  const MainMeny({
    @required this.id,
    @required this.title,
    this.color = Colors.orange,
    @required this.nextPage,
  });
}
