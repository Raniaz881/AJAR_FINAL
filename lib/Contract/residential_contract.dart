import 'package:flutter/material.dart';

import 'package:pdftron_flutter/pdftron_flutter.dart';

class ResidentialContract extends StatelessWidget {
  String _contract = "https://data2.unhcr.org/fr/documents/download/44320";
  String _contract2 = "https://jordan-lawyer.com/wp-content/uploads/2018/10/%D9%86%D9%85%D9%88%D8%B0%D8%AC-%D8%B9%D9%82%D8%AF-%D8%A7%D9%8A%D8%AC%D8%A7%D8%B1-%D8%B4%D9%82%D8%A9-%D8%A8%D9%8A%D8%AA-%D9%88%D9%81%D9%82%D8%A7-%D9%84%D8%A3%D8%AD%D8%AF%D8%AB-%D8%A7%D9%84%D8%AA%D8%B9%D8%AF%D9%8A%D9%84%D8%A7%D8%AA-2018-%D9%88-2019.pdf";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Container(
              height: 60,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xFFEBEDEF),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black45,
                    offset: Offset(7, 10),
                    blurRadius: 12,
                  ),
                ],
                border: Border.all(
                  color: Color(0xFF05B7B7),
                ),
              ),
              child: GestureDetector(
                onTap: () => PdftronFlutter.openDocument(_contract),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: IconButton(
                        icon: Icon(Icons.picture_as_pdf),
                        iconSize: 30,
                        color: Color(0xFF05B7B7),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Template 1',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF05B7B7),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Container(
              height: 80,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xFFEBEDEF),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black45,
                    offset: Offset(7, 10),
                    blurRadius: 12,
                  ),
                ],
                border: Border.all(
                  color: Color(0xFF05B7B7),
                ),
              ),
              child: GestureDetector(
                onTap: () => PdftronFlutter.openDocument(_contract),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: IconButton(
                        icon: Icon(Icons.picture_as_pdf),
                        iconSize: 30,
                        color: Color(0xFF05B7B7),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Template 2',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF05B7B7),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Container(
              height: 80,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xFFEBEDEF),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black45,
                    offset: Offset(7, 10),
                    blurRadius: 12,
                  ),
                ],
                border: Border.all(
                  color: Color(0xFF05B7B7),
                ),
              ),
              child: GestureDetector(
                onTap: () => PdftronFlutter.openDocument(_contract2),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: IconButton(
                        icon: Icon(Icons.picture_as_pdf),
                        iconSize: 30,
                        color: Color(0xFF05B7B7),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Template 3',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF05B7B7),
                          fontWeight: FontWeight.bold,
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
    );
  }
}
