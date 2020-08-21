import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/animation.dart';


main() {
  runApp(new MaterialApp( theme: ThemeData.dark() ,home: new MyApp(),));
}

String x;
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> 
  with SingleTickerProviderStateMixin {
  Animation animation, delayedAnimation, muchDelayedAnimation;
  AnimationController animationcontroller;

  @override
  void initState() {
    super.initState();
    animationcontroller = AnimationController(duration: Duration(seconds: 4), vsync: this);
    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
      parent: animationcontroller,
      curve: Curves.fastOutSlowIn
    ));
    delayedAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
      parent: animationcontroller,
      curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn)
    ));
    muchDelayedAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
    parent: animationcontroller,
    curve: Interval(0.9, 1.0, curve: Curves.fastOutSlowIn)
    ));
    animationcontroller.forward();
  }
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
      animation: animationcontroller,
      builder: (BuildContext context, Widget child){
        return Scaffold(
          //backgroundColor: Colors.white,
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
                Transform(
                  transform: Matrix4.translationValues(delayedAnimation.value*width, 0, 0),
                    child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Welcome Docker user", style: TextStyle(fontSize: 35)),
                  ),
                ),
                Transform(
                  transform: Matrix4.translationValues(muchDelayedAnimation.value*width, 0, 0),
                                  child: Padding(
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
                ),
              ],),
              ),
          ),)
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
  var cmd;
  var webdata;

  web(cmd) async {
    var url = "http://192.168.0.113/cgi-bin/cmd.py?x=${cmd}";
    var r = await http.get(url);

    setState(() {
      webdata = r.body;
    });

    // print(webdata);
  }

  get floatingActionButton => null;
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


  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child){
      return Scaffold(
      //backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white12,
        title: Text("Docker"),
      ),
      floatingActionButton: FabCircularMenu(
        ringDiameter: width*0.9,
        ringWidth: width*1*0.2,
          children: <Widget>[
            IconButton(icon: Icon(Icons.storage, color: Colors.grey[700],), onPressed: () {
              print('Home');
              String cmd = "docker volume ls";
              web(cmd);
              Text(webdata ?? "Docker volumes:");
            }),
            IconButton(icon: Icon(Icons.crop_square,color: Colors.grey[700],), onPressed: () {
              print('Favorite');
              String cmd = "docker ps";
              web(cmd);
            }),
            IconButton(icon: Icon(Icons.image,color: Colors.grey[700],), onPressed: () {
              print('Favorite');
              String cmd = "docker images";
              web(cmd);
              Text(webdata ?? "Docker images:");
            }),
            IconButton(icon: Icon(Icons.network_check,color: Colors.grey[700],), onPressed: () {
              print('Favorite');
            }),
          ]
          ),
      body: Transform(
        transform: Matrix4.translationValues(animation.value* width, 0, 0),
      child: Container(
        height: double.infinity,
        margin: EdgeInsets.all(50),
        //color: Colors.grey,
        child: Column(
          children: <Widget>[
              Text("Enter ur linux cmd :"),
              TextField(
                onChanged: (value) {
                  cmd = value;
                },
              ),
              FlatButton(
                color: Colors.grey[700],
                  onPressed: () {
                    web(cmd);
                  },
                  child: Text('click here')),
              Text(webdata ?? "output is coming .."),
            ],
            ),
        ),
      ),
        );
      }
    );
  }
}
