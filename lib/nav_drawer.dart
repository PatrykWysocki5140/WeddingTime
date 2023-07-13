import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wedding_time/constants.dart';

import 'package:wedding_time/notifiers/LanguageNotifier.dart';
import 'package:wedding_time/pages/home/home_page.dart';

import 'widgets/app_version.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});
//const AppVersion(),
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Semantics(
            child: const DrawerHeader(
              decoration: BoxDecoration(
                color: kPrimaryColor,
              ),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AppVersion(),
                    SizedBox(height: 25),
                    Text(
                      'Menu',
                      style: TextStyle(color: kTextColor, fontSize: 30),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 6.0),
            child: Column(
              children: [
                const SizedBox(
                  height: kDefaultPaddingNavBar,
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: Text(AppLocalizations.of(context)!.myAccount),
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => HomePage()))
                  },
                ),
                const SizedBox(
                  height: kDefaultPaddingNavBar,
                ),
                Consumer<LanguageNotifier>(
                  builder: (context, languages, child) => ListTile(
                    leading: const Icon(Icons.language),
                    title: Text(AppLocalizations.of(context)!.changeLanguage),
                    onTap: () => {
                      languages.getLang().then((value) => {
                            if (value == "pl")
                              {
                                languages.setLang('en'),
                                languages.currentLanguage = "en",
                              }
                            else
                              {
                                languages.setLang('pl'),
                                languages.currentLanguage = "pl",
                              }
                          }),
                    },
                  ),
                ),
                const SizedBox(
                  height: kDefaultPaddingNavBar,
                ),
                ListTile(
                  leading: const Icon(Icons.exit_to_app),
                  title: Text(AppLocalizations.of(context)!.logout),
                  onTap: () => {signOut(context)},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

signOut(BuildContext context) {}
