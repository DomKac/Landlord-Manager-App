import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:app/database/dao/plot_dao.dart';
import 'package:app/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'database/dao/object_dao.dart';
import 'database/models/ObjectModel.dart';
import 'database/models/PlotModel.dart';
import 'database/repositories/ObjectDAORepository.dart';
import 'package:get_it/get_it.dart';
import 'database/database.dart';
import 'database/repositories/PlotDAORepository.dart';

void main()  {
    GetIt getIt = GetIt.instance;
    getIt.registerSingletonAsync(
      () async => $FloorAppDatabase.databaseBuilder('gardencommanderdatabase.db').build()
    );

    getIt.registerSingletonWithDependencies<PlotDAO>(() {
      return GetIt.instance.get<AppDatabase>().plotDao;
    }, dependsOn: [AppDatabase]);
    getIt.registerSingletonWithDependencies<ObjectDAO>(() {
      return GetIt.instance.get<AppDatabase>().objectDao;
    }, dependsOn: [AppDatabase]);

    getIt.registerSingletonWithDependencies<PlotDAORepository>(
            () => PlotDAORepository(),
        dependsOn: [AppDatabase, PlotDAO]);
    getIt.registerSingletonWithDependencies<ObjectDAORepository>(
            () => ObjectDAORepository(),
        dependsOn: [AppDatabase, ObjectDAO]);

    runApp(MaterialApp(
    home: FutureBuilder(
        future: GetIt.instance.allReady(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.hasData){
            return const MyApp();
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        })));

  }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PlotModel>(
            create: (_) => PlotModel()
        ),
        ChangeNotifierProvider<ObjectModel>(
            create: (_) => ObjectModel()
        ),
      ],
      child: AdaptiveTheme(
      light: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.green,
          primarySwatch: Colors.green,
          shadowColor: Colors.green,
          splashColor: Colors.green,
          accentColor: Colors.amber,
          scaffoldBackgroundColor: Colors.white,
          bottomAppBarTheme: const BottomAppBarTheme(color: Colors.green),
          iconTheme: const IconThemeData(color: Color.fromARGB(255, 1, 60, 22))),
      dark: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.green,
          primarySwatch: Colors.green,
          shadowColor: Colors.green,
          splashColor: Colors.green,
          accentColor: Colors.amber,
          scaffoldBackgroundColor: Colors.black,
          bottomAppBarTheme:
              const BottomAppBarTheme(color: Color.fromARGB(255, 1, 41, 2)),
          iconTheme: const IconThemeData(color: Colors.green)),
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Garden Commander',
          theme: theme,
          darkTheme: darkTheme,
          initialRoute: '/home_screen',
          routes: {
            '/home_screen': (context) => HomeScreen(),
          }),
    )
    );
  }
}

class AppTheme {}
