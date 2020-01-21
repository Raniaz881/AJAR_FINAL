
import 'package:flutter/material.dart';
import 'package:flutter_app/Friend_function/contracts.dart';
import 'package:flutter_app/Friend_function/friends.dart';
import 'package:flutter_app/Friend_function/requests.dart';



class SocialScreen extends StatefulWidget {


  @override
  _SocialScreenState createState() => _SocialScreenState();
}

class _SocialScreenState extends State<SocialScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF50A0A0),

          bottom:   TabBar(
            tabs: [

            //  Tab(icon: Icon(Icons.person_add),text: "Send Proposal",),

              Tab(icon: Icon(Icons.add_alert),text: 'Requests',),
              Tab(icon: Icon(Icons.person),text: 'Friends',),
              Tab(icon: Icon(Icons.library_books),text: "Contracts",),
            ],
            indicatorColor: Colors.grey,
            indicatorWeight: 5.0,
          ),
        ),

        body: TabBarView(
          children: <Widget>[

            //SendProposal(),

            RequestScreen(),
            FriendsScreen(),
            ContractScreen(),
          ],
        ),
      ),
    );
  }
}
