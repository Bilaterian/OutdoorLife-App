import 'dart:developer';

import 'package:activityforecast/components/activities.dart';
import 'package:activityforecast/components/more_activity_card.dart';
import 'package:activityforecast/models/activity.dart';
import 'package:activityforecast/services/database.dart';
import 'package:flutter/material.dart';

class ActivityProvider extends ChangeNotifier {

  void readFromDB() async {
    List<Activity> activities = await DBProvider.dbp.getActivities();

    currentActivities = [];
    moreActivities = [];

    int CACount = 0;
    for (int i = 0; i < activities.length; i++) {
      //for (int j = 0; j < activities.length; j++) {
        if (activities[i].category == 0) { //activities[i].order == CACount
          currentActivities.add(activities[i]);
          CACount += 1;
        }
      //}
    }

    int MACount = 0;
    for (int i = 0; i < activities.length; i++) {
      //for (int j = 0; j < activities.length; j++) { //activities[i].order == MACount
        if (activities[i].category == 1) {
          moreActivities.add(activities[i]);
          MACount += 1;
        }
      //}
    }

    printActivities();

    log("CACount = " + CACount.toString() + ", MACount = " + MACount.toString());
  }

  void updateToDB() async {
    log("------UPDATETODB");
    // clear DB contents

    //await DBProvider.dbp.clearTable();

    recalculateOrderAndCategory();

    log("-----------------Updating Database with");
    printActivities();

    log("CACount = " + currentActivities.length.toString() + ", MACount = " + moreActivities.length.toString());
    List<Activity> temp = [];

    Activity activity;
    for(int i = 0; i < currentActivities.length; i++) {
      activity = currentActivities[i];
      temp.add(activity);
    }

    for (int i = 0; i < moreActivities.length; i++) {
      activity = moreActivities[i];
      temp.add(activity);
    }

    DBProvider.dbp.updateActivities(temp);

    /*
    Activity activity;
    for(int i = 0; i < currentActivities.length; i++) {
      activity = currentActivities[i];
      await DBProvider.dbp.updateActivity(activity);
    }

    for (int i = 0; i < moreActivities.length; i++) {
      activity = moreActivities[i];
      await DBProvider.dbp.insertActivity(activity);
    }
    */
  }

  // When adding an archived (MORE ACTIVITY) to the My Acitivies (current activies)
  void addMyActivity(Activity activity, int moreActivityIndex) {
    log("-----------------addMyActivity");
    // !<!<!<
    //log("-----------------before");
    //printActivities();

    currentActivities.add(activity); // add to My ACTIVITIES
    moreActivities.remove(moreActivities[moreActivityIndex]); // remove from theM MORE ACTIVITIES

    //log("-----------------after");
    //printActivities();

    updateToDB();

    notifyListeners();
  }

  // When removing My Acitivies (current activies)
  void removeMyActivity(Activity activity, int myActivityIndex) {
    log("-----------------removeMyActivity");
    moreActivities.insert(0, activity); // add to My ACTIVITIES
    currentActivities.remove(
        currentActivities[myActivityIndex]); // remove from theM MORE ACTIVITIES

    updateToDB();

    notifyListeners();
  }

  // When removing archived Acitivies (more activies)
  void removeMoreActivity(int moreActivityIndex) {
    log("-----------------removeMoreActivity");
    moreActivities.remove(
moreActivities[moreActivityIndex]); // remove from theM MORE ACTIVITIES

    updateToDB();

    notifyListeners();
  }

  // After creating a new activity, add to MORE ACTIVITIES
  void addCreatedActivity(Activity activity) {
    log("-----------------addCreatedActivity");
    moreActivities.insert(0, activity);

    updateToDB();

    notifyListeners();
  }

  void reorderMoreActivity(int oldIndex, int newIndex) {
    log("-----------------reorderMoreActivity");

    log("-----------------before");
    printActivities();

    //readFromDB();

    var item = moreActivities.removeAt(oldIndex);
    moreActivities.insert(newIndex, item);

    recalculateOrderAndCategory();

    //log("-----------------after");
    //printActivities();

    updateToDB();

    //log("-----------------end");
    //printActivities();

    notifyListeners();
  }

  void reorderMyActivity(int oldIndex, int newIndex) {
    log("-----------------reorderMyActivity");
    var item = currentActivities.removeAt(oldIndex);
    currentActivities.insert(newIndex, item);

    updateToDB();

    notifyListeners();
  }

  // recalculate orders/categories
  void recalculateOrderAndCategory() {
    int order = 0;
    for(int i = 0; i < currentActivities.length; i++) {
      currentActivities[i].order = order;
      currentActivities[i].category = 0;
      order += 1;
    }

    for (int i = 0; i < moreActivities.length; i++) {
      moreActivities[i].order = order;
      moreActivities[i].category = 1;
      order += 1;
    }
  }

  void printActivities() {

    int order = 0;
    for(int i = 0; i < currentActivities.length; i++) {
      log(currentActivities[i].activity + "(" + currentActivities[i].order.toString() + ")");
    }
    log("----");
    for (int i = 0; i < moreActivities.length; i++) {
      log(moreActivities[i].activity + "(" + moreActivities[i].order.toString() + ")");
    }
  }

