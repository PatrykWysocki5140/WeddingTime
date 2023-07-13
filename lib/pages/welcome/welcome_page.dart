import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:wedding_time/notifiers/LanguageNotifier.dart';
import 'package:wedding_time/pages/login/login_page/login_page.dart';
import 'package:wedding_time/pages/login/register_page/register_page.dart';
import 'package:wedding_time/pages/welcome/welcome_bloc/welcome_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:country_flags/country_flags.dart';
import 'package:wedding_time/widgets/language_button.dart';
import '../../services/helper.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocProvider<WelcomeBloc>(
      create: (context) => WelcomeBloc(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: BlocListener<WelcomeBloc, WelcomeInitial>(
              listener: (context, state) {
                switch (state.pressTarget) {
                  case WelcomePressTarget.login:
                    push(context, const LoginPage());
                    break;
                  case WelcomePressTarget.signup:
                    push(context, const RegisterPage());
                    break;
                  default:
                    break;
                }
              },
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 60.0),
                      child: Center(
                        child: SizedBox(
                            width: width,
                            height: height * 0.5,
                            child: Image.asset('asset/images/logo.png')),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16, top: 32, right: 16, bottom: 8),
                      child: Text(
                        AppLocalizations.of(context)!.welcome,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.35,
                          right: width * 0.35,
                          top: height * 0.02),
                      child: TextButton(
                        onPressed: () {
                          Fluttertoast.showToast(
                              msg: AppLocalizations.of(context)!.loginprocess);
                          context.read<WelcomeBloc>().add(LoginPressed());
                        },
                        child: Text(
                          AppLocalizations.of(context)!.loginprocess,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.35,
                          right: width * 0.35,
                          top: height * 0.02),
                      child: TextButton(
                        onPressed: () {
                          Fluttertoast.showToast(
                              msg: AppLocalizations.of(context)!.signupprocess);
                          context.read<WelcomeBloc>().add(RegisterPressed());
                        },
                        child: Text(
                          AppLocalizations.of(context)!.signupprocess,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.35,
                          right: width * 0.35,
                          top: height * 0.02),
                      child: const LanguageButton(),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
