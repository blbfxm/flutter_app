import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'strings.dart';
import './class/getdata.dart';

class GHFlutter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new GHFlutterState();
}

class GHFlutterState extends State<GHFlutter> {
  var _member = [];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  _loadData() async {
    Response response = await new GetData().loadData();
    setState(() {
      _member = response.data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(Strings.appTitle),
        ),
        body: new ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: _member.length * 2,
          itemBuilder: (BuildContext context, int position) {
            if (position.isOdd) {
              return new Divider();
            }
            var index = position ~/ 2;
            return _buildRow(index);
          },
        ));
  }

  @override
  void initState() {
    super.initState();

    _loadData();
  }

  Widget _buildRow(int i) {
    return new Padding(
        padding: const EdgeInsets.all(12.0),
        child: new ListTile(
          title: new Text("${_member[i]["login"]}", style: _biggerFont),
          leading: new CircleAvatar(
            backgroundColor: Colors.green,
            backgroundImage: new NetworkImage("${_member[i]["avatar_url"]}"),
          ),
        ));
  }
}
