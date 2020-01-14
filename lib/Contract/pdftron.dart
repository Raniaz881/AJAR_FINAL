
library pdftron;
import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pdftron_flutter/pdftron_flutter.dart';
import 'package:permission_handler/permission_handler.dart';



class Contract extends StatefulWidget {
  @override
  _ContractState createState() => _ContractState();
}

class _ContractState extends State<Contract> {

  String _contract = "https://data2.unhcr.org/fr/documents/download/44320";
  String _contract2 = "https://jordan-lawyer.com/wp-content/uploads/2018/10/%D9%86%D9%85%D9%88%D8%B0%D8%AC-%D8%B9%D9%82%D8%AF-%D8%A7%D9%8A%D8%AC%D8%A7%D8%B1-%D8%B4%D9%82%D8%A9-%D8%A8%D9%8A%D8%AA-%D9%88%D9%81%D9%82%D8%A7-%D9%84%D8%A3%D8%AD%D8%AF%D8%AB-%D8%A7%D9%84%D8%AA%D8%B9%D8%AF%D9%8A%D9%84%D8%A7%D8%AA-2018-%D9%88-2019.pdf";
  String _contract3 ="https://docs.google.com/document/d/1qBfNq4I036TuJ1UXwLf1EpbSWniGsh3LEuTeLxEcJVU/edit";


  @override
  void initState() {
    super.initState();
    initPlatformState();

    if (Platform.isIOS) {
      // Open the document for iOS, no need for permission
      showViewer();

    } else {
      // Request for permissions for android before opening document
      launchWithPermission();
    }
  }

  Future<void> launchWithPermission() async {
    Map<PermissionGroup, PermissionStatus> permissions = await PermissionHandler().requestPermissions([PermissionGroup.storage]);
    if (granted(permissions[PermissionGroup.storage])) {
      showViewer();
    }
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String version;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      PdftronFlutter.initialize("your_pdftron_license_key");
      version = await PdftronFlutter.version;
    } on PlatformException {
      version = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      var _version = version;
    });
  }
Material Item(IconData icon, String heading, int color , String document){
    return Material(
      color: Colors.white,
      elevation: 12.0,
      shadowColor: Colors.grey,
      borderRadius: BorderRadius.circular(20),
      child: GestureDetector(
        onTap: () => PdftronFlutter.openDocument(document),
        child: Container(

          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                     Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(heading,
                      style: TextStyle(
                        color: new Color(color),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                  Material(
                    color: new Color(color),
                    borderRadius: BorderRadius.circular(24.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        icon,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),


                ],
              ),
            ),
          ),
        ),
      ),
    );
}

  void showViewer() {
    // shows how to disable functionality
    //  var disabledElements = [Buttons.shareButton, Buttons.searchButton];
    //  var disabledTools = [Tools.annotationCreateLine, Tools.annotationCreateRectangle];
      var config = Config();

     // config.disabledElements = disabledElements;
     // config.disabledTools = disabledTools;
      config.multiTabEnabled = true;




      //PdftronFlutter.openDocument(_document, config: config);

    // opening without a config file will have all functionality enabled.

  }

  bool granted(PermissionStatus status) {
    return status == PermissionStatus.granted;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Contract Templates'),
          actions: <Widget>[
            IconButton (
                icon: Icon ( Icons.picture_as_pdf ) ,
              onPressed: () => PdftronFlutter.openDocument(_contract),
            ) ,
          ],
        ),
        body: StaggeredGridView.count(
                crossAxisCount: 2,
            crossAxisSpacing: 14.0,
            scrollDirection: Axis.vertical,
            mainAxisSpacing: 12.0,

              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              children: <Widget>[

                Item(Icons.home, "Residential Contract", 0xFFB2DFDB, _contract),
                Item(Icons.desktop_windows, "Office Contract", 0xFFB2DFDB, _contract2),
                Item(Icons.shopping_cart, "Shop Contract", 0xFFB2DFDB, _contract3),
              ],
              staggeredTiles: [

                StaggeredTile.extent(1,150.0),
                StaggeredTile.extent(1,150.0),
                StaggeredTile.extent(1,150.0),
              ],
            ),
        ),


    );
  }

}