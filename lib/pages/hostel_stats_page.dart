import 'package:flutter/material.dart';

import '../data/hostel.dart';

class HostelStatsPage extends StatefulWidget {
 final Hostel hostel;
   const HostelStatsPage({super.key, required this.hostel});

  @override
  State<HostelStatsPage> createState() => _HostelStatsPageState();
}

class _HostelStatsPageState extends State<HostelStatsPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
