import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomChip extends StatefulWidget {
  final double value;
  const CustomChip({
    Key? key,
    required this.value,
  }) : super(key: key);

  @override
  State<CustomChip> createState() => _CustomChipState();
}

class _CustomChipState extends State<CustomChip> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${widget.value.toStringAsPrecision(3)}%",
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.green,
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.2),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(width: 2, color: Colors.green),
      ),
    );
  }
}
