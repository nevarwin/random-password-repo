import 'dart:math';
import 'dart:math';
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
      home: const MyHomePage(title: 'Flutter Random Password Generator'),
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
  int submittedNum = 0;
  final numberController = TextEditingController();

  var generated = '';
  // final _alpha = 'abcdefghijklmnopqrstuvwxyz';
  int generateRandomNumber() {
    return Random().nextInt(9);
  }

  String generateRandomString(int length) {
    final _random = Random();
    const _availableChars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    final randomString = List.generate(
      length,
      (index) => _availableChars[_random.nextInt(_availableChars.length)],
    ).join();
    // print(_availableChars.length);
    generated = randomString;
    return randomString;
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(generateRandomString(10));
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Generated:',
            ),
            Text(
              generated,
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('UpperCase'),
            ),
            const SizedBox(
              height: 8.0,
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Number'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 80,
                child: TextField(
                  controller: numberController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Length',
                    hintText: 'Enter number',
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            ElevatedButton(
              onPressed: () {
                generateRandomString(10);
              },
              child: const Text('Generate'),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
