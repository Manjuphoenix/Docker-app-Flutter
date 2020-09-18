import 'package:flutter/material.dart';
import 'package:Docker/main.dart';
import 'package:http/http.dart' as http;


class Containerpage extends StatefulWidget {
  @override
  _ContainerpageState createState() => _ContainerpageState(); 
}

class _ContainerpageState extends State<Containerpage> {
  var containername;
  var imagename;
  var webdata;
  var deletecontainer;
  var inspectcontainer;
  var os;

  /*web(cmd) async {
    var url = "http://192.168.0.109/cgi-bin/cmd.py?x=${cmd}";
    var r = await http.get(url);

    setState(() {
      webdata = r.body;
    });

    // print(webdata);
  }*/

  create(name)async{
    var url = "http://192.168.0.109/cgi-bin/cmd.py?x=${name}";
    var r = await http.get(url);
  setState(() {
    webdata = r.body;
  });
  }

  @override
  Widget build(BuildContext context) {
    final pageheight = MediaQuery.of(context).size.height;
    final pagewidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text('Docker Container'),),
      body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 10,),
                      Text("Enter the name of Container and image name to create the container: ", style: TextStyle(fontWeight: FontWeight.w400, height: 1.5, fontSize: 17),),
                      //SizedBox(height: 2,),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: MediaQuery.of(context).size.height/15,
                              width: MediaQuery.of(context).size.width/2.5,
                              child: TextField(
                              decoration: InputDecoration(hintText: 'Container Name:',border: OutlineInputBorder(),),
                              onChanged: (value) {
                              containername = value;
                              },),
                            ),
                            SizedBox(width: 15,),
                            Container(
                          height: MediaQuery.of(context).size.height/15,
                          width: MediaQuery.of(context).size.width/3,
                          child: TextField(
                          decoration: InputDecoration(hintText: 'Image Name: ', border: OutlineInputBorder(),),
                          onChanged: (value) {
                          imagename = value;
                            },
                           ),
                          ),
                          ],
                        ),
                      ),
                      /*Container(child: Text('Input name of container to be created with centos operating system:', style: TextStyle(color: Colors.white),),),
                      Container(
                        margin: EdgeInsets.all(20),
                        child: TextField(
                          onChanged: (name){
                            addcontainer = name;
                          },
                        ),
                      ),*/
                      Row(
                        children: <Widget>[
                          MaterialButton(
                          highlightColor: Colors.teal[800],
                          splashColor: Colors.tealAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)
                          ),
                          color: Colors.white38,
                          //label: Text('Create'),
                          child: Text("Create", style: TextStyle(fontStyle: FontStyle.italic ,fontWeight: FontWeight.w800,),),
                          onPressed: (){
                          Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Containerop()));
                          //create(addcontainer)
                          },),
                        ],
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width/16,),
                      Container(child: Text('Enter the name of container to be deleted:', style: TextStyle(fontWeight: FontWeight.w400, height: 1.5, fontSize: 17),),),
                      Container(
                        height: pageheight/8,
                        width: pagewidth/2,
                        child: TextField(
                          onChanged: (name){
                            deletecontainer = name;
                          },
                        ),
                      ),
                      Container(child: Text('Input name of container to be inspected:', style: TextStyle(fontWeight: FontWeight.w400, height: 1.5, fontSize: 17),),),
                      Container(
                        height: pageheight/8,
                        width: pagewidth/2,
                        child: TextField(
                          onChanged: (containercommand){
                            //cmd = containercommand;
                          },
                        ),
                      ),
                      Container(child: Text('Input name of container to get the ip:', style: TextStyle(fontWeight: FontWeight.w400, height: 1.5, fontSize: 17),),),
                      Row(
                        children: <Widget>[
                          Container(
                            height: pageheight/8,
                            width: pagewidth/2,
                            child: TextField(
                              onChanged: (containercommand){
                                //cmd = containercommand;
                              },
                            ),
                          ),
                        ],
                      ),
                      /*Container(child: Text('Input name of container to be created:', style: TextStyle(color: Colors.white),),),
                      Container(
                        height: pageheight/8,
                        width: pagewidth/2,
                        child: TextField(
                          onChanged: (containercommand){
                            //cmd = containercommand;
                          },
                        ),
                      ),*/
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
    );
  }
}

/*class SamplePage extends StatefulWidget {
  @override
  _SamplePageState createState() => _SamplePageState();
}

class _SamplePageState extends State<SamplePage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
  padding: const EdgeInsets.all(8),
  children: <Widget>[
    Container(
      height: 50,
      color: Colors.amber[600],
      child: const Center(child: Text('Entry A')),
    ),
    Container(
      height: 50,
      color: Colors.amber[500],
      child: const Center(child: Text('Entry B')),
    ),
    Container(
      height: 50,
      color: Colors.amber[100],
      child: const Center(child: Text('Entry C')),
    ),
  ],
);
  }
}*/