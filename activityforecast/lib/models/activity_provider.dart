import 'package:activityforecast/components/activities.dart';
import 'package:activityforecast/components/more_activity_card.dart';
import 'package:activityforecast/models/activity.dart';
import 'package:activityforecast/services/activities_database.dart';
import 'package:flutter/material.dart';

enum ActivityList {
  current,
  more,
}

class ActivityProvider extends ChangeNotifier {
  // When adding an archived (MORE ACTIVITY) to the My Acitivies (current activies)
  void addMyActivity(Activity activity, int moreActivityIndex) {
    currentActivities.add(activity); // add to My ACTIVITIES
    moreActivities.remove(
        moreActivities[moreActivityIndex]); // remove from theM MORE ACTIVITIES

    notifyListeners();
  }

  void refreshMyActivityFromDatabase(List<Activity> activity) {
    currentActivities = List.from(activity);
    notifyListeners();
  }

  void refreshMyActivityFromDatabase2(List<Activity> activity) {
    moreActivities = List.from(activity);
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
    moreActivities.add(activity);

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

  List<Activity> moreActivities = [];

  List<Activity> currentActivities = [];
}
