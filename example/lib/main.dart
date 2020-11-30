import 'package:fire_flag/fire_flag.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final features = Features(features: [
    /// On the Firebase Remote Config server, this 'counter' config is set to
    /// 'true' value. So if the counter feature is enabled when the sample app
    /// is launched, the Fire Flag plugin is working.
    Feature(
      name: 'counter',
      isEnabled: false,
    ),
  ]);

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
  final fireFlag = FireFlag(
    features: MyApp.features,
    fetchExpirationDuration: Duration(seconds: 0),
  );

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
    widget.fireFlag.featureFlagSubscription().listen((features) {
      setState(() {
        isCounterEnabled = features.featureIsEnabled('counter');
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
