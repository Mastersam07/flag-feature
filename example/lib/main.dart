import 'package:flutter/material.dart';

import 'feature_flag.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isCounterEnabled = false;
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      if (isCounterEnabled) {
        _counter++;
      }
    });
  }

  void retrieveFeatureFlag() {
    SampleAppFeatureFlag.getInstance.fireFlag
        .featureFlagSubscription()
        .listen((newValue) {
      setState(() {
        isCounterEnabled = newValue.featureIsEnabled('counter');
      });
    });
  }

  @override
  void initState() {
    super.initState();
    retrieveFeatureFlag();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              isCounterEnabled
                  ? 'You have pushed the button this many times:'
                  : 'The counter feature is disabled',
            ),
            isCounterEnabled
                ? Text(
                    '$_counter',
                    style: Theme.of(context).textTheme.headline4,
                  )
                : SizedBox(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
