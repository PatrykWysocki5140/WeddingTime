// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:wedding_time/notifiers/LanguageNotifier.dart';

class LanguageButton extends StatefulWidget {
  const LanguageButton({super.key});

  @override
  _LanguageButtonWidgetState createState() => _LanguageButtonWidgetState();
}

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
}
