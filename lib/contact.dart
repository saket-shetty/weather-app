import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'login/login.dart';

class contact extends StatefulWidget {
  @override
  _contactState createState() => _contactState();
}

class _contactState extends State<contact> {

  // These are the textfield controller same as .getString in java
  // Future work: _email and _name will get from the login page so that user doesnot have to type again
  // the data will be transfer using the flutter secure store
  // eg. var email = await storage.read(key: 'user-email');
  TextEditingController _email,_name,_subject,_message = new TextEditingController();
  final storage = new FlutterSecureStorage();
  String user_email, user_name;
  var name= 'saket';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_email_name();
  }

  Future get_email_name() async{
    var ret_user_email = await storage.read(key: 'user-email');
    var ret_user_name = await storage.read(key: 'user-name');
    print(ret_user_email);
    print(ret_user_name);
    setState((){
      user_email = ret_user_email;
      user_name = ret_user_name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,

      //App bar of the contact page

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

      // Body of the contact page

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

                // Textfield of the email which will be autofill

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

                // Textfield of the name which will be autofill

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

                // Textfield of the subject

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

                // Textfield of the message

                new TextFormField(
                  controller: _message,
                  maxLines: 10,
                  decoration: InputDecoration(
                    hintText: 'Message',
                    labelText: "Enter Message",
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                  ),
                ),
                SizedBox(height: 8.0),

                // Submit button which will take all the data from the text controller
                // Button will not worl since there is no ontap function is given to it
                // Future: using GestureDetection or InkWell and onTap:

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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}