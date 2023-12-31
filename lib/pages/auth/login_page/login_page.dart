import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wedding_time/constants.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedding_time/blocs/auth/authentication_bloc.dart';
import 'package:wedding_time/blocs/login/login_bloc.dart';
import 'package:wedding_time/pages/auth/reset_pass_page/reset_pass_page.dart';
import 'package:wedding_time/pages/user_type_route/user_type_route.dart';

import 'package:wedding_time/services/helper.dart';
import 'package:wedding_time/widgets/text_gradient_button.dart';

import '../../../widgets/loading/loading_cubit.dart';

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
    email = "estu@onet.pl";
    password = "Qweasdzxc123";
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
                    pushAndRemoveUntil(context, UserTypeRoute(), false);
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
                              controller:
                                  TextEditingController(text: 'estu@onet.pl'),
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
                            controller:
                                TextEditingController(text: 'Qweasdzxc123'),
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
                          child: GradientRandomButton(
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
