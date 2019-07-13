import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:sensegrass/homepage.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class loginpage extends StatefulWidget {
  @override
  _loginpageState createState() => _loginpageState();
}

  //Login page which will trigger after the splash screen
  //If the user is already loggedIn they will be redirected directly to the homepage (Remaining)

class _loginpageState extends State<loginpage> {

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Key value storage like MAP in java
  final storage = new FlutterSecureStorage();

  var user_id;
  var user_email;
  var user_name;
  var user_profile;
  var user_sessionid;

  //google sign in part 
  //It is linked with my firebase account
  //Might have to change it with the compant's account

  Future<FirebaseUser> _handlegoogleSignIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    Navigator.push(context, MaterialPageRoute(builder: (context)=>mainhomepage()));

    final FirebaseUser user = await _auth.signInWithCredential(credential);

    user_sessionid = googleAuth.accessToken;
    user_name = googleUser.displayName;
    user_email = googleUser.email;
    user_profile = googleUser.photoUrl;

    // It will store the data like shared preferences in key value pair
    // It will store the session id / access token so that user doesnot have to login again and again 
    await storage.write(key: 'session-key', value: '$user_sessionid');
    await storage.write(key: 'user-name', value: '$user_name');
    await storage.write(key: 'user-email', value: '$user_email');
    await storage.write(key: 'user-image', value: '$user_profile');

    print("signed in " + user.displayName);
    return null;
  }
  //google sign-in part ends



  //twitter api-key and secret-key 
  //It is also linked with my twitter account
  //Might have to change with the company's twitter account.
    Future<FirebaseUser> _loginWithTwitter() async {
      var twitterLogin = new TwitterLogin(
        consumerKey: 'RJuHNmCNKx3FDanlG0AFeQfsk',
        consumerSecret: '5UMj7QVGHkXpbCIx8SKjS5ofEWlR7ds6DNqPJBmuXuFy97rYNH',
      );
      

      final TwitterLoginResult result = await twitterLogin.authorize();

      switch (result.status) {
        case TwitterLoginStatus.loggedIn:
          var session = result.session;

          final AuthCredential credential = TwitterAuthProvider.getCredential(
            authToken: session.token,
            authTokenSecret: result.session.secret,
          );

          FirebaseUser user = await _auth.signInWithCredential(credential);

          user_name = result.session.username;
          user_profile =
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRi-I5E9Vn6dFsuJnrJfJVcpNp6KNQ74ZSjKoGn5t9-pGLddxDG';
          user_id = result.session.userId;
          user_sessionid = result.session.token;
          print('twitter name :${result.session.username}');
          print('twitter name :${result.session.userId}');
          print('${result.session.token}');

          // It is same as the above key value pair
          // But instead of google session id it will store twitter session id

          await storage.write(key: 'session-key', value: '$user_sessionid');
          await storage.write(key: 'user-name', value: '$user_name');
          await storage.write(key: 'user-image', value: '$user_profile');

          Navigator.push(context, MaterialPageRoute(builder: (context)=>mainhomepage()));

          return user;
          break;
        case TwitterLoginStatus.cancelledByUser:
          debugPrint(result.status.toString());
          return null;
          break;
        case TwitterLoginStatus.error:
          debugPrint(result.errorMessage.toString());
          return null;
          break;
      }
      return null;
    }
    //Twitter sign-in part ends here

    // UI part of the login page is remaining
    // Have to lookup at Internet for some inspiration

    // Facebook login remaining, might be in future

    // Email and password login is remaining
    // For that I need access to the company's database

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // get_session_token();
  }

  // This function will check whether there is session stored or not
  // If it found session id it will redirect the user to homepage
  // If session id will not found user will be in the login page
  // Future get_session_token() async{
  //   var session_token = await storage.read(key: 'session-key');
  //   if(session_token.isNotEmpty){
  //     print('session id exist :$session_token');
  //     Navigator.push(context, MaterialPageRoute(builder: (context)=>mainhomepage()));
  //   } 
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
      resizeToAvoidBottomPadding: true,
      
      body: ListView(
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.all(30.0),
          ),
          Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                // Companies Logo (Sensegrass)
                // which will resize itself according to the screensize

                new Container(
                  width: MediaQuery.of(context).size.width-80.0,
                  child: new Image.asset('asset/logo.png'),
                ),

                // Email textField
                // TextField for email with email keyboard 

                Padding(
                  padding: const EdgeInsets.only(left:8.0, right: 8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    autofocus: false,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      contentPadding: EdgeInsets.fromLTRB(20.0, 13.0, 20.0, 13.0),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                    ),
                  ),
                ),
                SizedBox(height: 8.0),

                // Password TextField
                // TextField for password with obsecureText which will display text in stars

                Padding(
                  padding: const EdgeInsets.only(left:8.0, right: 8.0),
                  child: TextFormField(
                    autofocus: false,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      contentPadding: EdgeInsets.fromLTRB(20.0, 13.0, 20.0, 13.0),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                    ),
                  ),
                ),
                SizedBox(height: 24.0),

                // Login Button
                // This is login button code which will take the email and password with is inputed in the respected textfield
                // This part is remaining

                Container(
                  width: 200,
                  height: 50.0,
                  child: new InkWell(
                    onTap: () {
                      print('login via email and password remaining');
                    },
                    child: Material(
                      borderRadius: BorderRadius.circular(25.0),
                      color: Colors.deepPurpleAccent,
                      shadowColor: Colors.deepPurpleAccent.withOpacity(0.8),
                      elevation: 7.0,
                      child: Center(
                        child: new Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // When user will click on this flatbutton they will redirect to the forgot password page
                // where they will have to provide some proff that the account is indeed their's
                FlatButton(
                  child: Text(
                    'Forgot password?',
                    style: TextStyle(color: Colors.black54),
                  ),
                  onPressed: () {
                    builder:(){
                      theme: ThemeData.dark();
                    };
                  },
                ),

                new Padding(
                  padding: new EdgeInsets.all(5.0),
                ),

                // This Row contains SignIn with Google and Twitter button
                // This Row is used because every app uses google and twitter login button in same line

                new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    // Google Login Button
                    // Initially this button is linked to my account but might have to change in future

                    Container(
                      width: MediaQuery.of(context).size.width-200,
                      height: 50.0,
                      child: new InkWell(
                        onTap: () {
                          _handlegoogleSignIn();
                        },
                        child: Material(
                          borderRadius: BorderRadius.circular(25.0),
                          color: Colors.redAccent,
                          shadowColor: Colors.redAccent.withOpacity(0.8),
                          elevation: 7.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Icon(
                                LineIcons.google,
                                color: Colors.white,
                              ),
                              new Text(
                                ' | Google',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    new Padding(
                      padding: new EdgeInsets.all(10.0),  
                    ),

                    // Twitter Login Button 
                    // Simiral to the Google login Twitter login is also linked to my account.

                    Container(
                      width: MediaQuery.of(context).size.width-200,
                      height: 50.0,
                      child: new InkWell(
                        onTap: () {
                          _loginWithTwitter();
                        },
                        child: Material(
                          borderRadius: BorderRadius.circular(25.0),
                          color: Colors.lightBlue,
                          shadowColor: Colors.lightBlue.withOpacity(0.8),
                          elevation: 7.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Icon(
                                LineIcons.twitter,
                                color: Colors.white,
                              ),
                              new Text(
                                ' | Twitter',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    ),
    );
  }
}