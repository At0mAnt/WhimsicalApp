import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


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

  bool click = true;

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
    ElevatedButton.styleFrom(primary: Colors.green, textStyle: const TextStyle(fontSize: 80));
    ButtonStyle  style2=
    ElevatedButton.styleFrom(primary: Colors.green,textStyle: const TextStyle(fontSize: 80));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xc80a6000),
        title: Text(widget.title, textScaleFactor: 2,),
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
              onPressed: () {},
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
                    });
                  },

                  style:


                  ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed))
                          return Colors.redAccent;

                        else {
                          return Colors.greenAccent;
                        }// Defer to the widget's default.
                      },
                    ),
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text((click == false) ? ('START') : ('STOP'), textScaleFactor: 5),

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
