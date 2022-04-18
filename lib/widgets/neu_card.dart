import 'package:flutter/material.dart';

class NeuCard extends StatefulWidget {
  final VoidCallback onTap;
  final Widget child;
  const NeuCard({
    Key? key,
    required this.onTap,
    required this.child,
  }) : super(key: key);

  @override
  State<NeuCard> createState() => _NeuCardState();
}

class _NeuCardState extends State<NeuCard> {
  bool _isPressed = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        setState(() => _isPressed = !_isPressed);
        await Future.delayed(const Duration(milliseconds: 200));
        setState(() => _isPressed = !_isPressed);
        widget.onTap();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeIn,
        width: MediaQuery.of(context).size.width * 0.20,
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: widget.child,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            width: 1,
            color: _isPressed ? Colors.grey.shade800 : Colors.grey.shade900,
          ),
          color: Colors.grey.shade900,
          boxShadow: _isPressed
              ? []
              : [
                  const BoxShadow(
                    color: Colors.black,
                    offset: Offset(4, 4),
                    blurRadius: 15,
                    spreadRadius: 4,
                  ),
                  BoxShadow(
                    color: Colors.grey.shade800,
                    offset: const Offset(-4, -4),
                    blurRadius: 15,
                    spreadRadius: 1,
                  ),
                ],
        ),
      ),
    );
  }
}
