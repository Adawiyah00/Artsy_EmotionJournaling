import 'package:flutter/material.dart';

class MoodCheckScreen extends StatefulWidget {
  static String tag = '/MoodCheckScreen';

  @override
  MoodCheckScreenState createState() => MoodCheckScreenState();
}

class MoodCheckScreenState extends State<MoodCheckScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async{
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}