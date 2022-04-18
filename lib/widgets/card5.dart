import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

import 'package:smart_jar/widgets/custom_chip.dart';

class Card5 extends StatefulWidget {
  const Card5({Key? key}) : super(key: key);

  @override
  State<Card5> createState() => _Card5State();
}

class _Card5State extends State<Card5> with SingleTickerProviderStateMixin {
  late TabController _controller;

  int jar1cap = 0;
  int jar2cap = 0;
  int jar3cap = 0;

  List<bool> isAvailable = [false, false, false];

  Query jar1Ref = FirebaseDatabase.instance
      .ref()
      .child("jars")
      .child("jar1")
      .child("history");

  Query jar2Ref = FirebaseDatabase.instance
      .ref()
      .child("jars")
      .child("jar2")
      .child("history");

  Query jar3Ref = FirebaseDatabase.instance
      .ref()
      .child("jars")
      .child("jar3")
      .child("history");

  String startAt = "${DateFormat("yyyyMMdd").format(DateTime.now())}T000000";
  String endAt = "${DateFormat("yyyyMMdd").format(DateTime.now())}T235959";

  late Key _list1Key, _list2Key, _list3Key;
  @override
  void initState() {
    _fetchDefaultInfo();
    _controller = TabController(length: 3, vsync: this);
    _list1Key = Key("k1$startAt");
    _list2Key = Key("k2$startAt");
    _list3Key = Key("k3$startAt");
    _checkDataAvailablity();

    super.initState();
  }

  _fetchDefaultInfo() async {
    DatabaseReference jar1Ref =
        FirebaseDatabase.instance.ref().child("jars").child("jar1");
    DatabaseReference jar2Ref =
        FirebaseDatabase.instance.ref().child("jars").child("jar2");
    DatabaseReference jar3Ref =
        FirebaseDatabase.instance.ref().child("jars").child("jar3");

    var _snapshot1 = await jar1Ref.get();
    var _snapshot2 = await jar2Ref.get();
    var _snapshot3 = await jar3Ref.get();

    Map _data1 = _snapshot1.value as Map;
    Map _data2 = _snapshot2.value as Map;
    Map _data3 = _snapshot3.value as Map;

    setState(() {
      jar1cap = _data1["capacity"];
      jar2cap = _data2["capacity"];
      jar3cap = _data3["capacity"];
    });
  }

  _checkDataAvailablity() async {
    DatabaseReference jarRef = FirebaseDatabase.instance.ref().child("jars");

    for (var i = 1; i <= 3; i++) {
      var _snapshot = await jarRef
          .child("jar$i")
          .child("history")
          .orderByKey()
          .startAt(startAt)
          .endAt(endAt)
          .get();
      if (_snapshot.value != null) {
        isAvailable[i - 1] = true;
        setState(() {});
      }
    }
  }

  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedStartDate) {
      setState(() {
        selectedStartDate = picked;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedEndDate) {
      setState(() {
        selectedEndDate = picked;
        startAt = "${DateFormat("yyyyMMdd").format(selectedStartDate)}T000000";
        endAt = "${DateFormat("yyyyMMdd").format(selectedEndDate)}T235959";
        _list1Key = Key("k1$startAt");
        _list2Key = Key("k2$startAt");
        _list3Key = Key("k3$startAt");
      });
    }
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
                  IconlyBold.timeSquare,
                  color: Color(0xFFffb240),
                  size: 26,
                ),
                const SizedBox(width: 10),
                Text(
                  "Activity History",
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
              height: MediaQuery.of(context).size.height * 0.60,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => _selectStartDate(context),
                            child: Text(
                              DateFormat("MMM dd, yyyy")
                                  .format(selectedStartDate),
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: const Color(0xFF333a5a),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Transform.rotate(
                              angle: 90 * math.pi / 180,
                              child: const Icon(
                                IconlyBold.swap,
                                size: 24,
                                color: Color(0xFFffb240),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _selectEndDate(context),
                            child: Text(
                              DateFormat("MMM dd, yyyy")
                                  .format(selectedEndDate),
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: const Color(0xFF333a5a),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Icon(
                        IconlyBold.calendar,
                        size: 26,
                        color: Color(0xFF5742ff),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: TabBarView(
                      controller: _controller,
                      children: [
                        isAvailable[0]
                            ? FirebaseAnimatedList(
                                key: _list1Key,
                                query: jar1Ref
                                    .orderByKey()
                                    .startAt(startAt)
                                    .endAt(endAt),
                                itemBuilder:
                                    (context, snapshot, animation, index) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        DateFormat("MMM dd, yyyy on hh:mm a")
                                            .format(DateTime.parse(
                                                snapshot.key.toString())),
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          color: const Color(0xFFa0a4b4),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      CustomChip(
                                        value: ((snapshot.value as int) /
                                                jar1cap) *
                                            100,
                                      ),
                                    ],
                                  );
                                },
                              )
                            : Center(
                                child: Text(
                                  "No Data Available For Today.",
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                        isAvailable[1]
                            ? FirebaseAnimatedList(
                                key: _list2Key,
                                query: jar2Ref
                                    .orderByKey()
                                    .startAt(startAt)
                                    .endAt(endAt),
                                itemBuilder:
                                    (context, snapshot, animation, index) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        DateFormat("MMM dd, yyyy on hh:mm a")
                                            .format(DateTime.parse(
                                                snapshot.key.toString())),
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          color: const Color(0xFFa0a4b4),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      CustomChip(
                                        value: ((snapshot.value as int) /
                                                jar2cap) *
                                            100,
                                      ),
                                    ],
                                  );
                                },
                              )
                            : Center(
                                child: Text(
                                  "No Data Available For Today.",
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                        isAvailable[2]
                            ? FirebaseAnimatedList(
                                key: _list3Key,
                                query: jar3Ref
                                    .orderByKey()
                                    .startAt(startAt)
                                    .endAt(endAt),
                                itemBuilder:
                                    (context, snapshot, animation, index) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        DateFormat("MMM dd, yyyy on hh:mm a")
                                            .format(DateTime.parse(
                                                snapshot.key.toString())),
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          color: const Color(0xFFa0a4b4),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      CustomChip(
                                        value: ((snapshot.value as int) /
                                                jar3cap) *
                                            100,
                                      ),
                                    ],
                                  );
                                },
                              )
                            : Center(
                                child: Text(
                                  "No Data Available For Today.",
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
