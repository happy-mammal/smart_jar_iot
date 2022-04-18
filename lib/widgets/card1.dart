import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';

class Card1 extends StatefulWidget {
  const Card1({Key? key}) : super(key: key);

  @override
  State<Card1> createState() => _Card1State();
}

class _Card1State extends State<Card1> {
  DatabaseReference infoRef = FirebaseDatabase.instance.ref().child("info");

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: infoRef.onValue,
      builder: ((context, snapshot) {
        if (snapshot.hasData && !snapshot.hasError) {
          Map<dynamic, dynamic> _data =
              (snapshot.data as DatabaseEvent).snapshot.value as Map;

          double filled = (_data["consumed"] / _data["capacity"]);
          List _cpj = _data["capacity_jars"];
          List _cuj = _data["consumed_jars"];
          int available = 0;
          int unavailable = 0;

          for (var i = 0; i < _cpj.length; i++) {
            if (_cuj[i] == _cpj[i]) {
              unavailable++;
            } else {
              available++;
            }
          }

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
                        IconlyBold.category,
                        color: Color(0xFFffb240),
                        size: 26,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Total Inventory Usage",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: const Color(0xFFa0a4b4),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.50,
                      height: MediaQuery.of(context).size.width * 0.50,
                      child: Stack(
                        fit: StackFit.expand,
                        alignment: Alignment.center,
                        children: [
                          CircularProgressIndicator(
                            backgroundColor:
                                const Color(0xFF5742ff).withOpacity(0.2),
                            color: const Color(0xFF5742ff),
                            value: double.parse(filled.toStringAsPrecision(4)),
                            strokeWidth: 8,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "${(filled * 100).toStringAsPrecision(3)}%",
                                style: GoogleFonts.poppins(
                                  color: const Color(0xFF32395a),
                                  fontSize: 50,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "Storage used",
                                style: GoogleFonts.poppins(
                                  color: const Color(0xFF32395a),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Capacity",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: const Color(0xFF32395a),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "${_data["jars"]} Jars",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: const Color(0xFF32395a),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "Unavailable",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: const Color(0xFF32395a),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "$unavailable Jars",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: const Color(0xFF32395a),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "Available",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: const Color(0xFF32395a),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "$available Jars",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: const Color(0xFF32395a),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      }),
    );
  }
}
