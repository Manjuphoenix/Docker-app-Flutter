
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


main() {
  runApp(MaterialApp(home: MyApp(),));
}

String x;
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Container( width: 300, height: 200 , child: Image.asset('images/docker.jpg'),)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(child: Text("Welcome Docker user", style: TextStyle(color: Colors.white, fontSize: 35)),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(width: 150, height: 40 ,child: RaisedButton(
                  color: Colors.cyanAccent[700],
          child: Text('Continue'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SecondRoute()),
            );
          },
                ),
              ),),
            ],),
          ),
    );
  }
}


class SecondRoute extends StatefulWidget {
  @override
  _SecondRouteState createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute> {
  @override
  web(cmd) async {
    print(cmd);
    var url = "http://192.168.99.102/cgi-bin/${cmd}.py";
    var r = await http.get(url);
    print(r.body);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white12,
        title: Text("Docker"),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(50),
          width: 300,
          height: 120,
          color: Colors.grey,
          child: Column(
            children: <Widget>[
              Card(
                child: TextField(
                  onChanged: (val) {
                    x = val;
                  },
                ),
              ),
              Card(
                child: FlatButton(
                  onPressed: () {
                    // print(x); // x=date
                    web(x);
                  },
                  child: Text('submit'),
                ),
              ),
              ],
              ),
          )
          ),
        );
  }
}


/*,*/