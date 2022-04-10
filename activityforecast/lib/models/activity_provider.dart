import 'package:activityforecast/components/activities.dart';
import 'package:activityforecast/components/more_activity_card.dart';
import 'package:activityforecast/models/activity.dart';
import 'package:flutter/material.dart';

class ActivityProvider extends ChangeNotifier {
  // When adding an archived (MORE ACTIVITY) to the My Acitivies (current activies)
  void addMyActivity(Activity activity, int moreActivityIndex) {
    currentActivities.add(activity); // add to My ACTIVITIES
    moreActivities.remove(
        moreActivities[moreActivityIndex]); // remove from theM MORE ACTIVITIES

    notifyListeners();
  }

  // When removing My Acitivies (current activies)
  void removeMyActivity(Activity activity, int myActivityIndex) {
    moreActivities.insert(0, activity); // add to My ACTIVITIES
    currentActivities.remove(
        currentActivities[myActivityIndex]); // remove from theM MORE ACTIVITIES

    notifyListeners();
  }

  // When removing archived Acitivies (more activies)
  void removeMoreActivity(int moreActivityIndex) {
    moreActivities.remove(
        moreActivities[moreActivityIndex]); // remove from theM MORE ACTIVITIES

    notifyListeners();
  }

  // Change the status (true/false) of an activity whocyh is based on the weather
  void changeStatus(int myActivityIndex, bool status) {
    currentActivities[myActivityIndex].status = status;
  }

  // After creating a new activity, add to MORE ACTIVITIES
  void addCreatedActivity(Activity activity) {
    moreActivities.insert(0, activity);

    notifyListeners();
  }

  void reorderMoreActivity(int oldIndex, int newIndex) {
    var item = moreActivities.removeAt(oldIndex);
    moreActivities.insert(newIndex, item);

    notifyListeners();
  }

  void reorderMyActivity(int oldIndex, int newIndex) {
    var item = currentActivities.removeAt(oldIndex);
    currentActivities.insert(newIndex, item);
    notifyListeners();
  }

  List<Activity> moreActivities = [
    Activity(
        activity: "Run",
        activityIcon: Icons.directions_run,
        status: true,
        temperatures: RangeValues(0, 0),
        isSunnyIdeal: true,
        isFogIdeal: true,
        isCloudyIdeal: true,
        isDrizzleIdeal: true,
        isRainyIdeal: true,
        isThunderstormIdeal: true,
        isSnowIdeal: true),
    Activity(
        activity: "Ski",
        activityIcon: Icons.downhill_skiing,
        status: true,
        temperatures: RangeValues(0, 0),
        isSunnyIdeal: true,
        isFogIdeal: true,
        isCloudyIdeal: true,
        isDrizzleIdeal: true,
        isRainyIdeal: true,
        isThunderstormIdeal: true,
        isSnowIdeal: true),
    // Activity(
    //     activity: "Picnic",
    //     activityIcon: Icons.,
    //     condition: condition,
    //     status: true),
    Activity(
        activity: "Surfing",
        activityIcon: Icons.surfing,
        status: true,
        temperatures: RangeValues(0, 0),
        isSunnyIdeal: true,
        isFogIdeal: true,
        isCloudyIdeal: true,
        isDrizzleIdeal: true,
        isRainyIdeal: true,
        isThunderstormIdeal: true,
        isSnowIdeal: true),
    Activity(
        activity: "Swim",
        activityIcon: Icons.pool,
        status: true,
        temperatures: RangeValues(0, 0),
        isSunnyIdeal: true,
        isFogIdeal: true,
        isCloudyIdeal: true,
        isDrizzleIdeal: true,
        isRainyIdeal: true,
        isThunderstormIdeal: true,
        isSnowIdeal: true),
    Activity(
        activity: "Hike",
        activityIcon: Icons.hiking,
        status: true,
        temperatures: RangeValues(0, 0),
        isSunnyIdeal: true,
        isFogIdeal: true,
        isCloudyIdeal: true,
        isDrizzleIdeal: true,
        isRainyIdeal: true,
        isThunderstormIdeal: true,
        isSnowIdeal: true),
    Activity(
        activity: "FootBall",
        activityIcon: Icons.sports_football,
        status: true,
        temperatures: RangeValues(0, 0),
        isSunnyIdeal: true,
        isFogIdeal: true,
        isCloudyIdeal: true,
        isDrizzleIdeal: true,
        isRainyIdeal: true,
        isThunderstormIdeal: true,
        isSnowIdeal: true),
    Activity(
        activity: "BasketBall",
        activityIcon: Icons.sports_baseball,
        status: true,
        temperatures: RangeValues(0, 0),
        isSunnyIdeal: true,
        isFogIdeal: true,
        isCloudyIdeal: true,
        isDrizzleIdeal: true,
        isRainyIdeal: true,
        isThunderstormIdeal: true,
        isSnowIdeal: true),
    Activity(
        activity: "Soccer",
        activityIcon: Icons.sports_soccer,
        status: true,
        temperatures: RangeValues(0, 0),
        isSunnyIdeal: true,
        isFogIdeal: true,
        isCloudyIdeal: true,
        isDrizzleIdeal: true,
        isRainyIdeal: true,
        isThunderstormIdeal: true,
        isSnowIdeal: true),
    Activity(
        activity: "Cricket",
        activityIcon: Icons.sports_cricket,
        status: true,
        temperatures: RangeValues(0, 0),
        isSunnyIdeal: true,
        isFogIdeal: true,
        isCloudyIdeal: true,
        isDrizzleIdeal: true,
        isRainyIdeal: true,
        isThunderstormIdeal: true,
        isSnowIdeal: true),
    Activity(
        activity: "Golf",
        activityIcon: Icons.sports_golf,
        status: true,
        temperatures: RangeValues(0, 0),
        isSunnyIdeal: true,
        isFogIdeal: true,
        isCloudyIdeal: true,
        isDrizzleIdeal: true,
        isRainyIdeal: true,
        isThunderstormIdeal: true,
        isSnowIdeal: true),
    Activity(
        activity: "Mix Martial Arts",
        activityIcon: Icons.sports_handball,
        status: true,
        temperatures: RangeValues(0, 0),
        isSunnyIdeal: true,
        isFogIdeal: true,
        isCloudyIdeal: true,
        isDrizzleIdeal: true,
        isRainyIdeal: true,
        isThunderstormIdeal: true,
        isSnowIdeal: true),
  ];

  List<Activity> currentActivities = [];
}