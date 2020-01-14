import 'package:flutter/material.dart';
import 'package:flutter_app/services/Sign_in.dart';
import 'auth.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {

  final _formKey = GlobalKey<FormState>();
  AuthService _auth = new AuthService();
  TextEditingController emailController = new TextEditingController();

  void _showSuccessDialog() {
    showDialog(context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: new Text('Password Changed!'),
            content: new Text("Please check your email"),
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
                  "Reset Password",
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
                    //setState(() => email = val);
                  },
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                    color: Colors.green[400],
                    child: Text(
                      'Reset Password',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async{
                      if(_formKey.currentState.validate()){
                        _auth.resetPassword(emailController.text);
                        _showSuccessDialog();
                      }

                    }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
