import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:wedding_time/constants.dart';
import 'package:wedding_time/styles/style.dart';
import 'notifiers/LanguageNotifier.dart';
import 'pages/root/root.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:wedding_time/pages/login/authentication_bloc.dart';
import '../../../widgets/loading/loading_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //runApp(const MyApp());
  /*
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) {
    // Get.put<AuthController>(AuthController());
    // Get.put<UserController>(UserController());
  });*/

  runApp(FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        return (MultiRepositoryProvider(
            providers: [
              RepositoryProvider(create: (_) => AuthenticationBloc()),
              RepositoryProvider(create: (_) => LoadingCubit()),
            ],
            child: MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (context) => LanguageNotifier()),
              ],
              child: const WeddingApp(),
            )));
      }));
}

class WeddingApp extends StatefulWidget {
  const WeddingApp({Key? key}) : super(key: key);

  @override
  WeddingAppState createState() => WeddingAppState();
}

class WeddingAppState extends State<WeddingApp> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) => Consumer<LanguageNotifier>(
      builder: (context, measurements, child) =>
          Consumer<LanguageNotifier>(builder: (context, languages, child) {
            var lang = Provider.of<LanguageNotifier>(context);
            String language = 'en';
            return FutureBuilder(
                future: lang.getLang().then(
                      (value) => language = value.toString(),
                    ),
                builder: (context, AsyncSnapshot snapshot) {
                  return MaterialApp(
                    //return GetMaterialApp(
                    localizationsDelegates: const [
                      AppLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    supportedLocales:
                        languages.languages.entries.map((e) => Locale(e.key)),
                    locale: Locale(language),
                    //Locale(languages.language.key),
                    debugShowCheckedModeBanner: false,
                    title: kAppName,
                    theme: theme(context),
                    home: const RootPage(),
                  );
                });
          }));
}
/*
void main() async {
  if (kIsWeb || defaultTargetPlatform == TargetPlatform.macOS) {
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ); /*
    await FacebookAuth.i.webAndDesktopInitialize(
      appId: facebookAppID,
      cookie: true,
      xfbml: true,
      version: "v15.0",
    );*/
  }
  runApp(MultiRepositoryProvider(
    providers: [
      RepositoryProvider(create: (_) => AuthenticationBloc()),
      RepositoryProvider(create: (_) => LoadingCubit()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> with WidgetsBindingObserver {
  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      if (kIsWeb) {
        await Firebase.initializeApp(options: DefaultFirebaseOptions.web);
      } else {
        await Firebase.initializeApp();
      }
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Show error message if initialization failed
    if (_error) {
      return MaterialApp(
          home: Scaffold(
        body: Container(
          color: Colors.white,
          child: Center(
              child: Column(
            children: const [
              Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 25,
              ),
              SizedBox(height: 16),
              Text(
                'Failed to initialise firebase!',
                style: TextStyle(color: Colors.red, fontSize: 25),
              ),
            ],
          )),
        ),
      ));
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return Container(
        color: Colors.white,
        child: const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      );
    }

    return MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
          scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBarTheme:
              const AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.dark),
          snackBarTheme: const SnackBarThemeData(
              contentTextStyle: TextStyle(color: Colors.white)),
          colorScheme: ColorScheme.fromSwatch().copyWith(
              secondary: const Color(colorPrimary),
              brightness: Brightness.light),
        ),
        darkTheme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: Colors.grey.shade800,
            appBarTheme: const AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle.light),
            snackBarTheme: const SnackBarThemeData(
                contentTextStyle: TextStyle(color: Colors.white)),
            colorScheme: ColorScheme.fromSwatch().copyWith(
                secondary: const Color(colorPrimary),
                brightness: Brightness.dark)),
        debugShowCheckedModeBanner: false,
        color: const Color(colorPrimary),
        home: const LauncherScreen());
  }

  @override
  void initState() {
    super.initState();
    initializeFlutterFire();
  }
}
*/