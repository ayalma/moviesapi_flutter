import 'package:flutter/material.dart';
import 'package:moviesapi_flutter/config/localizations.dart';
import 'package:moviesapi_flutter/datasource/api/movie_api.dart';
import 'package:moviesapi_flutter/repository/movieRepository.dart';
import 'package:moviesapi_flutter/ui/movie_list_bloc.dart';
import 'package:moviesapi_flutter/ui/movie_list_page.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// This is our global ServiceLocator
GetIt getIt = new GetIt();

void main() {
  getIt.registerLazySingleton<MovieApi>(
    () => MovieApi(),
  );

  getIt.registerLazySingleton<MovieRepository>(
    () => MovieRepository(getIt.get()),
  );

  getIt.registerLazySingleton(
    () => MovieListBloc(getIt.get()),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        locale: Locale('fa'),
        localizationsDelegates: [
          AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: [Locale("fa"), Locale("en")],
        onGenerateTitle: (BuildContext context) =>
        AppLocalizations.of(context).title,

        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.blue,
          buttonTheme: ButtonThemeData(
            splashColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
        ),
        showSemanticsDebugger: false,
        home: MovieListPage());
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
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
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
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
