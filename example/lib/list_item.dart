import 'package:flutter/material.dart';

class AppListItem extends StatelessWidget {
  final GlobalKey imageGlobalKey = GlobalKey();
  final void Function(GlobalKey) onClick;

  AppListItem({required this.onClick});

  @override
  Widget build(BuildContext context) {
    // Improvement/Suggestion 3.1: Container is mandatory. It can hold images or whatever you want
    Container mandatoryContainer = Container(
        key: imageGlobalKey,
        width: 60,
        height: 60,
        color: Colors.transparent,
        child: Image.asset("assets/apple.png", width: 60, height: 60));

    return ListTile(
      onTap: () => onClick(imageGlobalKey),
      leading: mandatoryContainer,
      title: FutureBuilder(
        future: Future.value(Rect.zero),
        initialData: Rect.zero,
        builder: (_, snapshot) {
          return Text(snapshot.data.toString());
        },
      ),
      //title: Text(key.globalPaintBounds!.top.toString() + " - " + key.globalPaintBounds!.left.toString() + " - " + key.globalPaintBounds!.right.toString()+ " - " + key.globalPaintBounds!.left.toString()),
    );
  }
}