import 'package:flutter/material.dart';

class CardFrontView extends StatelessWidget {

  final String cardNumber;
  final String cardHolderName;
  final String cardExpiry;


  String _formattedCardNumber;
  String _formattedExpiryDate;

  CardFrontView(
      {Key key, this.cardNumber, this.cardHolderName, this.cardExpiry})
      : super(key: key) {
    _formattedCardNumber = this.cardNumber.padRight(16, '*');
    _formattedCardNumber = _formattedCardNumber.replaceAllMapped(
        RegExp(r".{4}"), (match) => "${match.group(0)} ");

    _formattedExpiryDate =
       this.cardExpiry.replaceAllMapped(RegExp(r".{2}"), (match) => "${match.group(0)}/");



  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 300,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Color(0xFF003232),
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              offset: Offset(7,10),
              blurRadius: 12,
            ),
          ],
        ),

        margin: EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Align(
                  alignment: Alignment.topLeft,
                  child: Image.asset('assets/images/master.png',width: 65,)),

              SizedBox(
                height: 26,
              ),
              Text('Card Number',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Roboto',
                ),
              ),

              Text(
                _formattedCardNumber,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontFamily: 'Roboto',
                  letterSpacing: 2,
                  wordSpacing: 2,
                  fontWeight: FontWeight.w500,
                  shadows: [
                    Shadow(color: Colors.black12, offset: Offset(2, 1))
                  ],
                ),
              ),



              SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Card Holder',
                          style: TextStyle(
                            color: Colors.white,
                          ) ,),
                        Text(
                          cardHolderName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 2,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Expiry',
                      style: TextStyle(
                        color: Colors.white,
                      ) ,
                      ),
                      Text(
                        _formattedExpiryDate,
                        style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 2,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}