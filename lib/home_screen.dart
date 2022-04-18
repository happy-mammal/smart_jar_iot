import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_jar/widgets/card1.dart';
import 'package:smart_jar/widgets/card3.dart';
import 'package:smart_jar/widgets/card4.dart';
import 'package:smart_jar/widgets/card5.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DatabaseReference ref = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf6f8fa),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFf6f8fa),
        automaticallyImplyLeading: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "The Smart Jar",
              style: GoogleFonts.poppins(
                color: const Color(0xFF333a5a),
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
            IconButton(
              onPressed: () async {
                await ref.child("info").update({
                  "init": true,
                });
              },
              icon: const Icon(
                IconlyBold.filter,
                color: Color(0xFF5742ff),
              ),
            )
          ],
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: const [
          Card1(),
          // Card2(),
          // Card2(),
          Card3(),
          Card4(),
          Card5(),
        ],
      ),
    );
  }
}