  List<Activity> moreActivities = [
    // Activity(
    //     order: 1,
    //     category: 1,
    //     activity: "Run",
    //     activityIconCP: Icons.directions_run.codePoint,
    //     status: true,
    //     minTemp: 0,
    //     maxTemp: 0,
    //     isSunnyIdeal: true,
    //     isFogIdeal: true,
    //     isCloudyIdeal: true,
    //     isDrizzleIdeal: true,
    //     isRainyIdeal: true,
    //     isThunderstormIdeal: true,
    //     isSnowIdeal: true),
    // Activity(
    //     order: 2,
    //     category: 1,
    //     activity: "Ski",
    //     activityIconCP: Icons.downhill_skiing.codePoint,
    //     status: true,
    //     minTemp: 0,
    //     maxTemp: 0,
    //     isSunnyIdeal: true,
    //     isFogIdeal: true,
    //     isCloudyIdeal: true,
    //     isDrizzleIdeal: true,
    //     isRainyIdeal: true,
    //     isThunderstormIdeal: true,
    //     isSnowIdeal: true),
    // // Activity(
    // //     activity: "Picnic",
    // //     activityIcon: Icons.,
    // //     condition: condition,
    // //     status: true),
    // Activity(
    //     order: 3,
    //     category: 1,
    //     activity: "Surfing",
    //     activityIconCP: Icons.surfing.codePoint,
    //     status: true,
    //     minTemp: 0,
    //     maxTemp: 0,
    //     isSunnyIdeal: true,
    //     isFogIdeal: true,
    //     isCloudyIdeal: true,
    //     isDrizzleIdeal: true,
    //     isRainyIdeal: true,
    //     isThunderstormIdeal: true,
    //     isSnowIdeal: true),
    // Activity(
    //     order: 4,
    //     category: 1,
    //     activity: "Swim",
    //     activityIconCP: Icons.pool.codePoint,
    //     status: true,
    //     minTemp: 0,
    //     maxTemp: 0,
    //     isSunnyIdeal: true,
    //     isFogIdeal: true,
    //     isCloudyIdeal: true,
    //     isDrizzleIdeal: true,
    //     isRainyIdeal: true,
    //     isThunderstormIdeal: true,
    //     isSnowIdeal: true),
    // Activity(
    //     order: 5,
    //     category: 1,
    //     activity: "Hike",
    //     activityIconCP: Icons.hiking.codePoint,
    //     status: true,
    //     minTemp: 0,
    //     maxTemp: 0,
    //     isSunnyIdeal: true,
    //     isFogIdeal: true,
    //     isCloudyIdeal: true,
    //     isDrizzleIdeal: true,
    //     isRainyIdeal: true,
    //     isThunderstormIdeal: true,
    //     isSnowIdeal: true),
    // Activity(
    //     order: 6,
    //     category: 1,
    //     activity: "FootBall",
    //     activityIconCP: Icons.sports_football.codePoint,
    //     status: true,
    //     minTemp: 0,
    //     maxTemp: 0,
    //     isSunnyIdeal: true,
    //     isFogIdeal: true,
    //     isCloudyIdeal: true,
    //     isDrizzleIdeal: true,
    //     isRainyIdeal: true,
    //     isThunderstormIdeal: true,
    //     isSnowIdeal: true),
    // Activity(
    //     order: 7,
    //     category: 1,
    //     activity: "BasketBall",
    //     activityIconCP: Icons.sports_baseball.codePoint,
    //     status: true,
    //     minTemp: 0,
    //     maxTemp: 0,
    //     isSunnyIdeal: true,
    //     isFogIdeal: true,
    //     isCloudyIdeal: true,
    //     isDrizzleIdeal: true,
    //     isRainyIdeal: true,
    //     isThunderstormIdeal: true,
    //     isSnowIdeal: true),
    // Activity(
    //     order: 8,
    //     category: 1,
    //     activity: "Soccer",
    //     activityIconCP: Icons.sports_soccer.codePoint,
    //     status: true,
    //     minTemp: 0,
    //     maxTemp: 0,
    //     isSunnyIdeal: true,
    //     isFogIdeal: true,
    //     isCloudyIdeal: true,
    //     isDrizzleIdeal: true,
    //     isRainyIdeal: true,
    //     isThunderstormIdeal: true,
    //     isSnowIdeal: true),
    // Activity(
    //     order: 9,
    //     category: 1,
    //     activity: "Cricket",
    //     activityIconCP: Icons.sports_cricket.codePoint,
    //     status: true,
    //     minTemp: 0,
    //     maxTemp: 0,
    //     isSunnyIdeal: true,
    //     isFogIdeal: true,
    //     isCloudyIdeal: true,
    //     isDrizzleIdeal: true,
    //     isRainyIdeal: true,
    //     isThunderstormIdeal: true,
    //     isSnowIdeal: true),
    // Activity(
    //     order: 10,
    //     category: 1,
    //     activity: "Golf",
    //     activityIconCP: Icons.sports_golf.codePoint,
    //     status: true,
    //     minTemp: 0,
    //     maxTemp: 0,
    //     isSunnyIdeal: true,
    //     isFogIdeal: true,
    //     isCloudyIdeal: true,
    //     isDrizzleIdeal: true,
    //     isRainyIdeal: true,
    //     isThunderstormIdeal: true,
    //     isSnowIdeal: true),
    // Activity(
    //     order: 11,
    //     category: 1,
    //     activity: "Mix Martial Arts",
    //     activityIconCP: Icons.sports_handball.codePoint,
    //     status: true,
    //     minTemp: 0,
    //     maxTemp: 0,
    //     isSunnyIdeal: true,
    //     isFogIdeal: true,
    //     isCloudyIdeal: true,
    //     isDrizzleIdeal: true,
    //     isRainyIdeal: true,
    //     isThunderstormIdeal: true,
    //     isSnowIdeal: true),
  ];

  List<Activity> currentActivities = [];
}