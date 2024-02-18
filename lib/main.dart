import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

void main(List<String> args) {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dio = Dio();
  final translator = GoogleTranslator();
  final List<String> _catFacts = [];

  Future<void> getCatFact() async {
    const url = 'https://catfact.ninja/fact';
    final response = await dio.get(url);
    final catFact = response.data['fact'];
    var translation = await translator.translate(catFact, from: 'en', to: 'ru');
    _catFacts.add(translation.toString());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Translated API ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            const Center(
              child: Text(
                'Cat Facts',
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 350,
              decoration: BoxDecoration(
                color: const Color.fromARGB(
                  255,
                  168,
                  85,
                  201,
                ),
                border: Border.all(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: ListView.builder(
                itemCount: _catFacts.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return ListTile(
                      title: Text(
                    _catFacts[index],
                  ));
                },
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    getCatFact();
                  },
                  child: const Text('Press me'),
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    _catFacts.clear();
                    setState(() {});
                  },
                  child: const Text(
                    'Clear Facts',
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
