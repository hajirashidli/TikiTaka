//pubspec has http and images imported
import 'package:flutter/material.dart';
import 'dart:async'; //for original json
import 'package:http/http.dart' as http; //for original json
import 'dart:convert'; //for original json

void main(){
  runApp(
    MaterialApp(home: MyHomePage())
  );
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  //whole things mode 1
  Future<List<Match>> _getMatches() async{ //
    var data = await http.get("http://www.json-generator.com/api/json/get/cfjRYzTePS?indent=2"); //
    var jsonData = json.decode(data.body); //

    List<Match> matches = []; //

    for(var u in jsonData){ //
      Match match = Match(u["index"], u["time"], u["area"], u["date"]); //
      matches.add(match); //
    }

    print(matches.length); //

    return matches;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gələcək oyunlar"),
      ),
      body: Container(
       child: FutureBuilder(
        future: _getMatches(),
        builder: (BuildContext context, AsyncSnapshot snapshot){

          if(snapshot.data==null){
            return Container(
              child: Center(
                child: Text("Loading...")
              ),
            );
          } else{
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index){
                return Card(
                  //child: InkWell(
                    child: ListTile(
                    leading: Icon(Icons.location_on, color: Colors.blue, size: 35.0),
                    title: Text(snapshot.data[index].area),
                    subtitle: Text(snapshot.data[index].date),
                    trailing: //Text(snapshot.data[index].time, style: new TextStyle(fontWeight: FontWeight.bold) 
                        new Column(
                          children: <Widget>[
                            Text('', style: new TextStyle(fontWeight: FontWeight.bold,)),
                            Text(snapshot.data[index].time, style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
                            Text('', style: new TextStyle(fontSize: 11.0)),
                          ]
                        ),

                    onTap: () {
                      Navigator.push(context, 
                      new MaterialPageRoute(builder: (context) => DetailPage(snapshot.data[index]))
                      );
                    },
                    )   
                );
            }
            );
          }
        },
      ),
      )
    );
  }
}

class Match{
  final int index;
  final String time;
  final String area;
  final String date;

  Match(this.index, this.time, this.area, this.date);
}


class DetailPage extends StatelessWidget {

 final Match match;
 DetailPage(this.match);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 277,
                floating: false,
                title: const Text("Details"),
                pinned: true,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.redAccent,
                          Colors.blueAccent
                        ]),
                  ),
                  child: FlexibleSpaceBar(
                    centerTitle: true,
                    background: Image.asset(
                      "path/to/image",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ];
          },
          body: DefaultTabController(
            length: 3,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                  left: 7, right: 7),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[

                    TabBar(
                        labelStyle: TextStyle(fontSize: 12),
                        labelColor: Colors.blue,
                        unselectedLabelColor: Colors.black45,
                        indicatorColor: Colors.blue,
                        tabs: [
                          Tab(
                            text: "Contact Info",
                            icon: Icon(Icons.info),
                          ),
                          Tab(
                            text: "Details",
                            icon: Icon(Icons.details),
                          ),
                          Tab(
                            text: "Mapppppppp",
                            icon: Icon(Icons.map),
                          ),
                        ]),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 20),
                        child: TabBarView(children: [ //important
                          //1ST TAB
                          Column(
                            children: <Widget>[
                            RaisedButton.icon(
                              onPressed: () {
                                print('joined the game');
                              },
                              icon: Icon(
                                Icons.mail
                              ),
                              label: Text('Join Match'),
                              color: Colors.amber,
                            ),


                            new Expanded(
                              child: GridView.count(
                                primary: false,
                                padding: const EdgeInsets.all(20),
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                crossAxisCount: 2,
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    child: const Text("He'd have you all unravel at the"),
                                    color: Colors.teal[100],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    child: const Text('Heed not the rabble'),
                                    color: Colors.teal[200],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    child: const Text('Sound of screams but the'),
                                    color: Colors.teal[300],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    child: const Text('Who scream'),
                                    color: Colors.teal[400],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    child: const Text('Revolution is coming...'),
                                    color: Colors.teal[500],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    child: const Text('Revolution, they...'),
                                    color: Colors.teal[600],
                                  ),
                                  ],
                                ),
                            )
                            ],
                          ),

                          //2ND TAB
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            child: Column(
                              children: <Widget>[
                                //some text widgets here
                              ],
                            ),
                          ),

                          //3RD TAB
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            // child: ListView(
                            //   children: <Widget>[
                            //     Text("hello"),
                            //     Column(children: ["demo","demo1","demo","demo1","demo","demo1","demo","demo1","2222","123333"].map((f)=> ExpansionTile(title: Text(f),)).toList(),),
                            //      ],
                            // )
                          ),
                        ]), // this will render tab bar and its contents
                      ),
                    ),
                    Container(
                      height: 10,
                      color: Colors.redAccent, //other widgets here
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  } 
}
