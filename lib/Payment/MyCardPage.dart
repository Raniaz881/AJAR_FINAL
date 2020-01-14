import 'dart:math';
import 'package:flutter_app/Payment/card_back.dart';
import 'package:flutter_app/Payment/card_front.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'dialog.dart';




class MyCardsPage extends StatefulWidget {

  @override
  _MyCardsPageState createState() => _MyCardsPageState();
}

class _MyCardsPageState extends State<MyCardsPage>
    with SingleTickerProviderStateMixin {
 // double _rotationFactor = 0;
  AnimationController _flipAnimationController;
  Animation<double> _flipAnimation;
  TextEditingController _cardNumberController,
      _cardHolderNameController,
      _cardExpiryController,



      _cvvController;

  FocusNode _cvvFocusNode;
  String _cardNumber = '';
  String _cardHolderName = '';
  String _cardExpiry = '';
  String _cvvNumber = '';



  _MyCardsPageState() {

    _cardNumberController = TextEditingController();
    _cardHolderNameController = TextEditingController();
    _cardExpiryController = TextEditingController();
    _cvvController = TextEditingController();
    _cvvFocusNode = FocusNode();


    _cardNumberController.addListener(onCardNumberChange);
    _cardHolderNameController.addListener(() {
      _cardHolderName = _cardHolderNameController.text;
      setState(() {});
    });
    _cardExpiryController.addListener(() {
      _cardExpiry = _cardExpiryController.text;
      setState(() {});
    });
    _cvvController.addListener(() {
      _cvvNumber = _cvvController.text;
      setState(() {});
    });


    _cvvFocusNode.addListener(() {
      _cvvFocusNode.hasFocus
          ? _flipAnimationController.forward()
          : _flipAnimationController.reverse();
    });

  }

  @override
  void initState() {
    super.initState();
    _flipAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 350));
    _flipAnimation =
    Tween<double>(begin: 0, end: 1).animate(_flipAnimationController)
      ..addListener(() {
        setState(() {});
      });
//    _flipAnimationController.forward();
  }

  void onCardNumberChange() {
    _cardNumber = _cardNumberController.text;
    setState(() {});
  }
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        backgroundColor: Color(0xFF006d6d),
        elevation: 0,
        iconTheme: IconThemeData (
        color: Colors.white,
          size: 40,
        ),
      ),
      body: Form(
        key: _formKey,
        child: Stack(
          children: <Widget>[

          Container(
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30) ),
              color: Color(0xFF006d6d),
            ),

          ),

          Column(

            children: <Widget>[
              Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(pi * _flipAnimation.value),
                origin: Offset(MediaQuery.of(context).size.width / 2, 0),
                child: _flipAnimation.value < 0.5
                    ? CardFrontView(
                  cardNumber: _cardNumber,
                  cardHolderName: _cardHolderName,
                  cardExpiry: _cardExpiry,

                )
                    : CardBackView(
                  cvvNumber: _cvvNumber,
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(16),
                  height: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(

                      children: <Widget>[
//                      Slider(
//                        onChanged: (double value) {
//                          setState(() {
//                            _rotationFactor = value;
//                          });
//                        },
//                        value: _rotationFactor,
//                      ),
                        TextFormField(
                          controller: _cardNumberController,
                          maxLength: 16,
                          decoration: InputDecoration(
                            hintText: 'Card Number',
                          ),
                          validator: (val){
                            if (val.isEmpty){
                              return 'Required Feild';
                            }
                            return null;
                            },
                        ),

                        TextFormField(
                          controller: _cardHolderNameController,
                          maxLength: 16,
                          decoration: InputDecoration(
                            hintText: 'Card Holder Name',
                          ),
                          validator: (val){
                            if (val.isEmpty){
                              return 'Required Feild';
                            }
                            return null;
                          },
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: TextFormField(
                                controller: _cardExpiryController,
                                maxLength: 3,
                                decoration: InputDecoration(
                                  hintText: 'Expiry Date',
                                ),
                                validator: (val){
                                  if (val.isEmpty){
                                    return 'Required Feild';
                                  }
                                  return null;
                                },
                              ),
                            ),

                            Expanded(
                              flex: 1,
                              child: TextFormField(
                                focusNode: _cvvFocusNode,
                                controller: _cvvController,
                                maxLength: 3,

                                decoration: InputDecoration(
                                    counterText: '', hintText: 'CVV'),
                                validator: (val){
                                  if (val.isEmpty){
                                    return 'Required Feild';

                                  }
                                  return null;
                                },
                              ),

                            ),

                          ],

                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Container(
                            decoration: ShapeDecoration(
                              shape: StadiumBorder(),
                            ),
                            child: FloatingActionButton.extended

                              (
                              onPressed: () async{
                                if(_formKey.currentState.validate()){
                                  final action = await Dialogs.yesAbortDialog(context , 'Proceed Payment', 'Do yo wish to proceed the payment?');

                                }
                              },
                              backgroundColor: Color(0xFF006d6d),
                              icon: Icon(
                                FontAwesomeIcons.amazonPay,
                                color: Colors.white,
                              ),
                              label: Text(
                                "Continue",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),

                          ),
                        ),
                      ],

                    ),
                  ),
                ),
              ),
            ],
          ),
],
        ),
      ),
    );
  }
}
