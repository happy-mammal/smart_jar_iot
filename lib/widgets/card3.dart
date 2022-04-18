import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_jar/widgets/capacity_graph.dart';

class Card3 extends StatefulWidget {
  const Card3({Key? key}) : super(key: key);

  @override
  State<Card3> createState() => _Card3State();
}

class _Card3State extends State<Card3> with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: 3, vsync: this);
    super.initState();
  }

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
                  IconlyBold.activity,
                  color: Color(0xFFffb240),
                  size: 26,
                ),
                const SizedBox(width: 10),
                Text(
                  "Jar Activity",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: const Color(0xFFa0a4b4),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TabBar(
              controller: _controller,
              indicatorColor: const Color(0xFF5742ff),
              tabs: [
                Text(
                  "Jar 1",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: const Color(0xFFa0a4b4),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "Jar 2",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: const Color(0xFFa0a4b4),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "Jar 3",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: const Color(0xFFa0a4b4),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.26,
              child: TabBarView(
                controller: _controller,
                children: const [
                  CapacityGraph(jar: "jar1"),
                  CapacityGraph(jar: "jar2"),
                  CapacityGraph(jar: "jar3"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
