import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';

class Card4 extends StatefulWidget {
  const Card4({Key? key}) : super(key: key);

  @override
  State<Card4> createState() => _Card4State();
}

class _Card4State extends State<Card4> {
  DatabaseReference infoRef = FirebaseDatabase.instance.ref().child("info");

  String _dropdownvalue = 'Every 30 seconds';
  String _dropdownvalue1 = 'Monitoring Enabled';

  var items = [
    'Every 10 seconds',
    'Every 30 seconds',
    'Every 1 minutes',
    'Every 5 minutes',
  ];

  var secs = [
    10,
    30,
    60,
    300,
  ];

  var items1 = [
    'Monitoring Enabled',
    'Monitoring Disabled',
  ];

  @override
  void initState() {
    _fetchInfos();
    super.initState();
  }

  _fetchInfos() async {
    DataSnapshot _snapshot = await infoRef.get();
    Map<dynamic, dynamic> _data = _snapshot.value as Map;
    setState(() {
      _dropdownvalue = items[secs.indexOf(_data["frequency"])];
      _dropdownvalue1 = (_data["monitor"] as bool) ? items1[0] : items1[1];
    });
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
                  IconlyBold.setting,
                  color: Color(0xFFffb240),
                  size: 26,
                ),
                const SizedBox(width: 10),
                Text(
                  "Control Monitoring",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: const Color(0xFFa0a4b4),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "Interval For Jars",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: const Color(0xFF32395a),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Expanded(
                  child: DropdownButton(
                    underline: Container(),
                    value: _dropdownvalue,
                    icon: const Icon(
                      IconlyBold.arrowDownCircle,
                      size: 22,
                      color: Color(0xFF5742ff),
                    ),
                    isExpanded: true,
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) async {
                      int freq = secs[items.indexOf(newValue!)];
                      await infoRef.update({"frequency": freq});
                      setState(() {
                        _dropdownvalue = newValue;
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Jar Monitoring",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: const Color(0xFF32395a),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                DropdownButton(
                  underline: Container(),
                  value: _dropdownvalue1,
                  icon: const Icon(
                    IconlyBold.arrowDownCircle,
                    size: 22,
                    color: Color(0xFF5742ff),
                  ),
                  items: items1.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) async {
                    if (newValue == items1[0]) {
                      await infoRef.update({"monitor": true});
                    } else {
                      await infoRef.update({"monitor": false});
                    }
                    setState(() {
                      _dropdownvalue1 = newValue!;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
