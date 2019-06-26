import 'package:flutter/material.dart';

class contact extends StatefulWidget {
  @override
  _contactState createState() => _contactState();
}

class _contactState extends State<contact> {

  TextEditingController _email,_name,_subject,_message = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      appBar: new AppBar(
        title: new Text('Contact',
          style: new TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w300,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: SingleChildScrollView(
          child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 8.0),
                new Text("Have any question? We'd love to hear from you"),
                SizedBox(height: 8.0),
                new Text('Send and query',
                  style: new TextStyle(
                    color: Colors.deepPurpleAccent,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                new TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _email,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                  ),
                ),
                SizedBox(height: 8.0),
                new TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _name,
                  decoration: InputDecoration(
                    hintText: 'name',
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                  ),
                ),
                SizedBox(height: 8.0),
                new TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _subject,
                  decoration: InputDecoration(
                    hintText: 'subject',
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                  ),
                ),
                SizedBox(height: 8.0),
                new Text(
                  'Your Message',
                  style: new TextStyle(
                    color: Colors.deepPurpleAccent,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                new TextFormField(
                  controller: _message,
                  maxLines: 10,
                  decoration: InputDecoration(
                    hintText: 'name',
                    labelText: "Enter Message",
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                  ),
                ),
                SizedBox(height: 8.0),
                new Center(
                  child: new Container(
                    width: 120,
                    height: 50,
                    child: Center(
                      child: new Text('Submit',
                        style: new TextStyle(
                          color: Colors.white,
                          fontSize: 18.0
                        ),
                      ),
                    ),
                    decoration: new BoxDecoration(
                      color: Colors.deepPurpleAccent,
                      borderRadius: new BorderRadius.circular(25.0)
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}