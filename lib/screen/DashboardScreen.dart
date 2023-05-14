import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../database/MoodActivityDBHelper.dart';
import '../model/Activity.dart';
import '../model/MoodTagModel.dart';
import '../screen/ProfileScreen.dart';
import '../utils/Extensions/text_styles.dart';
import '../utils/colors.dart';
import '../utils/common.dart';
import 'FilterScreen.dart';
import 'HomeScreen.dart';
import 'ReportScreen.dart';

class DashboardScreen extends StatefulWidget {
  static String tag = '/DashboardScreen';

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  final tab = [
    HomeScreen(),
    ReportScreen(),
    FilterScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    int? count = await MoodActivityDBHelper.countMood();
    if (count == 0) {
      Activity? moodCard = Activity();
      mActivityList.forEach((element) {
        moodCard.addActivity(DateTime.now().toString(), element.image!, element.name!);
      });

      MoodTagModel? mMoodTagModel = MoodTagModel();
      mMoodTagList.forEach((element) {
        mMoodTagModel.addMoodTag(DateTime.now().toString(), element.image!, element.name!);
      });
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: tab[_currentIndex],
      bottomNavigationBar: FlashyTabBar(
        selectedIndex: _currentIndex,
        showElevation: true,
        backgroundColor: primaryColor,
        onItemSelected: (index) => setState(() => _currentIndex = index),
        items: [
          FlashyTabBarItem(
            icon: Icon(AntDesign.home),
            title: Text('Home', style: primaryTextStyle(color: _currentIndex == 0 ? secondaryColor : unSelectIconColor)),
            activeColor: secondaryColor,
            inactiveColor: unSelectIconColor,
          ),
          FlashyTabBarItem(
            icon: Icon(Entypo.line_graph),
            title: Text('Report', style: primaryTextStyle(color: _currentIndex == 1 ? secondaryColor : unSelectIconColor)),
            activeColor: secondaryColor,
            inactiveColor: unSelectIconColor,
          ),
          FlashyTabBarItem(
            icon: Icon(AntDesign.filter),
            title: Text('Filter ', style: primaryTextStyle(color: _currentIndex == 2 ? secondaryColor : unSelectIconColor)),
            activeColor: secondaryColor,
            inactiveColor: unSelectIconColor,
          ),
          FlashyTabBarItem(
            icon: Icon(AntDesign.setting),
            title: Text('Settings', style: primaryTextStyle(color: _currentIndex == 3 ? secondaryColor : unSelectIconColor)),
            activeColor: secondaryColor,
            inactiveColor: unSelectIconColor,
          ),
        ],
      ),
    );
  }
}
