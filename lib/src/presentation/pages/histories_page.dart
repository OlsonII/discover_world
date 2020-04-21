import 'package:discover_world/src/domain/entities/history.dart';
import 'package:flutter/material.dart';

class HistoriesPage extends StatelessWidget {

  List<History> histories;
  Size _screenSize;

  HistoriesPage({@required this.histories}) : assert(histories != null);

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    return ListView.builder(
        itemCount: histories.length,
        itemBuilder: (context, index) => _createItem(context, histories[index])
    );
  }

  _createItem(BuildContext context, History history) {
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
                title: Text(history.name),
                subtitle: Text(history.type),
                trailing: Icon(Icons.info),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
