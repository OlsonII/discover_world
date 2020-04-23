import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchLocationPage extends StatefulWidget {

  @override
  _SearchLocationPageState createState() => _SearchLocationPageState();
}

class _SearchLocationPageState extends State<SearchLocationPage> {

  Size _screenSize;
  Color _principalColor = Color.fromRGBO(55, 157, 168, 1);
  Color _secondColor = Color.fromRGBO(99, 196, 207, 1);
  String _citySelected;

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            color: Colors.blue,
            gradient: LinearGradient(
                colors: [
                  _principalColor,
                  _secondColor
                ],
                stops: [0.0, 0.9]
            )
        ),
        child: Column(
          children: <Widget>[
            Expanded(child: Container()),
            _buildSearchBar(),
            SizedBox(height: _screenSize.height*0.04,),
            FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)
                ),
                onPressed: (){
                  _citySelected != null ?
                  Navigator.pushReplacementNamed(context, '/details_location', arguments: _citySelected)
                  : null;
                },
                color: Colors.white,
                child: Text('Buscar', style: TextStyle(fontSize: 17.0, color: _principalColor)
                )
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      width: _screenSize.width*0.8,
      height: _screenSize.height*0.06,
      margin: EdgeInsets.only(top: 50.0, right: 10.0),
      padding: EdgeInsets.only(left: 15.0, right: 3.0, top: 10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          color: Color.fromRGBO(255, 255, 255, 1)
      ),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Quiero explorar',
          hintStyle: TextStyle(fontFamily: 'ProductSans', fontWeight: FontWeight.bold, color: Color.fromRGBO(55, 157, 168, 0.6)),
          suffixIcon: FaIcon(FontAwesomeIcons.search, color: _principalColor)
        ),
        onChanged: (value){
          setState(() {
            _citySelected = value;
          });
        },
        textCapitalization: TextCapitalization.words,
        textAlign: TextAlign.start,
        keyboardType: TextInputType.text,
        style: TextStyle(height: 1.3, fontWeight: FontWeight.bold, fontSize: 19.5, color: _principalColor),
      ),
    );
  }
}
