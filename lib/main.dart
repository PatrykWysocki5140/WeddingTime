import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:wedding_time/constants.dart';
import 'package:wedding_time/notifiers/admin.dart';
import 'package:wedding_time/styles/style.dart';
import 'notifiers/LanguageNotifier.dart';
import 'pages/root/root.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:wedding_time/pages/login/authentication_bloc.dart';
import '../../../widgets/loading/loading_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
                ChangeNotifierProvider(create: (context) => AdminNotifier()),
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
  Widget build(BuildContext context) => Consumer<AdminNotifier>(
      builder: (context, admin, child) =>
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
