import 'package:connectivity_listener/connectivity_listener.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  String _connection = "AWAITING CONNECTION...";
  final _connectionListener = ConnectionListener();

  @override
  void initState() {
    super.initState();
    _connectionListener.init(
      onConnected: () => _showSnackbar("CONNECTED"),
      onReconnected: () => _showSnackbar("RECONNECTED"),
      onDisconnected: () => _showSnackbar("DISCONNECTED"),
    );
  }

  @override
  void dispose() {
    _connectionListener.dispose();
    super.dispose();
  }

  void _showSnackbar(String text) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    var snackBar = SnackBar(content: Text(text));

    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    setState(() {
      _connection = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text(_connection),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
