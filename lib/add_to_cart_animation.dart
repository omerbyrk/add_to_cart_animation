import 'dart:math';

import 'add_to_cart_icon.dart';
import 'globalkeyext.dart';
import 'package:flutter/material.dart';

class PositionedAnimationModel {
  bool showAnimation = false;
  bool animationActive = false;
  Offset imageSourcePoint = Offset.zero;
  Offset imageDestPoint = Offset.zero;
  Size imageSourceSize = Size.zero;
  Size imageDestSize = Size.zero;
  bool rotation = false;
  double opacity = 0.85;
  late Image widget;
  Duration duration = Duration.zero;
  Curve curve = Curves.easeIn;
}

class AddToCartAnimation extends StatefulWidget {
  final Widget child;
  final GlobalKey<CartIconKey> gkCart;
  final bool rotation;
  final double opacity;
  final double previewHeight;
  final double previewWidth;
  final Duration previewDuration;
  final Duration dragToCardDuration;
  final Curve previewCurve;
  final Curve dragToCardCurve;
  final Function(Future<void> Function(GlobalKey))
      receiveCreateAddToCardAnimationMethod;

  const AddToCartAnimation({
    Key? key,
    required this.child,
    required this.gkCart,
    required this.receiveCreateAddToCardAnimationMethod,
    this.previewHeight = 30,
    this.previewWidth = 30,
    this.previewDuration = const Duration(milliseconds: 500),
    this.dragToCardDuration = const Duration(milliseconds: 1000),
    this.rotation = false,
    this.opacity = 0.85,
    this.previewCurve = Curves.linearToEaseOut,
    this.dragToCardCurve = Curves.easeIn,
  }) : super(key: key);

  @override
  _AddToCartAnimationState createState() => _AddToCartAnimationState();
}

class _AddToCartAnimationState extends State<AddToCartAnimation> {
  List<PositionedAnimationModel> animationModels = [];

  @override
  void initState() {
    this.widget.receiveCreateAddToCardAnimationMethod(runAddToCardAnimation);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        Positioned.fill(
          child: Stack(
            children: animationModels
                .map<Widget>((model) => model.showAnimation
                    ? AnimatedPositioned(
                        top: model.animationActive
                            ? model.imageDestPoint.dx
                            : model.imageSourcePoint.dx,
                        left: model.animationActive
                            ? model.imageDestPoint.dy
                            : model.imageSourcePoint.dy,
                        height: model.animationActive
                            ? model.imageDestSize.height
                            : model.imageSourceSize.height,
                        width: model.animationActive
                            ? model.imageDestSize.width
                            : model.imageSourceSize.width,
                        duration: model.duration,
                        curve: model.curve,
                        child: model.rotation
                            ? TweenAnimationBuilder(
                                tween: Tween<double>(begin: 0, end: pi * 2),
                                duration: model.duration,
                                child: model.widget,
                                builder: (context, double value, widget) {
                                  return Transform.rotate(
                                    angle: value,
                                    child: Opacity(
                                      opacity: model.opacity,
                                      child: widget,
                                    ),
                                  );
                                },
                              )
                            : Opacity(
                                opacity: model.opacity,
                                child: model.widget,
                              ),
                      )
                    : Container())
                .toList(),
          ),
        ),
      ],
    );
  }

  Future<void> runAddToCardAnimation(GlobalKey gkImage) async {
    PositionedAnimationModel animationModel = PositionedAnimationModel()
      ..rotation = false
      ..opacity = widget.opacity;

    animationModel.imageSourcePoint =
        Offset(gkImage.globalPaintBounds!.top, gkImage.globalPaintBounds!.left);

    animationModel.imageDestPoint = Offset(
        gkImage.globalPaintBounds!.top -
            (gkImage.currentContext!.size!.height + widget.previewHeight),
        gkImage.globalPaintBounds!.left);

    animationModel.imageSourceSize = Size(gkImage.currentContext!.size!.width,
        gkImage.currentContext!.size!.height);

    animationModel.imageDestSize = Size(
        gkImage.currentContext!.size!.width + widget.previewWidth,
        gkImage.currentContext!.size!.height + widget.previewHeight);

    animationModels.add(animationModel);
    animationModel.widget = Image(
      image: (gkImage.currentWidget! as Image).image,
    );

    animationModel.showAnimation = true;

    setState(() {});

    await Future.delayed(Duration(milliseconds: 75));

    animationModel.curve = widget.previewCurve;
    animationModel.duration =
        widget.previewDuration; // This is for preview mode
    animationModel.animationActive = true; // That's start the animation.
    setState(() {});

    await Future.delayed(animationModel.duration);
    // Drag to card animation
    animationModel.curve = widget.dragToCardCurve;
    animationModel.rotation = widget.rotation;
    animationModel.duration =
        widget.dragToCardDuration; // this is for add to button mode

    animationModel.imageDestPoint = Offset(
        this.widget.gkCart.globalPaintBounds!.top,
        this.widget.gkCart.globalPaintBounds!.left);

    animationModel.imageDestSize = Size(
        this.widget.gkCart.currentContext!.size!.width,
        this.widget.gkCart.currentContext!.size!.height);

    setState(() {});

    await Future.delayed(animationModel.duration);
    animationModel.showAnimation = false;
    animationModel.animationActive = false;
    setState(() {});
    await this.widget.gkCart.currentState!.runAnimation();
    return;
  }
}
/*
;
 */