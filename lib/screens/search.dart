import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String keyword =
        ModalRoute.of(context)!.settings.arguments.toString();

    return Scaffold(
      appBar: AppBar(title: Text('結果')),
      body: Center(
        child: FutureBuilder(
          future: searchKeyword(keyword),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return _resultItem(snapshot.data[index]);
                },
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  Future<List> searchKeyword(String keyword) async {
    CollectionReference words = FirebaseFirestore.instance.collection('words');
    var list = [];
    final prefixMatch = await words
        .orderBy('name')
        .startAt([keyword]).endAt([keyword + '\uf8ff']).get();

    print(prefixMatch.docs.map((e) => print(e)));
    prefixMatch.docs.forEach((element) {
      list.add({'name': element['name'], 'tdn': element['tdn']});
    });
    return list;
  }

  Widget _resultItem(word) {
    const _urlNicodic = 'https://dic.nicovideo.jp/a/';
    void _launchURL() async => await canLaunch(_urlNicodic)
        ? await launch(_urlNicodic + Uri.encodeComponent(word['name']))
        : throw 'Could not launch $_urlNicodic';

    return Container(
      decoration: new BoxDecoration(
          border: new Border(bottom: BorderSide(color: Colors.grey))),
      child: ListTile(
        title: Text(
          word['name'],
          style: TextStyle(color: Colors.black, fontSize: 32.0),
        ),
        subtitle: Text(
          word['tdn'],
          style: TextStyle(fontSize: 16.0),
        ),
        onTap: _launchURL,
      ),
    );
  }
}
