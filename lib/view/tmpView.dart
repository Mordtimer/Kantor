import 'package:flutter/material.dart';

class tmpView extends StatelessWidget {
  tmpView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Padding(
      padding: EdgeInsets.fromLTRB(30, 0, 30, 15),
      child: Container(
        child: new Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: new Text(
                  "Books",
                  style: Theme.of(context).textTheme.headline4,
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 500.0,
                  child: ListView(
                    children: [
                      ListTile(
                        title: Text("Text 1 "),
                      ),
                      ListTile(
                        title: Text("Text 2 "),
                      ),
                      ListTile(
                        title: Text("Text 3 "),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              FloatingActionButton.extended(
                foregroundColor: Colors.black,
                onPressed: () {},
                icon: Icon(Icons.add),
                label: Text('floating button'),
              ),
            ]),
      ),
    )));
  }
}
