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
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
                      image: DecorationImage(
                          image: NetworkImage(event.image),
                          colorFilter: new ColorFilter.mode(Color.fromRGBO(244, 100, 82, 0.5), BlendMode.dstATop),
                          fit: BoxFit.cover
                      )
                  )
              ),
              ListTile(
                title: Text(event.name),
                subtitle: Text(event.description),
                trailing: Icon(Icons.info),
              ),
            ],
          ),
        ),
        onTap: () => Navigator.pushNamed(context, '/details_event', arguments: event),
      ),
    );
  }
}
