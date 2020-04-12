import 'package:discover_world/src/domain/entities/event.dart';
import 'package:flutter/material.dart';

class EventsPage extends StatelessWidget {

  List<Event> events;
  Size _screenSize;

  EventsPage({@required this.events}) : assert(events != null);

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    return ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) => _createItem(context, events[index])
    );
  }

  _createItem(BuildContext context, Event event) {
    return Container(
      child: GestureDetector(
        child: Card(
          child: Column(
            children: <Widget>[
              Container(
                height: _screenSize.height*0.15,
                child: Image.asset('assets/images.png'),
              ),
              ListTile(
                title: Text(event.name),
                subtitle: Text(event.description),
                trailing: Icon(Icons.info),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
