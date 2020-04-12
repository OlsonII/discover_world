import 'package:discover_world/src/domain/entities/site.dart';
import 'package:flutter/material.dart';

class SitesPage extends StatelessWidget {

  List<Site> sitesOfLocationSelected;
  Size _screenSize;

  SitesPage({@required this.sitesOfLocationSelected}) : assert(sitesOfLocationSelected != null);

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    return ListView.builder(
      itemCount: sitesOfLocationSelected.length,
      itemBuilder: (context, index) => _createItem(context, sitesOfLocationSelected[index])
    );
  }

  _createItem(BuildContext context, Site site) {
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
                title: Text(site.name),
                subtitle: Text(site.description),
                trailing: Icon(Icons.info),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
