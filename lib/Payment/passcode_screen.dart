
import 'package:flutter/material.dart';
import 'package:flutter_app/Payment/MyCardPage.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:passcode_screen/circle.dart';
import 'package:passcode_screen/keyboard.dart';
import 'package:passcode_screen/passcode_screen.dart';



class User {
  final String name, amount, date;

  const User({
    this.name,
    this.amount,
    this.date,
  });
}
class ReceiptPage extends StatefulWidget {
  @override
  _ReceiptPageState createState() => _ReceiptPageState();
}

class _ReceiptPageState extends State<ReceiptPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


class PassCodeScreen extends StatefulWidget {
 
  PassCodeScreen({Key key, this.title}) : super(key: key);
  final String title;


  @override
  _PassCodeScreenState createState() => new _PassCodeScreenState();

}
var _nameController = new TextEditingController();
var _amountController = new TextEditingController();
var _dateController = new TextEditingController();

class _PassCodeScreenState extends State<PassCodeScreen> {
  //payment amount
  TextEditingController _amountController;
  String _amount = '' ;

  _RecieptState(){
    _amountController = TextEditingController();

    _amountController.addListener((){
      _amount = _amountController.text;
      setState(() {});

    }
    );
  }

  //Date Picker
  DateTime _date = new DateTime.now ();
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: new DateTime(2020),
        lastDate: new DateTime(2021)
    );

    if(picked != null && picked != _date) {
      print('Date selected: $_date');
      setState((){
        _date = picked;
      });
    }
  }


  final StreamController<bool> _verificationNotifier =
  StreamController<bool>.broadcast();

  bool isAuthenticated = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[

             Padding(
               padding: const EdgeInsets.all(40.0),

               child: Column(
                 children: <Widget>[

                   new RaisedButton(
                       child: new Text('Select Todays Date',
                         style: TextStyle(
                           fontFamily: 'nunito',
                         ),
                   ),onPressed: (){
                     _selectDate(context);

                   }),
                   new Text('Date selected: ${_date.toString()}',
                   style: TextStyle(
                     fontSize: 15,
                     fontFamily: 'nunito',
                   ),),
                 ],
               ),
             ),
             SizedBox(height: 10,),
             new TextFormField(
               controller: _amountController,
               decoration: InputDecoration(
                 hintText: 'Enter Amount',
               ),
               validator: (val){
                 if (val.isEmpty){
                   return 'Required Feild';
                 }
                 return null;
               },

             ),
             Center(

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
            //      Text('You are ${isAuthenticated ? '' : 'NOT'} authenticated'),
                  _defaultLockScreenButton(context),



                ],
              ),
            ),
          ],

        ),
      ),
    );
  }

  _defaultLockScreenButton(BuildContext context) => MaterialButton(
    color: Theme.of(context).primaryColor,
    child: Text('Enter Passcode'),
    onPressed: ()async {


      if(_formKey.currentState.validate()){
        _showLockScreen(context, opaque: false);
      }
    },
  );


  _showLockScreen(BuildContext context,
      {bool opaque,
        CircleUIConfig circleUIConfig,
        KeyboardUIConfig keyboardUIConfig}) {
    Navigator.push(
      context,
      PageRouteBuilder(
        opaque: opaque,
        pageBuilder: (context, animation, secondaryAnimation) =>
            PasscodeScreen(
              title: 'Enter App Passcode',
              circleUIConfig: circleUIConfig,
              keyboardUIConfig: keyboardUIConfig,
              passwordEnteredCallback: _onPasscodeEntered,
              cancelLocalizedText: 'Cancel',
              deleteLocalizedText: 'Delete',
              shouldTriggerVerification: _verificationNotifier.stream,
              backgroundColor: Colors.black.withOpacity(0.8),
              cancelCallback: _onPasscodeCancelled,
            ),
      ),
    );
  }

  _onPasscodeEntered(String enteredPasscode) {
    bool isValid = '123456' == enteredPasscode;
    _verificationNotifier.add ( isValid );
    if (isValid) {
      setState ( () {
        this.isAuthenticated = isValid;
      } );
    }
    if (isAuthenticated = true) {
      Navigator.push ( context ,
          MaterialPageRoute ( builder: (context) => MyCardsPage ( ) ) );
    }
  }


  _onPasscodeCancelled() {}


  @override
  void dispose() {
    _verificationNotifier.close();
    super.dispose();
  }
}

