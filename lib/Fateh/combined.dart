import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/Fateh/contracts.dart';
import 'package:flutter_app/Fateh/friends.dart';
import 'package:flutter_app/Fateh/requests.dart';
import 'package:flutter_app/Fateh/sendPropasal.dart';


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
          backgroundColor: Colors.deepPurple,
          title: Text('Challenge'),
          bottom:   TabBar(
            tabs: [
              Tab(icon: Icon(Icons.control_point),text: "Contracts",),
            //  Tab(icon: Icon(Icons.person_add),text: "Send Proposal",),
              Tab(icon: Icon(Icons.person),text: 'Friend',),
              Tab(icon: Icon(Icons.record_voice_over),text: 'Requests',)
            ],
            indicatorColor: Colors.pink,
            indicatorWeight: 5.0,
          ),
        ),

        body: TabBarView(
          children: <Widget>[
            ContractScreen(),
            //SendProposal(),
            FriendsScreen(),
            RequestScreen(),
          ],
        ),
      ),
    );
  }
}
