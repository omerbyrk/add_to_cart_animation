import 'package:flutter/material.dart';

class AppListItem extends StatelessWidget {
  final GlobalKey imageGlobalKey = GlobalKey();
  final void Function(GlobalKey) onClick;

  AppListItem({required this.onClick});

  @override
  Widget build(BuildContext context) {
    Image image = Image.asset(
      "assets/apple.png",
      key: imageGlobalKey,
      width: 60,
      height: 60,
    );
    return ListTile(
      onTap: () => onClick(imageGlobalKey),
      leading: Container(child: image),
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
