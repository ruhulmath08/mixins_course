import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;
import 'dart:io';
import 'package:meta/meta.dart';
import 'dart:convert';

extension Log on Object {
  void log() => devtools.log(toString());
}

extension GetOnUri on Object {
  Future<HttpClientResponse> getUrl(String url) =>
      HttpClient().getUrl(Uri.parse(url)).then((req) => req.close());
}

mixin CanMakeGetCall {
  String get url;

  @useResult
  Future<String> getString() =>
      getUrl(url).then((resp) => resp.transform(utf8.decoder).join());
}

@immutable
class GetPeople with CanMakeGetCall{
  const GetPeople();

  @override
  String get url => 'http://127.0.0.1:5500/apis/people.json';
  
}

void testIt() async{
  final people = await const GetPeople().getString();
  people.log();
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    testIt();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Home Page',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
