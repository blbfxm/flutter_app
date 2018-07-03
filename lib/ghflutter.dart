import 'dart:convert';
import 'package:flutter/material.dart';
import 'strings.dart';
import 'package:http/http.dart' as http;
import 'member.dart';

class GHFlutter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new GHFlutterState();
}

class GHFlutterState extends State<GHFlutter> {
  var _member = [];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  _loadData() async {
    String dataURL = "https://api.github.com/orgs/raywenderlich/members";
    http.Response response = await http.get(dataURL);
    setState(() {
      final membersJSON = JSON.decode(response.body);
      for(var memberJSON in membersJSON){
        final member=new Member(memberJSON["login"], memberJSON["avatar_url"]);
        _member.add(member);
      }
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
            return _buildRow(position);
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
        padding: const EdgeInsets.all(2.0),
        child: new ListTile(
          title: new Text("${_member[i].login}", style: _biggerFont),
          leading: new CircleAvatar(
            backgroundColor: Colors.green,
            backgroundImage: new NetworkImage(_member[i].avatarUrl),
          ),
        ));
    /* return new ListTile(
      title: new Text("${_member[i]["login"]}",style: _biggerFont,)
    );*/
  }
}