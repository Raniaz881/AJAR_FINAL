import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/AddProperty/addProperty.dart';



class RequestForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF607D8B),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () => print('Arrow Back Ios'),
                  padding: EdgeInsets.symmetric(vertical: 30.0),
                  icon: Icon(Icons.arrow_back_ios),
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'Enter Your Data ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 25.0,
                        fontFamily: 'Raleway',
                      ),
                    ),
                    Text(
                      'Your Information should be correct',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.0,
                          fontFamily: 'Raleway'),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 30.0,
                    right: 30.0,
                    top: 25.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 2.0,
                      ),
                      Text(
                        'ID Number ',
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        height: 60.0,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: 14.0),
                            prefixIcon: Icon(
                              Icons.credit_card,
                              color: Colors.white,
                            ),
                            hintText: 'Enter ID Number',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Passport Number ',
                            style: TextStyle(
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            height: 60.0,
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              // The validator receives the text that the user has entered.
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },

                              style: TextStyle(
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: 14.0),
                                prefixIcon: Icon(
                                  Icons.book,
                                  color: Colors.white,
                                ),
                                hintText: 'Enter Passport Number',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Kin Numbers ',
                                style: TextStyle(
                                  fontFamily: 'Raleway',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                height: 60.0,
                                child: TextFormField(
                                  keyboardType: TextInputType.phone,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(top: 14.0),
                                    prefixIcon: Icon(
                                      Icons.phone,
                                      color: Colors.white,
                                    ),
                                    hintText: 'Enter kin Number',
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                height: 60.0,
                                child: TextField(
                                  keyboardType: TextInputType.phone,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(top: 14.0),
                                    prefixIcon: Icon(
                                      Icons.phone,
                                      color: Colors.white,
                                    ),
                                    hintText: 'Enter Other kin Number',
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Bank Number ',
                                    style: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    height: 60.0,
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please enter some text';
                                        }
                                        return null;
                                      },
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                      decoration: InputDecoration(
                                        contentPadding:
                                        EdgeInsets.only(top: 14.0),
                                        prefixIcon: Icon(
                                          Icons.call_to_action,
                                          color: Colors.white,
                                        ),
                                        hintText: 'Enter Yout Bank Number',
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      FlatButton(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 100.0,
                                              vertical: 20.0),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(15.0),
                                              side: BorderSide(
                                                color: Colors.white30,
                                              )),
                                          color: Colors.blue,
                                          child: Text(
                                            'Next',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Raleway',
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          onPressed: () {
                                            // Validate returns true if the form is valid, otherwise false.
                                            if (_formKey.currentState.validate()) {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                        return AddProperty();
                                                      }));
                                            }
                                          })
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}