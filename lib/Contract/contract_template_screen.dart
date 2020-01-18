import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pdftron_flutter/pdftron_flutter.dart';

class TemplatePage extends StatefulWidget {
  @override
  _TemplatePageState createState() => _TemplatePageState();
}

class _TemplatePageState extends State<TemplatePage> {
  String _Rcontract = "https://data2.unhcr.org/fr/documents/download/44320";
  String _Rcontract2 =
      "https://jordan-lawyer.com/wp-content/uploads/2018/10/%D9%86%D9%85%D9%88%D8%B0%D8%AC-%D8%B9%D9%82%D8%AF-%D8%A7%D9%8A%D8%AC%D8%A7%D8%B1-%D8%B4%D9%82%D8%A9-%D8%A8%D9%8A%D8%AA-%D9%88%D9%81%D9%82%D8%A7-%D9%84%D8%A3%D8%AD%D8%AF%D8%AB-%D8%A7%D9%84%D8%AA%D8%B9%D8%AF%D9%8A%D9%84%D8%A7%D8%AA-2018-%D9%88-2019.pdf";
  String _Scontract = "https://www.almaal.org/wp-content/uploads/2019/10/%D9%86%D9%85%D9%88%D8%B0%D8%AC_%D8%B9%D9%82%D8%AF_%D8%A7%D9%8A%D8%AC%D8%A7%D8%B1_%D9%85%D8%AD%D9%84.pdf";
  String _Scontract2 = '‪file:///C:/Users/HP/Downloads/%D8%B9%D9%82%D8%AF-%D8%A5%D9%8A%D8%AC%D8%A7%D8%B1-%D8%B4%D9%82%D8%A9-%D8%B3%D9%83%D9%86%D9%8A%D8%A9.htm';
  String _Scontract3 = "http://www.alexcham.org/Media/Files/%D8%B9%D9%82%D8%AF%20%D8%A5%D9%8A%D8%AC%D8%A7%D8%B1%20%D9%85%D8%AD%D9%84%20%D8%AA%D8%AC%D8%A7%D8%B1%D9%89%20%D8%A8%D9%83%D8%A7%D9%85%D9%84.pdf";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFEBEDEF),
        elevation: 0,

        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => {Navigator.pop(context)}),
        title: Text("Contract Templates"),
        actions: <Widget>[

          IconButton(
              icon: Icon(FontAwesomeIcons.ellipsisV),
              onPressed: () {
                //
              }),
        ],
      ),
      // First List
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height - 60.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width - 40.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Color(0xff5a348b),
                    gradient: LinearGradient(
                        colors: [Color(0xff8d70fe), Color(0xff2da9ef)],
                        begin: Alignment.centerRight,
                        end: Alignment(-1.0, -1.0)), //Gradient
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          //Text
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Text(
                                'Residential Contract',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          //subText
                          //Circle Avatar
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0, bottom: 20),
                            child: Container(
                                width: 130.0,
                                height: 110.0,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      child:Icon(
                                        (Icons.home),
                                        size: 50,

                                      ),
                                    ),

                                  ],
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 40.0),
                            child: Container(
                              height: 50,
                              width: 200,
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

                              ),
                              child: GestureDetector(
                                onTap: () => PdftronFlutter.openDocument(_Rcontract),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: IconButton(
                                        icon: Icon(Icons.picture_as_pdf),
                                        iconSize: 20,
                                        color: Colors.black45,
                                        onPressed: () => PdftronFlutter.openDocument(_Rcontract2),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Template 1',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black45,
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
                            padding: const EdgeInsets.only(top: 40.0),
                            child: Container(
                              height: 50,
                              width: 200,
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

                              ),
                              child: GestureDetector(
                                onTap: () => PdftronFlutter.openDocument(_Rcontract),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: IconButton(
                                        icon: Icon(Icons.picture_as_pdf),
                                        iconSize: 20,
                                        color: Colors.black45,
                                        onPressed: () => PdftronFlutter.openDocument(_Rcontract),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Template 2',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black45,
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
                            padding: const EdgeInsets.only(top: 40.0),
                            child: Container(
                              height: 50,
                              width: 200,
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

                              ),
                              child: GestureDetector(
                                onTap: () => PdftronFlutter.openDocument(_Rcontract2),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: IconButton(
                                        icon: Icon(Icons.picture_as_pdf),
                                        iconSize: 20,
                                        color: Colors.black45,
                                        onPressed: () => PdftronFlutter.openDocument(_Rcontract2),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Template 3',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black45,
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
                    ],
                  ),
                ),
              ),
              // Second List
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width - 40.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Color(0xff5a348b),
                    gradient: LinearGradient(
                        colors: [Color(0xffebac38), Color(0xffde4d2a)],
                        begin: Alignment.centerRight,
                        end: Alignment(-1.0, -2.0)), //Gradient
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Text(
                                'Office Contract',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          //subText
                          //Circle Avatar
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0, bottom: 20),
                            child: Container(
                                width: 130.0,
                                height: 110.0,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      child:Icon(
                                         (Icons.desktop_windows),
                                        size: 50,

                                      ),
                                    ),

                                  ],
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 40.0),
                            child: Container(
                              height: 50,
                              width: 200,
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

                              ),
                              child: GestureDetector(
                                onTap: () => PdftronFlutter.openDocument(_Scontract2),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: IconButton(
                                        icon: Icon(Icons.picture_as_pdf),
                                        iconSize: 20,
                                        color: Colors.black45,
                                        onPressed: () => PdftronFlutter.openDocument(_Scontract2),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Template 1',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black45,
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
                            padding: const EdgeInsets.only(top: 40.0),
                            child: Container(
                              height: 50,
                              width: 200,
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

                              ),
                              child: GestureDetector(
                                onTap: () => PdftronFlutter.openDocument(_Rcontract),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: IconButton(
                                        icon: Icon(Icons.picture_as_pdf),
                                        iconSize: 20,
                                        color: Colors.black45,
                                        onPressed: () => PdftronFlutter.openDocument(_Rcontract),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Template 2',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black45,
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
                            padding: const EdgeInsets.only(top: 40.0),
                            child: Container(
                              height: 50,
                              width: 200,
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

                              ),
                              child: GestureDetector(
                                onTap: () => PdftronFlutter.openDocument(_Rcontract),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: IconButton(
                                        icon: Icon(Icons.picture_as_pdf),
                                        iconSize: 20,
                                        color: Colors.black45,
                                        onPressed: () => PdftronFlutter.openDocument(_Rcontract),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Template 3',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black45,
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
                        ],
                      )
                ),
              ),
              //Third List
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    width: MediaQuery.of(context).size.width - 40.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Color(0xff5a348b),
                      gradient: LinearGradient(
                          colors: [ Color(0xff11998e), Color(0xff38ef7d)],
                          begin: Alignment.centerRight,
                          end: Alignment(-1.0, -2.0)
                      ), //Gradient
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: Text(
                                  'Office Contract',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            //subText
                            //Circle Avatar
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0, bottom: 20),
                              child: Container(
                                  width: 130.0,
                                  height: 110.0,
                                  decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        child:Icon(
                                          (Icons.desktop_windows),
                                          size: 50,

                                        ),
                                      ),

                                    ],
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 40.0),
                              child: Container(
                                height: 50,
                                width: 200,
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

                                ),
                                child: GestureDetector(
                                  onTap: () => PdftronFlutter.openDocument(_Rcontract),
                                  child: Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: IconButton(
                                          icon: Icon(Icons.picture_as_pdf),
                                          iconSize: 20,
                                          color: Colors.black45,
                                          onPressed: () => PdftronFlutter.openDocument(_Rcontract),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Template 1',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black45,
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
                              padding: const EdgeInsets.only(top: 40.0),
                              child: Container(
                                height: 50,
                                width: 200,
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

                                ),
                                child: GestureDetector(
                                  onTap: () => PdftronFlutter.openDocument(_Rcontract),
                                  child: Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: IconButton(
                                          icon: Icon(Icons.picture_as_pdf),
                                          iconSize: 20,
                                          color: Colors.black45,
                                          onPressed: () => PdftronFlutter.openDocument(_Rcontract),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Template 2',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black45,
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
                              padding: const EdgeInsets.only(top: 40.0),
                              child: Container(
                                height: 50,
                                width: 200,
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

                                ),
                                child: GestureDetector(
                                  onTap: () => PdftronFlutter.openDocument(_Rcontract),
                                  child: Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: IconButton(
                                          icon: Icon(Icons.picture_as_pdf),
                                          iconSize: 20,
                                          color: Colors.black45,
                                          onPressed: () => PdftronFlutter.openDocument(_Rcontract),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Template 3',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black45,
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
                      ],
                    )
                ),
              ),
                    ],
                  ),
                ),
              ),
          );
  }
}
