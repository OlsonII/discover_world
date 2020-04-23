import 'package:discover_world/src/domain/entities/activity.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ActivitiesPage extends StatelessWidget {

  List<Activity> activities;
  Size _screenSize;
  ActivitiesPage({@required this.activities}) : assert(activities != null);

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: activities.length,
        itemBuilder: (context, index) => _createItem(context, activities[index])
    );
  }

  _createItem(BuildContext context, Activity activity) {
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 3.0,
        child: ListTile(
          title: Text(activity.name, style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(activity.description),
          leading: FaIcon(FontAwesomeIcons.running, color: Colors.red),
        ),
      ),
    );
  }
}
