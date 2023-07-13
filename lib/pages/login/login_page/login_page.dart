import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wedding_time/constants.dart';
import 'package:wedding_time/pages/home/home_page.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedding_time/pages/login/authentication_bloc.dart';
import 'package:wedding_time/pages/login/login_page/login_bloc/login_bloc.dart';
import 'package:wedding_time/pages/login/reset_pass_page/reset_pass_page.dart';

import 'package:wedding_time/services/helper.dart';

import 'package:wedding_time/ui/auth/resetPasswordScreen/reset_password_screen.dart';

import '../../../widgets/loading/loading_cubit.dart';
/*
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _domainController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool visible = true;

  @override
  void initState() {
    super.initState();
    /*
    _domainController.text = "patryk";
    _usernameController.text = "estu@onet.pl";
    _passwordController.text = "Qweasdzxc123";*/
  }

  void checkUserIsLogged() async {
    final prefs = await SharedPreferences.getInstance();
    if ((prefs.getBool(sharedLogged) != null) &&
        (prefs.getBool(sharedLogged) ?? false)) {
      _domainController.text = prefs.getString(sharedDomain) ?? '';
      _usernameController.text = prefs.getString(sharedUser) ?? '';
      _passwordController.text = prefs.getString(sharedPassword) ?? '';

      signIn();
    }
  }

  void signIn() async {
    if (_domainController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: AppLocalizations.of(context)!.emptyDomain,
          backgroundColor: kErrorColor);
      /*
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.emptyDomain),
        ),
      );*/
    } else if (_usernameController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: AppLocalizations.of(context)!.emptyEmail,
          backgroundColor: kErrorColor);
      /*
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.emptyEmail),
        ),
      );*/
    } else if (_passwordController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: AppLocalizations.of(context)!.emptyPassword,
          backgroundColor: kErrorColor);
      /*
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.emptyPassword),
        ),
      );*/
    } else {
      var sign;
      bool isLogged = await sign.signIn(
          context, _domainController, _usernameController, _passwordController);

      //isLogged = true;

      if (isLogged) {}
    }

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => HomePage(),
        ),
      );
    }
  }

  void forgetPassword() async {}

  loadData() async {}

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    loadData();

    //if (user.isEmpty) {
    if (true) {
      return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.logging),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                padding: EdgeInsets.symmetric(horizontal: width * 0.2),
                child: TextField(
                  controller: _domainController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.domain,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.2),
                child: TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.email,
                    )),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.2),
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.password,
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
                        msg: "${AppLocalizations.of(context)!.logging}...");
                    /*
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text("${AppLocalizations.of(context)!.logging}..."),
                      ),
                    );*/
                    signIn();
                  },
                  child: Text(
                    AppLocalizations.of(context)!.loginbutton,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: const Color.fromARGB(0, 0, 0, 0),
                      foregroundColor: kTextColor,
                      textStyle: const TextStyle(
                          color: kTextColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w100)),
                  onPressed: () {
                    //forgetPassword();
                  },
                  child: Text(
                    AppLocalizations.of(context)!.forgetpasswordinfo,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}*/

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State createState() {
    return _LoginPage();
  }
}

class _LoginPage extends State<LoginPage> {
  final GlobalKey<FormState> _key = GlobalKey();
  AutovalidateMode _validate = AutovalidateMode.disabled;
  String? email, password;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.logging),
          ),
          body: MultiBlocListener(
            listeners: [
              BlocListener<AuthenticationBloc, AuthenticationState>(
                listener: (context, state) async {
                  await context.read<LoadingCubit>().hideLoading();
                  if (state.authState == AuthState.authenticated) {
                    if (!mounted) return;
                    pushAndRemoveUntil(context, HomePage(), false);
                  } else {
                    if (!mounted) return;
                    Fluttertoast.showToast(
                        msg: AppLocalizations.of(context)!.loginError,
                        backgroundColor: kErrorColor);
                  }
                },
              ),
              BlocListener<LoginBloc, LoginState>(
                listener: (context, state) async {
                  if (state is ValidLoginFields) {
                    await context.read<LoadingCubit>().showLoading(
                        context, AppLocalizations.of(context)!.logging, false);
                    if (!mounted) return;
                    context.read<AuthenticationBloc>().add(
                          LoginWithEmailAndPasswordEvent(
                            email: email!,
                            password: password!,
                          ),
                        );
                  }
                },
              ),
            ],
            child: BlocBuilder<LoginBloc, LoginState>(
              buildWhen: (old, current) =>
                  current is LoginFailureState && old != current,
              builder: (context, state) {
                if (state is LoginFailureState) {
                  _validate = AutovalidateMode.onUserInteraction;
                }
                return Form(
                  key: _key,
                  autovalidateMode: _validate,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
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
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.2),
                          child: TextFormField(
                              textAlignVertical: TextAlignVertical.center,
                              textInputAction: TextInputAction.next,
                              validator: (value) => validEmail(context, value),
                              onSaved: (String? val) {
                                email = val;
                              },
                              style: const TextStyle(fontSize: 18.0),
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: AppLocalizations.of(context)!.email,
                              )),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.2),
                          child: TextFormField(
                            textAlignVertical: TextAlignVertical.center,
                            obscureText: true,
                            validator: (value) => validPassword(context, value),
                            onSaved: (String? val) {
                              password = val;
                            },
                            onFieldSubmitted: (password) => context
                                .read<LoginBloc>()
                                .add(ValidateLoginFieldsEvent(_key)),
                            textInputAction: TextInputAction.done,
                            style: const TextStyle(fontSize: 18.0),
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!.password,
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
                                  msg:
                                      "${AppLocalizations.of(context)!.logging}...");
                              context
                                  .read<LoginBloc>()
                                  .add(ValidateLoginFieldsEvent(_key));
                            },
                            child: Text(
                              AppLocalizations.of(context)!.loginbutton,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 15, bottom: 0),
                          child: TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(0, 0, 0, 0),
                                foregroundColor: kTextColor,
                                textStyle: const TextStyle(
                                    color: kTextColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w100)),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const ResetPasswordPage()));
                            },
                            child: Text(
                              AppLocalizations.of(context)!.forgetpasswordinfo,
                            ),
                          ),
                        ),

                        /*
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 40.0, left: 40.0, bottom: 20),
                          child: ElevatedButton.icon(
                            label: const Text(
                              'Facebook Login',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            icon: Image.asset(
                              'assets/images/facebook_logo.png',
                              color: Colors.white,
                              height: 24,
                              width: 24,
                            ),
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size.fromWidth(
                                  MediaQuery.of(context).size.width / 1.5),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              backgroundColor: const Color(facebookButtonColor),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                side: const BorderSide(
                                  color: Color(facebookButtonColor),
                                ),
                              ),
                            ),
                            onPressed: () async {
                              await context.read<LoadingCubit>().showLoading(
                                  context, 'Logging in, Please wait...', false);
                              if (!mounted) return;
                              context
                                  .read<AuthenticationBloc>()
                                  .add(LoginWithFacebookEvent());
                            },
                          ),
                        ),*/
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      }),
    );
  }
}
