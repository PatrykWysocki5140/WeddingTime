import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedding_time/constants.dart';
import 'package:wedding_time/services/helper.dart';
import 'package:wedding_time/ui/auth/authentication_bloc.dart';
import 'package:wedding_time/ui/auth/onBoarding/data.dart';
import 'package:wedding_time/ui/auth/onBoarding/on_boarding_screen.dart';
import 'package:wedding_time/ui/auth/signUp/sign_up_bloc.dart';
import 'package:wedding_time/ui/auth/welcome/welcome_screen.dart';
import 'package:wedding_time/ui/home/home_screen.dart';
import 'package:wedding_time/ui/loading_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

class LauncherScreen extends StatefulWidget {
  const LauncherScreen({Key? key}) : super(key: key);

  @override
  State<LauncherScreen> createState() => _LauncherScreenState();
}

class _LauncherScreenState extends State<LauncherScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AuthenticationBloc>().add(CheckFirstRunEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(colorPrimary),
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          switch (state.authState) {
            case AuthState.firstRun:
              pushReplacement(
                  context,
                  OnBoardingScreen(
                    images: imageList,
                    titles: titlesList,
                    subtitles: subtitlesList,
                  ));
              break;
            case AuthState.authenticated:
              pushReplacement(context, HomeScreen(user: state.user!));
              break;
            case AuthState.unauthenticated:
              pushReplacement(context, const WelcomeScreen());
              break;
          }
        },
        child: const Center(
          child: CircularProgressIndicator.adaptive(
            backgroundColor: Colors.white,
            valueColor: AlwaysStoppedAnimation(Color(colorPrimary)),
          ),
        ),
      ),
    );
  }
}
