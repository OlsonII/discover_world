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
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
                      image: DecorationImage(
                          image: NetworkImage(history.image),
                          colorFilter: new ColorFilter.mode(Color.fromRGBO(244, 100, 82, 0.5), BlendMode.dstATop),
                          fit: BoxFit.cover
                      )
                  )
              ),
              ListTile(
                title: Text(history.name),
                subtitle: Text(history.type),
                trailing: Icon(Icons.info),
              ),
            ],
          ),
        ),
        onTap: () => Navigator.pushNamed(context, '/details_history', arguments: history),
      ),
    );
  }
}
