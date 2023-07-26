import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedding_time/constants.dart';
import 'package:wedding_time/pages/home/home_page.dart';
import 'package:wedding_time/pages/login/authentication_bloc.dart';
import 'package:wedding_time/pages/welcome/welcome_page.dart';
import 'package:wedding_time/services/helper.dart';

import '../login/login_page/login_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPagePageState();
}

class _RootPagePageState extends State<RootPage> {
  @override
  void initState() {
    super.initState();
    context.read<AuthenticationBloc>().add(CheckFirstRunEvent());
  }

  loadData() async {}

  @override
  Widget build(BuildContext context) {
    loadData();
    return Scaffold(
      backgroundColor: const Color(colorPrimary),
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          switch (state.authState) {
            case AuthState.firstRun:
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const WelcomePage()));
              break;
            case AuthState.authenticated:
              pushReplacement(context, HomePage());
              break;
            case AuthState.unauthenticated:
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginPage()));
              break;
          }
        },
        child: const Center(
          child: CircularProgressIndicator.adaptive(
            backgroundColor: kBackgroundColor,
            valueColor: AlwaysStoppedAnimation(kAccentColor),
          ),
        ),
      ),
    );
  }
}
