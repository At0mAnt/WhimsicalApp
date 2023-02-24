import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tcp_socket_connection/tcp_socket_connection.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Whimsical App',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF0B0707),
      ),
      home: const MyHomePage(title: 'WHIMSICAL APP'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TcpSocketConnection socketConnection = TcpSocketConnection("192.168.4.1", 80);

  String message = "";

  bool click = true;
  bool startRobots = true;

  @override
  void initState() {
    super.initState();
  }

  //receiving and sending back a custom message
  void messageReceived(String msg) {
    setState(() {
      message = msg;
    });
    socketConnection.sendMessage("MessageIsReceived :D ");
  }

  //starting the connection and listening to the socket asynchronously
  void startConnection() async {
    socketConnection.enableConsolePrint(
        true); //use this to see in the console what's happening
    if (await socketConnection.canConnect(5000, attempts: 3)) {
      //check if it's possible to connect to the endpoint
      await socketConnection.connect(5000, messageReceived, attempts: 3);
      showInSnackBar("Connected!");
    } else {
      showInSnackBar("Connection Problem!");
    }
  }

  void stopConnection() async {
    socketConnection.disconnect();
    showInSnackBar("Disconnected!");
  }

  void showInSnackBar(String value) {
    ScaffoldMessenger.of(context)
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
        primary: Colors.green, textStyle: const TextStyle(fontSize: 80));
    ButtonStyle style2 = ElevatedButton.styleFrom(
        primary: Colors.green, textStyle: const TextStyle(fontSize: 80));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xc80a6000),
        title: Text(
          widget.title,
          textScaleFactor: 2,
        ),
        toolbarHeight: 70,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 50),
            ElevatedButton(
              style: style,
              onPressed: () {
                startConnection();
              },
              child: const Text('Connect'),
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      click = !click;
                      startRobots = !startRobots;
                      if (socketConnection.isConnected()) {
                        if (startRobots) {
                          socketConnection.sendMessage("boyofoporo");
                          showInSnackBar("boyofoporo sended!");
                        } else {
                          socketConnection.sendMessage("bcycfcpcrc");
                          showInSnackBar("bcycfcpcrc sended!");
                        }
                      }
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                        //if (states.contains(MaterialState.pressed)) {
                        if (!startRobots) {
                          return Colors.redAccent;
                        } else {
                          return Colors.greenAccent;
                        } // Defer to the widget's default.
                      },
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text((startRobots == true) ? ('START') : ('STOP'),
                        textScaleFactor: 5),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
