import 'package:flutter/material.dart';
import 'badge_options.dart';

export 'badge_options.dart';

class AddToCartIcon extends StatefulWidget {
  final GlobalKey<CartIconKey> key;
  final Widget icon;
  final BadgeOptions badgeOptions;

  const AddToCartIcon({
    required this.key,
    required this.icon,
    this.badgeOptions = const BadgeOptions(),
  }) : super(key: key);

  @override
  CartIconKey createState() => CartIconKey();
}

class CartIconKey extends State<AddToCartIcon>
    with SingleTickerProviderStateMixin {
  String _qtdeBadge = "0";

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 225),
    vsync: this,
  );

  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(0, 0.0),
    end: const Offset(.6, 0.0),
  ).animate(
    CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticIn,
    ),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Improvement/Suggestion 5 -> Implementing Cart with Badge
    return Container(
      width: 50,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SlideTransition(
            position: _offsetAnimation,
            child: this.widget.icon,
          ),
          widget.badgeOptions.active
              ? Positioned(
                  left: 30,
                  top: 5,
                  child: Container(
                    padding: EdgeInsets.all(2.0),
                    width: widget.badgeOptions.width,
                    height: widget.badgeOptions.height,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: widget.badgeOptions.backgroundColor ??
                          Theme.of(context).colorScheme.secondary,
                    ),
                    constraints: BoxConstraints(minWidth: 16, minHeight: 16),
                    child: Text(
                      _qtdeBadge,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: widget.badgeOptions.fontSize,
                        color: widget.badgeOptions.foregroundColor,
                      ),
                    ),
                  ))
              : const SizedBox(
                  width: 0,
                  height: 0,
                ),
        ],
      ),
    );
  }

  // Improvement/Suggestion 4.2: Change method-name + incorporating badge-quantity as optional-parameter
  Future<void> runCartAnimation([String? badgeQuantity]) async {
    await _controller.forward();
    await _controller.reverse();
    _changeQtdeBadgeState(badgeQuantity);
    return;
  }

  updateBadge(String? badgeQuantity) async {
    _changeQtdeBadgeState(badgeQuantity);
    return;
  }

  // Improvement/Suggestion 4.3: Adding 'badget-widget' counter Set-State
  void _changeQtdeBadgeState(String? value) {
    if (value != null) {
      setState(() {
        _qtdeBadge = value;
      });
    }
  }

  // Improvement/Suggestion 4.4 -> Adding 'clear-cart-button'
  Future<void> runClearCartAnimation() async {
    await _controller.forward();
    await _controller.reverse();
    _changeQtdeBadgeState("0");
    return;
  }
}
