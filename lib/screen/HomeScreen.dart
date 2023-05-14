import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../utils/Extensions/Colors.dart';
import '../utils/Extensions/Loader.dart';
import '../utils/Extensions/string_extensions.dart';
import '../component/BodyWidget.dart';
import '../main.dart';
import '../utils/Extensions/Commons.dart';
import '../utils/Extensions/HorizontalList.dart';
import '../utils/Extensions/decorations.dart';
import '../utils/Extensions/shared_pref.dart';
import '../utils/appWidget.dart';
import '../utils/constant.dart';
import '../utils/images.dart';
import '../database/DbHelper.dart';
import '../model/MoodModel.dart';
import '../utils/Extensions/Widget_extensions.dart';
import '../component/MoodDetailComponent.dart';
import '../model/Mood.dart';
import '../utils/Extensions/text_styles.dart';
import '../utils/colors.dart';
import 'AddHealthScreen.dart';

class HomeScreen extends StatefulWidget {
  static String tag = '/HomeScreen';

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int ind = 0;
  var today = '';
  var yesterday = '';
  var lastWeek = '';
  var lastMonth = '';
  var lastYear = '';
  var filterDate;
  var filterDate1;

  List<String> filter = ["cal", "Today", "Yesterday", "Last week", "Last month", "Last year"];

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return BodyWidget(
      Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: Container(height: 85, width: 85, decoration: BoxDecoration(color: Colors.transparent, image: DecorationImage(image: AssetImage(ic_floting_btn)))).onTap(
          () {
            healthStore.clearMood();
            healthStore.activityList.clear();
            healthStore.clearMoodTag();
            healthStore.setMoodPhotosClear();
            healthStore.clearAudioNote();
            healthStore.note = '';

            AddHealthScreen(
                isUpdate: false,
                onCall: () {
                  setState(() {});
                }).launch(context);
          },
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        appBar: appBarWidget(
          "Hi, ${getStringAsync(NICK_NAME).capitalizeFirstLetter()}",
          elevation: 0,
          color: Colors.transparent,
          textColor: Colors.white,
          backWidget: Lottie.asset(loving_animation, width: 40, height: 40).paddingLeft(8),
        ),
        body: Observer(builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HorizontalList(
                itemCount: filter.length,
                padding: EdgeInsets.all(16),
                itemBuilder: (context, i) {
                  return GestureDetector(
                    onTap: () {
                      ind = i;
                      var now = DateTime.now();
                      if (filter[i] == 'cal') {
                        showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime.now()).then((date) => {
                              setState(() {
                                DateTime? d2 = date;
                                DateFormat f = DateFormat("yyyy-MM-dd");
                                filterDate = f.format(d2!);
                                filterDate1 = f.format(d2);
                              }),
                            });
                      } else if (filter[i] == 'Today') {
                        today = now.toString();
                        filterDate = today;
                        filterDate1 = today;
                        setState(() {});
                        log("Today" + filterDate);
                      } else if (filter[i] == 'Yesterday') {
                        yesterday = now.subtract(Duration(days: 1)).toString();
                        filterDate = yesterday;
                        var yesterday1 = filterDate;
                        filterDate1 = yesterday1;
                        setState(() {});
                        log("Yesterday" + filterDate + "  " + filterDate1);
                      } else if (filter[i] == "Last week") {
                        lastWeek = now.toString();
                        filterDate = lastWeek;
                        var lastWeek1 = DateTime.parse(filterDate).subtract(Duration(days: 7)).toString();
                        filterDate1 = lastWeek1;
                        setState(() {});
                        log("Last Week" + filterDate + "   " + filterDate1);
                      } else if (filter[i] == "Last month") {
                        lastMonth = DateTime(now.year, now.month, now.day).toString();
                        filterDate = lastMonth;
                        DateTime y1 = DateTime.parse(filterDate);
                        var lastMonth1 = DateTime(y1.year, y1.month - 1, y1.day).toString();
                        filterDate1 = lastMonth1;
                        setState(() {});
                        log('Last Month' + filterDate + "  " + filterDate1);
                      } else if (filter[i] == "Last year") {
                        log("Last Year");
                        lastYear = DateTime(now.year, now.month, now.day).toString();
                        filterDate = lastYear;
                        DateTime y1 = DateTime.parse(filterDate);
                        var lastYear1 = DateTime(y1.year - 1, y1.month, y1.day).toString();
                        filterDate1 = lastYear1;
                        setState(() {});
                        log('Last Year' + filterDate + "  " + filterDate1);
                      } else {
                        //
                      }

                      DateFormat? f;
                      if (filter[i] == 'Today') {
                        f = DateFormat("dd-MM-yyyy");
                      } else {
                        f = DateFormat("yyyy-MM-dd");
                      }
                      var d = DateTime.parse(filterDate);
                      var d1 = DateTime.parse(filterDate1);
                      filterDate = f.format(d);
                      filterDate1 = f.format(d1);
                      setState(() {});
                      log("filterDate1 " + filterDate1);
                      log("filterDate " + filterDate);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: boxDecorationWithRoundedCornersWidget(
                          borderRadius: radius(20), border: Border.all(width: 1, color: ind == i ? cardColor : primaryColor), backgroundColor: ind == i ? primaryColor : cardColor),
                      child: filter[i] == 'cal'
                          ? Icon(Icons.calendar_today_outlined, size: 18, color: ind == i ? whiteColor : Colors.black)
                          : Text(filter[i], style: primaryTextStyle(color: ind == i ? whiteColor : Colors.black, size: 14)),
                    ),
                  );
                },
              ),
              Stack(
                children: [
                  FutureBuilder<List>(
                    future: filterDate1 != null && filterDate != null ? DBHelper.getFilterDateData('user_moods', filterDate, filterDate1) : DBHelper.getData('user_moods'),
                    initialData: [],
                    builder: (context, snapshot) {
                      List<ActivityListModel>? mActivityList = [];
                      List<ActivityListModel>? mMoodList = [];
                      healthStore.clearMoodCheck();
                      if (snapshot.hasData)
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          primary: true,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(vertical: 16),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, int index) {
                            String? moodName = snapshot.data![index]['mood'];
                            int? id = snapshot.data![index]['id'];
                            int? moodId = snapshot.data![index]['mood_id'];
                            String? moodImg = snapshot.data![index]['image'];
                            List<String> activityId = snapshot.data![index]['act_id'].toString().split('_');
                            List<String> activityImg = snapshot.data![index]['actimage'].split('_');
                            List<String> activityName = snapshot.data![index]['actname'].split("_");
                            String? note = snapshot.data![index]['note'];
                            List<String> tagId = snapshot.data![index]['tag_id'].toString().split('_');
                            List<String> tagName = snapshot.data![index]['tag'].split('_');
                            List<String> tagImg = snapshot.data![index]['tagImage'].split('_');
                            String? voiceNote = snapshot.data![index]['voiceNote'] ?? "";
                            List<String> photos = snapshot.data![index]['photos'].toString().split('mood-image');
                            String? date = snapshot.data![index]['date'];
                            String? date1 = snapshot.data![index]['datetime'];

                            ActivityListModel mActivity = ActivityListModel();
                            mActivity.name = activityName;
                            mActivity.image = activityImg;
                            ActivityListModel mMood = ActivityListModel();
                            mMood.name = tagName;
                            mMood.image = tagImg;
                            mActivityList.add(mActivity);
                            mMoodList.add(mMood);
                            Mood mood = Mood();
                            mood.id = id;
                            mood.moodName = moodName;
                            mood.moodId = moodId;
                            mood.moodImg = moodImg;
                            mood.activityId = activityId;
                            mood.activityImg = activityImg;
                            mood.activityName = activityName;
                            mood.note = note;
                            mood.tagId = tagId;
                            mood.tagImg = tagImg;
                            mood.tagName = tagName;
                            mood.voiceNote = voiceNote;
                            mood.photos = photos;
                            mood.date = date;
                            mood.dateTime = date1;
                            mood.mActivity = mActivityList;
                            mood.mMood = mMoodList;
                            healthStore.addToMoodCheck(mood);
                            return AnimationConfiguration.staggeredGrid(
                              position: index,
                              columnCount: 2,
                              duration: Duration(milliseconds: 375),
                              child: SlideAnimation(
                                verticalOffset: 10.0,
                                child: FadeInAnimation(
                                  curve: Curves.fastOutSlowIn,
                                  duration: Duration(milliseconds: 100),
                                  child: MoodDetailComponent(mood, onCall: () {
                                    appStore.setLoading(true);
                                    print(healthStore.moodCheckList.length.toString());
                                    if (healthStore.moodCheckList.length == 0) {
                                      healthStore.loaderCheck = true;
                                    }
                                    setState(() {});
                                    appStore.setLoading(false);
                                  }),
                                ),
                              ),
                            );
                          },
                        );
                      return snapWidgetHelper(snapshot, loadingWidget: Loader());
                    },
                  ),
                  if ( healthStore.moodCheckList.isEmpty && !appStore.isLoading) noDataWidget().center()
                ],
              ).expand(),
            ],
          );
        }),
      ),
    );
  }
}
