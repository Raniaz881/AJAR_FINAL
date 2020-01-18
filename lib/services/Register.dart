import 'package:flutter_app/main.dart';
import 'package:flutter_app/services/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/services/Sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth.dart';
import 'database.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();   // a key to relate all the info in the databasse
  bool loading = false;
  AuthService _auth = new AuthService();

  TextEditingController emailController = new TextEditingController();
  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();

  // text field state
  String email = '';
  String password = '';
  String error = '';
  String number = '';
  String fname = '';
  String lname = '';

  void _showSuccessDialog() {
    showDialog(context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: new Text('Account Created!'),
            content: new Text("Please check your email to verify your account to continue using our app"),
            actions: <Widget>[
              new FlatButton(onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));
              }, child: Text('Dismiss'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Form(
            key: _formKey,  // the key of the form which you can collect all the form info once and insert it into a database for example
            child: Column(
              children: <Widget>[
                SizedBox(height: 1.0),
                Image.asset('assets/logo.png'), // logo of the page
                Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 30.0),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                      hintText: "Enter your Email",
                      filled: true,
                      fillColor: Colors.lightGreen[50],
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.green[300], width: 3.0),
                        borderRadius: new BorderRadius.circular(25.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.green[500], width: 3.0),
                        borderRadius: new BorderRadius.circular(25.0),
                      )),
                  validator: (val) => val.isEmpty ? 'Enter an email' : null, //checking whether he entered an email or not
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: phoneController,
                  decoration: InputDecoration(
                      hintText: "Enter your Number",  //  text inside the textfield
                      filled: true,    // to activate the light green color  inside the textfield
                      fillColor: Colors.lightGreen[50],
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.green[300], width: 3.0), // color of the border of the textfield
                        borderRadius: new BorderRadius.circular(25.0),       // the circular edges of the textfield
                      ),
                      focusedBorder: OutlineInputBorder(        // when the focus is on the properties of the textfield
                        borderSide:
                        BorderSide(color: Colors.green[500], width: 3.0), // color is a little bit darker
                        borderRadius: new BorderRadius.circular(25.0),     // border remains the same when focus is on
                      )),
                  validator: (val) =>
                  val.length < 6 ? 'Enter a number 6+ chars long' : null,// checking whether he entered a number with 6 chars + or not
                  onChanged: (val) {
                    setState(() => number = val);
                  },
                ),
                SizedBox(height: 20.0),

                TextFormField(
                  controller: firstNameController,
                  decoration: InputDecoration(
                      hintText: "Enter your First Name",
                      filled: true,
                      fillColor: Colors.lightGreen[50],
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.green[300], width: 3.0),
                        borderRadius: new BorderRadius.circular(25.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.green[500], width: 3.0),
                        borderRadius: new BorderRadius.circular(25.0),
                      )),
                  validator: (val) =>
                  val.length < 3 ? 'Enter a First Name' : null,
                  onChanged: (val) {
                    setState(() => fname = val);
                  },
                ),
                SizedBox(height: 20.0),

                TextFormField(
                  controller: lastNameController,
                  decoration: InputDecoration(
                      hintText: "Enter your Last Name",
                      filled: true,
                      fillColor: Colors.lightGreen[50],
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.green[300], width: 3.0),
                        borderRadius: new BorderRadius.circular(25.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.green[500], width: 3.0),
                        borderRadius: new BorderRadius.circular(25.0),
                      )),
                  validator: (val) =>
                  val.length < 6 ? 'Enter Your Last Name' : null,
                  onChanged: (val) {
                    setState(() => lname = val);
                  },
                ),
                SizedBox(height: 20.0),

                TextFormField(
                  controller: passController,
                  decoration: InputDecoration(
                      hintText: "Enter your Password",
                      filled: true,
                      fillColor: Colors.lightGreen[50],
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.green[300], width: 3.0),
                        borderRadius: new BorderRadius.circular(25.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.green[500], width: 3.0),
                        borderRadius: new BorderRadius.circular(25.0),
                      )),
                  obscureText: true,
                  validator: (val) =>
                  val.length < 6 ? 'Enter a password 6+ chars long' : null,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                    color: Colors.green[400],
                    child: Text(
                      'Register',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async{
                      if(_formKey.currentState.validate()){
                        dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                        print('Created User Successfully');
                        _auth.sendEmailVerification();
                        print('Email Sent Successfully');
                        if(result != null && result is User) {
                         await DatabaseService(uid: result.uid).updateUserData(
                           email: emailController.text,
                           pass: passController.text,
                           firstName: firstNameController.text,
                           lastName: lastNameController.text,
                           phoneNumber: phoneController.text,
                         );
                          await fatehPreferences.setString('myUID', result.uid);
                         await fatehPreferences.setString('nickname', firstNameController.text);
                         print('Updated User Data Successfully');
                         _showSuccessDialog();
                        }else {
                          setState(() {
                            error = 'Failed to Update User Data';
                          });
                        }
                      }
                    }
                ),
                SizedBox(height: 22.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Do have an account?',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    RawMaterialButton(
                        splashColor: Colors.green,
                        textStyle: TextStyle(color: Colors.black),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              ' Login now  ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.green),
                            ),
                            Icon(Icons.person_add)
                          ],
                        ),
                        onPressed: () {// when the Login word is pressed the user is navigated to the SignIn Page
                          Navigator.push(  //
                            context,
                            MaterialPageRoute(builder: (context) => SignIn()),
                          );
                        }
                    ),
                  ],
                ),
                SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
