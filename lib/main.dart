import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/animation.dart';
import 'package:Docker/Containerpage.dart';
import 'package:Docker/Volumepage.dart';
import 'package:Docker/Networkpage.dart';


main() {
  runApp(new MaterialApp( theme: ThemeData.dark() ,home: new MyApp(),
  initialRoute: 'MyApp',
  routes: {
    'MyApp': (context) => MyApp(),
    'Volumepage': (context) => DockerVolume(),
    'Containerpage': (context) => Containerpage(),
    'Networkpage': (context) => DockerNetwork(),
  },
  ));
}

String x;
String cmd1;
var addcontainer;

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
                    child: Container(width: 150, height: 40 ,
                    /*child: FlatButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                      color: Colors.cyanAccent[700],
                      child: Text('Continue'),
                      onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SecondRoute()),
                      );
                      },
                    ),*/
                    child: MaterialButton(
                      /*elevation: 5,
                      color: Colors.white24,
                      splashColor: Colors.cyanAccent,
                      highlightColor: Colors.cyanAccent[700],
                      animationDuration: Duration(seconds: 5), 
                      shape: RoundedRectangleBorder(*/

                        //height: MediaQuery.of(context).size.height/15,
                      //minWidth: MediaQuery.of(context).size.width/3,
                       elevation: 5,
                       highlightColor: Colors.cyanAccent[700],
                       splashColor: Colors.cyanAccent,
                       color: Colors.grey[600],
                       animationDuration: Duration(seconds: 5),
                        shape: RoundedRectangleBorder(

                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text('Next'),
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
   final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();
  Animation animation;
  AnimationController animationController;
  var cmd;
  var webdata;

  web(cmd) async {
    var url = "http://192.168.43.171/cgi-bin/cmd.py?x=${cmd}";
    var r = await http.get(url);

    setState(() {
      webdata = r.body;
    });

   print(webdata);
  }

  //get floatingActionButton => null;
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
        /*appBar: AppBar(
        backgroundColor: Colors.white12,
        title: Text("Docker"),
        ),*/
        /*body: RaisedButton(
          onPressed: () {
            if (fabKey.currentState.isOpen) {
              fabKey.currentState.close();
            } else {
              fabKey.currentState.open();
            }
          },
          child: Text('Toggle menu')
        ),*/
        floatingActionButton: FabCircularMenu(
        ringDiameter: width*0.9,
        ringWidth: width*1*0.2,
        key: fabKey,
          children: <Widget>[
            IconButton(icon: Icon(Icons.storage, color: Colors.grey[700],), onPressed: () {
              Navigator.push(context,
              MaterialPageRoute(builder: (context) => Containeroutput())
              );
            }),
            IconButton(icon: Icon(Icons.crop_square,color: Colors.grey[700],), onPressed: () {
                      Navigator.pushNamed(
                        context,
                        'SamplePage',
                      );
            }),
            IconButton(icon: Icon(Icons.image,color: Colors.grey[700],), onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
              //web(cmd);
              //Text(webdata ?? "Docker images:");
            }),
            IconButton(icon: Icon(Icons.network_check,color: Colors.grey[700],), onPressed: () {
              print('Networks');
              String cmd = "docker network ls";
              web(cmd);
              Text(webdata ?? "Docker Networks:");
            }),
          ]
          ),
      body: Transform(
        transform: Matrix4.translationValues(animation.value* width, 0, 0),
        child: Container(
        height: double.infinity,
        margin: EdgeInsets.all(70),
        //color: Colors.grey,
        child: ListView(
            children: <Widget>[
                //Text("Enter ur linux cmd :"),
                TextField(
        decoration: InputDecoration(hintText: 'Enter the Linux command here: '),
        onChanged: (value) {
          cmd1 = value;
        },
                ),
                /*Padding(
        padding: const EdgeInsets.all(25.0),
        child: FlatButton(
            shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.grey[700],
              onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Cmdoutput()));
              },
              child: Text('click here')),
                ),*/
                SizedBox(height: 25,),
                MaterialButton(
        height: MediaQuery.of(context).size.height/15,
        minWidth: MediaQuery.of(context).size.width/3,
        elevation: 5,
        highlightColor: Colors.cyanAccent[700],
        splashColor: Colors.cyanAccent,
        color: Colors.grey[600],
        animationDuration: Duration(seconds: 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)
        ),
        child: Text("Submit"),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => Cmdoutput()));
        },
                ),/*
                SizedBox(
        height: 5,
                ),
                Text("output is been redirected.."),*/
                SizedBox(height: 40,),
                Text("Get complete control over :", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400,)),
                /*Padding(
        padding: const EdgeInsets.all(8.0),
        child: FlatButton(
          shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
          color: Colors.green,
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Containerpage()));
          }, child: Text('Container'),
        ),
                ),*/
                SizedBox(height: 10,),
                Padding(
        padding: EdgeInsets.all(15.0),
        child: MaterialButton(
          color: Colors.grey,
          splashColor: Colors.deepPurple,
          highlightColor: Colors.purple,
          elevation: 2,
          height: MediaQuery.of(context).size.height/13,
          minWidth: MediaQuery.of(context).size.width/2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          ),
          child: Text('Container'),
          onPressed: (){
            Navigator.pushNamed(context, 'Containerpage');
          },
        ),
                ),
                Padding(
        padding: EdgeInsets.all(15.0),
        child: MaterialButton(
          color: Colors.grey,
          splashColor: Colors.green[900],
          highlightColor: Colors.teal[800],
          elevation: 2,
          height: MediaQuery.of(context).size.height/13,
          minWidth: MediaQuery.of(context).size.width/2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          ),
          child: Text('Volume'),
          onPressed: (){
            Navigator.pushNamed(context, 'Volumepage');
          },
        ),
                ),
                Padding(
        padding: EdgeInsets.all(15.0),
        child: MaterialButton(
          color: Colors.grey,
          splashColor: Colors.blue[900],
          highlightColor: Colors.indigo,
          height: MediaQuery.of(context).size.height/13,
          minWidth: MediaQuery.of(context).size.width/2,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          ),
          child: Text('Network'),
          onPressed: (){
            Navigator.pushNamed(context, 'Networkpage');
          },
        ),
                ),
          ],
          ),
      ),
      ),
    );
    }
    );
  }
}



