import 'package:flutter/material.dart';

class MainMentItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;
  final String nextPage;
  final String imagePath;

  MainMentItem(this.id, this.title, this.color, this.nextPage, this.imagePath);

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
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                title,
                // style: TextStyle(color: Colors.white),
                style: Theme.of(context).textTheme.subtitle1.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              Expanded(
                child: ClipRRect(
                    child: Image.asset(
                  imagePath,
                )),
              ),
            ],
          ),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black38,
                blurRadius: 9.0,
                // offset: Offset.infinite,
                spreadRadius: 1.0,
              ),
            ],
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
