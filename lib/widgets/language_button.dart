// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:wedding_time/constants.dart';
import 'package:wedding_time/notifiers/LanguageNotifier.dart';

class LanguageButton extends StatefulWidget {
  const LanguageButton({super.key});

  @override
  _LanguageButtonWidgetState createState() => _LanguageButtonWidgetState();
}

/*
class _LanguageButtonWidgetState extends State<LanguageButton> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<LanguageNotifier>(context);
    var flag = provider.currentLanguage == "pl"
        ? 'asset/flags/poland.png'
        : 'asset/flags/america.png';
    return Consumer<LanguageNotifier>(
      builder: (context, languages, child) => ListTile(
        //   leading: const Icon(Icons.language),
        leading: Expanded(child: Image.asset(flag)),
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
    );
  }
}*/
class _LanguageButtonWidgetState extends State<LanguageButton> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var provider = Provider.of<LanguageNotifier>(context);
    var flag = provider.currentLanguage == "pl"
        ? 'asset/flags/poland.png'
        : 'asset/flags/america.png';
    return Consumer<LanguageNotifier>(
      builder: (context, languages, child) => GestureDetector(
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
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [
                0.3,
                0.7,
              ],
              colors: [kPrimaryColorGradient, kAccentColorGradient],
            ),
            color: kAccentColor,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            shape: BoxShape.rectangle,
            //   border: Border.all(         color: kPrimaryColor,         width: 3, )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: width * 0.01,
              ),
              Image.asset(
                alignment: Alignment.bottomRight,
                scale: 0.1,
                flag,
                width: width * 0.04,
                height: height * 0.08,
              ),
              SizedBox(
                width: width * 0.01,
              ),
              Text(AppLocalizations.of(context)!.changeLanguage),
              SizedBox(
                width: width * 0.01,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
