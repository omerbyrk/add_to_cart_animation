import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:flutter/material.dart';

import 'list_item.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Add To Cart Animation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Add To Cart Animation'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<CartIconKey> gkCart = GlobalKey<CartIconKey>();
  late Function(GlobalKey) runAddToCardAnimation;

  @override
  Widget build(BuildContext context) {
    return AddToCartAnimation(
      gkCart: gkCart,
      rotation: true,
      receiveCreateAddToCardAnimationMethod: (addToCardAnimationMethod) {
        this.runAddToCardAnimation = addToCardAnimationMethod;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: false,
          actions: [
            AddToCartIcon(
              key: gkCart,
              icon: Icon(Icons.shopping_cart),
            ),
            SizedBox(
              width: 16,
            )
          ],
        ),
        body: ListView(
          children: [
            AppListItem(onClick: listClick),
            AppListItem(onClick: listClick),
            AppListItem(onClick: listClick),
            AppListItem(onClick: listClick),
            AppListItem(onClick: listClick),
            AppListItem(onClick: listClick),
            AppListItem(onClick: listClick),
            AppListItem(onClick: listClick),
            AppListItem(onClick: listClick),
            AppListItem(onClick: listClick),
            AppListItem(onClick: listClick),
            AppListItem(onClick: listClick),
            AppListItem(onClick: listClick),
            AppListItem(onClick: listClick),
            AppListItem(onClick: listClick),
            AppListItem(onClick: listClick),
            AppListItem(onClick: listClick),
            AppListItem(onClick: listClick),
            AppListItem(onClick: listClick),
            AppListItem(onClick: listClick),
            AppListItem(onClick: listClick),
            AppListItem(onClick: listClick),
            AppListItem(onClick: listClick),
          ],
        ),
      ),
    );
  }

  void listClick(GlobalKey gkImage) {
    runAddToCardAnimation(gkImage);
  }
}
