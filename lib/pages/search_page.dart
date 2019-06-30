import 'package:flutter/material.dart';
import 'package:flutter_trip/widget/search_bar.dart';

class SearchPage extends StatefulWidget {
  @override 
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Scaffold(
          body: Column(
            children: <Widget>[
              SearchBar(
                hideLeft: true,
                defaultText: 'hh',
                hint: '123',
                leftButtonClick: () {
                  Navigator.pop(context);
                },
                onChanged: _onTextChange,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTextChange(text) {}
}
