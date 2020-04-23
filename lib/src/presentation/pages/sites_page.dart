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
      scrollDirection: Axis.vertical,
      itemCount: sitesOfLocationSelected.length,
      itemBuilder: (context, index) => _createItem(context, sitesOfLocationSelected[index])
    );
  }

  _createItem(BuildContext context, Site site) {
    return Container(
      child: GestureDetector(
        child: Card(
          elevation: 3.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Column(
            children: <Widget>[
              Container(
                height: _screenSize.height*0.15,
                child: Image.asset('assets/images.png'),
              ),
              ListTile(
                title: Text(site.name, style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(site.type),
                trailing: Icon(Icons.info),
              ),
            ],
          ),
        ),
        onTap: () => Navigator.of(context).pushNamed('/details_site', arguments: site),
      ),
    );
  }
}
