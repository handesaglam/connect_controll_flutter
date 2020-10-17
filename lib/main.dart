import 'dart:async';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Internet connectivity',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  StreamSubscription<DataConnectionStatus> listener;

  var Internetstatus = "Unknown";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    _updateConnectionStatus();
    CheckInternet();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    listener.cancel();
    super.dispose();
  }


  CheckInternet() async {
    // Simple check to see if we have internet
    print("The statement 'this machine is connected to the Internet' is: ");
    print(await DataConnectionChecker().hasConnection);
    _onBasicAlertPressed(context);
    // returns a bool

    // We can also get an enum instead of a bool
    print("Current status: ${await DataConnectionChecker().connectionStatus}");
    // prints either DataConnectionStatus.connected
    // or DataConnectionStatus.disconnected

    // This returns the last results from the last call
    // to either hasConnection or connectionStatus
    print("Last results: ${DataConnectionChecker().lastTryResults}");

    // actively listen for status updates
    listener = DataConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case DataConnectionStatus.connected:
          Internetstatus="Connectd TO THe Internet";
          print('Data connection is available.');
          setState(() {

          });
          break;
        case DataConnectionStatus.disconnected:
          Internetstatus="No Data Connection";
          print('You are disconnected from the internet.');
          setState(() {

          });
          break;
      }
    });

    // close listener after 30 seconds, so the program doesn't run forever
//    await Future.delayed(Duration(seconds: 30));
//    await listener.cancel();
    return await await DataConnectionChecker().connectionStatus;
  }



  _onBasicAlertPressed(context) {
    Alert(
      context: context,
      title: "RFLUTTER ALERT",
      desc: "$Internetstatus",
    ).show();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Connection Checker"),
      ),
      body: Container(
        child: Center(
          child: Text("$Internetstatus"),
        ),
      ),
    );
  }
}
