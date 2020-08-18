
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/animation.dart';


main() {
  runApp(new MaterialApp(home: new MyApp(),));
}

String x;
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> 
  with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationcontroller;

  @override
  void initState() {
    super.initState();
    animationcontroller = AnimationController(duration: Duration(milliseconds: 550), vsync: this);
    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
      parent: animationcontroller,
      curve: Curves.fastOutSlowIn
    ));
    animationcontroller.forward();
  }
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
      animation: animationcontroller,
      builder: (BuildContext context, Widget child){
        return Scaffold(
          backgroundColor: Colors.white,
          body: Transform(
            transform: Matrix4.translationValues(animation.value * width, 0.0, 0.0),
            child: Center(
              child: Container(
                color: Colors.black,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Container(width: 300, height: 200 , child: Image.asset('images/docker.jpg'),)),
                ),
                /*Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container( color: Colors.black ,child: Text("Welcome Docker user", style: TextStyle(color: Colors.white, fontSize: 35)),),
                ),*/
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
              ],
                ),
              ),

          ),
            )
        );
      }
      );
  }
}


class SecondRoute extends StatefulWidget {
  @override
  _SecondRouteState createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute>
 with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(duration: Duration(milliseconds: 550), vsync: this);
    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.fastOutSlowIn
    ));
    animationController.forward();
  }
  web(cmd) async {
    print(cmd);
    var url = "http://192.168.99.102/cgi-bin/${cmd}.py";
    var r = await http.get(url);
    print(r.body);
  }

  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child){
      return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white12,
        title: Text("Docker"),
      ),
      body: Transform(
        transform: Matrix4.translationValues(animation.value* width, 0, 0),
      child: Center(
        child: Container(
          margin: EdgeInsets.all(50),
          width: 300,
          height: 200,
          color: Colors.grey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
      )
        );
      }
    );
  }
}
