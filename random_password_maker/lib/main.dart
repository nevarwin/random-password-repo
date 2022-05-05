import 'dart:math';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Password Generator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  String generatePassword({
    bool? hasUppers,
    bool? hasNumbers,
    bool? hasSpecials,
  }) {
    const lowerCase = 'abcdefghijklmnopqrstuvwxyz';
    const upperCase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const numbers = '1234567890';
    const special = '@#=+\$%&?(){}';
    const length = 20;

    String chars = '';
    chars += lowerCase;
    if (hasUppers!) chars += upperCase;
    if (hasNumbers!) chars += numbers;
    if (hasSpecials!) chars += special;

    return List.generate(
      length,
      (index) {
        final indexRandom = Random().nextInt(chars.length); //0..25

        return chars[indexRandom];
      },
    ).join('');
  }

  @override
  Widget build(BuildContext context) {
    bool hasUpper = false;
    bool hasNumber = false;
    bool hasSpecial = false;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Random Password Generator'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Random Password Generator',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5.0),
              TextField(
                controller: controller,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'Generated Password',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.copy),
                    onPressed: () {
                      // Copying generated password to the clipboard
                      final data = ClipboardData(text: controller.text);
                      Clipboard.setData(data);

                      const snackBar = SnackBar(
                        content: Text(
                          'Password Copied',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                      ScaffoldMessenger.of(context)
                        ..removeCurrentSnackBar()
                        ..showSnackBar(snackBar);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 5.0),
              // Upper case Button
              ElevatedButton(
                onPressed: () {
                  hasUpper = !hasUpper;
                },
                child: const Text('UpperCase'),
              ),
              const SizedBox(height: 5.0),
              // Number Button
              ElevatedButton(
                onPressed: () {
                  hasNumber = !hasNumber;
                },
                child: const Text('Number'),
              ),
              const SizedBox(height: 5.0),
              // Special Button
              ElevatedButton(
                onPressed: () {
                  hasSpecial = !hasSpecial;
                },
                child: const Text('Special'),
              ),
              const SizedBox(height: 12.0),
              ElevatedButton(
                onPressed: () {
                  final password = generatePassword(
                    hasUppers: hasUpper,
                    hasNumbers: hasNumber,
                    hasSpecials: hasSpecial,
                  );
                  controller.text = password;
                },
                child: const Text('Generate Password'),
                style: ElevatedButton.styleFrom(primary: Colors.black),
              ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
