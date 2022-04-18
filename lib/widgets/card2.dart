import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';

class Card2 extends StatefulWidget {
  const Card2({Key? key}) : super(key: key);

  @override
  State<Card2> createState() => _Card2State();
}

class _Card2State extends State<Card2> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  IconlyBold.infoSquare,
                  color: Color(0xFFffb240),
                  size: 26,
                ),
                const SizedBox(width: 10),
                Text(
                  "Suggestion",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: const Color(0xFFa0a4b4),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              "Jar 1 capacity is full. You can either shift contents from Jar 1 to Jar 2 or Jar 3.",
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: const Color(0xFF32395a),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