class Containeroutput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DraggableScrollableSheet'),
      ),
      body: SizedBox.expand(
        child: DraggableScrollableSheet(
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              color: Colors.blue[100],
              child: ListView.builder(
                controller: scrollController,
                itemBuilder: (BuildContext context, int index) {
                  return Scaffold(
                    
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ScrollController _scrollController;

  List allSlides = [
    {'slideName': 'slideOne', 'selected': false},
    {'slideName': 'slideTwo', 'selected': false},
    {'slideName': 'slideThree', 'selected': false},
    {'slideName': 'slideFour', 'selected': false},
    {'slideName': 'slideFive', 'selected': false},
    {'slideName': 'slideSix', 'selected': false},
    {'slideName': 'slideSeven', 'selected': false},
    {'slideName': 'slideEight', 'selected': false},
    {'slideName': 'slideNine', 'selected': false}
  ];

  var selectedSlide;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(changeSelector);
    setState(() {
      selectedSlide = allSlides[0];
      selectedSlide['selected'] = true;
    });
  }

  changeSelector() {
    var maxScrollVal = _scrollController.position.maxScrollExtent;

    var divisor = (maxScrollVal / allSlides.length) + 20;

    var scrollValue = _scrollController.offset.round();
    var slideValue = (scrollValue / divisor).round();

    var currentSlide = allSlides.indexWhere((slide) => slide['selected']);

    setState(() {
      allSlides[currentSlide]['selected'] = false;
      selectedSlide = allSlides[slideValue];
      selectedSlide['selected'] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Scroll Tricks'),
          centerTitle: true,
        ),
        body: Row(
          children: <Widget>[
            SizedBox(width: 15.0),
            Container(
              width: MediaQuery.of(context).size.width / 3,
              child: ListView(
                  children: allSlides.map((element) {
                return getTitles(element);
              }).toList()),
            ),
            SizedBox(width: 10.0),
            Container(
              width: (MediaQuery.of(context).size.width / 3) * 2 - 25.0,
              child: ListView(
                controller: _scrollController,
                children: allSlides.map((element) {
                  return getCards(element);
                }).toList(),
              ),
            )
          ],
        ));
  }

  Widget getCards(slide) {
    return Padding(
      padding: EdgeInsets.only(top: 15.0, right: 10.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: Colors.black, style: BorderStyle.solid, width: 1.0),
        ),
        height: 200.0,
        width: 125.0,
        child: Center(
          child: Text(
            slide['slideName'],
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  scrollToSlide(inputSlide) {
    var whichSlide = allSlides
        .indexWhere((slide) => slide['slideName'] == inputSlide['slideName']);

    var maxScrollValue = _scrollController.position.maxScrollExtent;

    var divisor = (maxScrollValue / allSlides.length) + 20;

    var scrollToValue = whichSlide * divisor;

    _scrollController.animateTo(scrollToValue,
        curve: Curves.easeIn, duration: Duration(milliseconds: 1000));
  }

  Widget getTitles(slide) {
    return InkWell(
      onTap: () {
        scrollToSlide(slide);
      },
      child: Padding(
        padding: EdgeInsets.only(top: 15.0),
        child: Text(
          slide['slideName'],
          style: TextStyle(
              fontWeight:
                  slide['selected'] ? FontWeight.bold : FontWeight.normal,
              fontSize: 17.0),
        ),
      ),
    );
  }
}

class Containerop extends StatefulWidget {
  @override
  _ContaineropState createState() => _ContaineropState();
}

class _ContaineropState extends State<Containerop> {
  String cmd = 'date';
  var webdata;
  /*web(cmd) async {
    var url = "http://192.168.0.109/cgi-bin/cmd.py?x=${cmd}";
    var r = await http.get(url);

    setState(() {
      webdata = r.body;
    });

   print(webdata);
  }*/

  create(name)async{
    var url = "http://192.168.43.171/cgi-bin/createcont.py?x=${name}";
    var r = await http.get(url);
  setState(() {
    webdata = r.body;
  });
  }

  @override
  Widget build(BuildContext context) {
    create(addcontainer);
    //web(cmd);
    print(webdata);
    return Scaffold(
      appBar: AppBar(title: Text('Creating container for Centos O.S of latest version....'),),
      body: Container(
        margin: EdgeInsets.all(50),
        child: Column(
            children: <Widget>[
              Text(webdata ?? 'The output is :'),
            ],
          ),
      )
      );
  }
}


class Cmdoutput extends StatefulWidget {
  @override
  _CmdoutputState createState() => _CmdoutputState();
}

class _CmdoutputState extends State<Cmdoutput> {
 
  var cmd;
  var webdata;

  web(cmd) async {
    var url = "http://192.168.0.109/cgi-bin/cmd.py?x=${cmd}";
    var r = await http.get(url);

    setState(() {
      webdata = r.body;
    });

   print(webdata);
  }

  @override
  Widget build(BuildContext context) {
    web(cmd1);
    return Scaffold(
      body: Container(
        //margin: EdgeInsets.all(50),
        alignment: Alignment.center,
        child: Text( webdata ?? 'The command output is.../n'),
      ),
    );
  }
}