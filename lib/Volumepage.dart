import 'package:flutter/material.dart';
import 'package:Docker/main.dart';
import 'package:http/http.dart' as http;


class DockerVolume extends StatefulWidget {
  @override
  _DockerVolumeState createState() => _DockerVolumeState();
}

class _DockerVolumeState extends State<DockerVolume> {
  var webdata;
  var deletecontainer;
  var inspectcontainer;
  var os;
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
      body: Column(
          children: <Widget>[
            
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(child: Text('Input name of container to be created with centos operating system:', style: TextStyle(color: Colors.white),),),
                      Container(
                        margin: EdgeInsets.all(20),
                        child: TextField(
                          onChanged: (name){
                            addcontainer = name;
                          },
                        ),
                      ),
                      FloatingActionButton.extended(
                      label: Text('Submit'),
                      onPressed: (){
                        Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Containerop()));
                        //create(addcontainer)
                      },),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(webdata ?? 'Output'),
                      ),
                      Container(child: Text('Input name of container to be deleted:', style: TextStyle(color: Colors.white),),),
                      Container(
                        height: pageheight/8,
                        width: pagewidth/2,
                        child: TextField(
                          onChanged: (name){
                            deletecontainer = name;
                          },
                        ),
                      ),
                      Container(child: Text('Input name of container to be inspected:', style: TextStyle(color: Colors.white),),),
                      Container(
                        height: pageheight/8,
                        width: pagewidth/2,
                        child: TextField(
                          onChanged: (containercommand){
                            //cmd = containercommand;
                          },
                        ),
                      ),
                      Container(child: Text('Input name of container to get the ip:', style: TextStyle(color: Colors.white),),),
                      Container(
                        height: pageheight/8,
                        width: pagewidth/2,
                        child: TextField(
                          onChanged: (containercommand){
                            //cmd = containercommand;
                          },
                        ),
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
