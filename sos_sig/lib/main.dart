import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sos_sig/blocs/blocs.dart';
import 'package:sos_sig/screens/historial.dart';
import 'package:sos_sig/screens/screens.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sos_sig/services/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {
    runApp(MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GpsBloc()),
        BlocProvider(create: (context) => LocationBloc()),
        BlocProvider(
            create: (context) =>
                MapBloc(locationBloc: BlocProvider.of<LocationBloc>(context))),
        BlocProvider(
            create: (context) => SearchBloc(trafficService: TrafficService())),
      ],
      child: AppState(),
    ));
  });
}

class AppState extends StatefulWidget {
  @override
  _AppStateState createState() => _AppStateState();
}

class _AppStateState extends State<AppState> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => AlarmaService()),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SOS UAGRM',
        initialRoute: 'login',
        routes: {
          'login': (_) => LoginScreen(),
          'register': (_) => RegisterScreen(),
          'home': (_) => HomeScreen(),
          'loading': (_) => LoadingScreen(),
          'historial': (_) => HistorialScreen(),
        },
        theme: ThemeData.light());
  }
}
