import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CapacityGraph extends StatefulWidget {
  final String jar;

  const CapacityGraph({Key? key, required this.jar}) : super(key: key);

  @override
  State<CapacityGraph> createState() => _CapacityGraphState();
}

class _CapacityGraphState extends State<CapacityGraph> {
  DatabaseReference jarRef = FirebaseDatabase.instance.ref().child("jars");

  int startAt =
      int.parse("${DateFormat("yyyyMMdd").format(DateTime.now())}000000");
  int endAt =
      int.parse("${DateFormat("yyyyMMdd").format(DateTime.now())}235959");

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: jarRef.child(widget.jar).onValue,
        builder: (context, snapshot) {
          if (snapshot.hasData && !snapshot.hasError) {
            Map<dynamic, dynamic> _data =
                (snapshot.data as DatabaseEvent).snapshot.value as Map;

            double filled = (_data["consumed"] / _data["capacity"]);

            Map history = _data["history"] as Map;

            List<double> valueSet = [];

            history.forEach((key, value) {
              int numKey = int.parse(key.toString().replaceAll("T", ""));

              if (numKey >= startAt && numKey <= endAt) {
                valueSet.add((value / _data["capacity"]) * 100);
              }
            });

            return Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 10,
              ),
              child: valueSet.isEmpty
                  ? Center(
                      child: Text(
                        "No Data Available For Today.",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                        ),
                      ),
                    )
                  : Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.15,
                                height:
                                    MediaQuery.of(context).size.width * 0.15,
                                child: Stack(
                                  fit: StackFit.expand,
                                  alignment: Alignment.center,
                                  children: [
                                    CircularProgressIndicator(
                                      backgroundColor: const Color(0xFF5742ff)
                                          .withOpacity(0.2),
                                      color: const Color(0xFF5742ff),
                                      value: filled,
                                      strokeWidth: 5,
                                    ),
                                    Center(
                                      child: Text(
                                        "${(filled * 100).toStringAsPrecision(3)}%",
                                        style: GoogleFonts.poppins(
                                          color: const Color(0xFF32395a),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Jar 1 on ${DateFormat("MMM dd, yyyy").format(DateTime.now())}",
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: const Color(0xFF32395a),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "Available - ${(filled * 100).toStringAsPrecision(3)} %",
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: const Color(0xFF32395a),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Sparkline(
                          enableGridLines: true,
                          gridLineLabelColor: const Color(0xFF32395a),
                          gridLineWidth: 1,
                          gridLineColor: Colors.grey.shade200,
                          data: valueSet,
                          fillMode: FillMode.below,
                          lineColor: const Color(0xFFffb240),
                          lineWidth: 3,
                          lineGradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              const Color(0xFFffb240),
                              const Color(0xFFffb240).withOpacity(0.2),
                            ],
                          ),
                          fillColor: Colors.transparent,
                          useCubicSmoothing: true,
                        ),
                      ],
                    ),
            );
          } else {
            return Container();
          }
        });
  }
}
