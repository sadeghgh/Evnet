import 'package:flutter/material.dart';

class MainMentItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;
  final String nextPage;

  MainMentItem(this.id, this.title, this.color, this.nextPage);

  void selectCategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      nextPage,
      arguments: {
        'id': id,
        'title': title,
        'color': color,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      // color: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),

      child: InkWell(
        onTap: () => selectCategory(context),
        splashColor: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Text(
            title,
            style: Theme.of(context).textTheme.subtitle1,
            textAlign: TextAlign.center,
          ),
          decoration: BoxDecoration(
            // boxShadow: [
            //   BoxShadow(
            //     color: color,
            //     blurRadius: 1.0,
            //     // offset: Offset.zero,
            //     // spreadRadius: 1.0,
            //   ),
            // ],
            color: color.withOpacity(0.9),

            // gradient: LinearGradient(
            //   colors: [
            //     color.withOpacity(0.3),
            //     color,
            //   ],
            //   begin: Alignment.topLeft,
            //   end: Alignment.bottomRight,
            // ),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
