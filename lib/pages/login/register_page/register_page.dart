import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wedding_time/constants.dart';
import 'package:wedding_time/pages/home/home_page.dart';
import 'package:wedding_time/pages/login/authentication_bloc.dart';
import 'package:wedding_time/pages/login/register_page/register_bloc/register_bloc.dart';
import 'package:wedding_time/services/helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wedding_time/widgets/loading/loading_cubit.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey();
  String? firstName, lastName, email, password, confirmPassword;
  AutovalidateMode _validate = AutovalidateMode.disabled;
  bool acceptEULA = true;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocProvider<SignUpBloc>(
      create: (context) => SignUpBloc(),
      child: Builder(
        builder: (context) {
          if (!kIsWeb && Platform.isAndroid) {
            context.read<SignUpBloc>().add(RetrieveLostDataEvent());
          }
          return MultiBlocListener(
            listeners: [
              BlocListener<AuthenticationBloc, AuthenticationState>(
                listener: (context, state) {
                  context.read<LoadingCubit>().hideLoading();
                  if (state.authState == AuthState.authenticated) {
                    pushAndRemoveUntil(context, HomePage(), false);
                  } else {
                    Fluttertoast.showToast(
                        msg: AppLocalizations.of(context)!.signuperror);
                  }
                },
              ),
              BlocListener<SignUpBloc, SignUpState>(
                listener: (context, state) async {
                  if (state is ValidFields) {
                    await context.read<LoadingCubit>().showLoading(context,
                        AppLocalizations.of(context)!.createaccount, false);
                    if (!mounted) return;
                    context.read<AuthenticationBloc>().add(
                        SignupWithEmailAndPasswordEvent(
                            emailAddress: email!,
                            password: password!,
                            lastName: lastName,
                            firstName: firstName));
                  } else if (state is SignUpFailureState) {
                    Fluttertoast.showToast(msg: state.errorMessage);
                  }
                },
              ),
            ],
            child: Scaffold(
              appBar: AppBar(
                title: Text(AppLocalizations.of(context)!.createaccountinfo),
              ),
              body: SingleChildScrollView(
                // padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
                child: BlocBuilder<SignUpBloc, SignUpState>(
                  buildWhen: (old, current) =>
                      current is SignUpFailureState && old != current,
                  builder: (context, state) {
                    if (state is SignUpFailureState) {
                      _validate = AutovalidateMode.onUserInteraction;
                    }
                    return Form(
                      key: _key,
                      autovalidateMode: _validate,
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
                                textCapitalization: TextCapitalization.words,
                                validator: (value) => validName(context, value),
                                onSaved: (String? val) {
                                  firstName = val;
                                },
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  labelText:
                                      AppLocalizations.of(context)!.firstname,
                                )),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.2),
                            child: TextFormField(
                                textCapitalization: TextCapitalization.words,
                                validator: (value) => validName(context, value),
                                onSaved: (String? val) {
                                  lastName = val;
                                },
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  labelText:
                                      AppLocalizations.of(context)!.lastname,
                                )),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.2),
                            child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                validator: (value) =>
                                    validEmail(context, value),
                                onSaved: (String? val) {
                                  email = val;
                                },
                                decoration: InputDecoration(
                                  labelText:
                                      AppLocalizations.of(context)!.email,
                                )),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.2),
                            child: TextFormField(
                                obscureText: true,
                                textInputAction: TextInputAction.next,
                                controller: _passwordController,
                                validator: (value) =>
                                    validPassword(context, value),
                                onSaved: (String? val) {
                                  password = val;
                                },
                                style: const TextStyle(
                                    height: 0.8, fontSize: 18.0),
                                cursorColor: const Color(colorPrimary),
                                decoration: InputDecoration(
                                  labelText:
                                      AppLocalizations.of(context)!.password,
                                )),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.2),
                            child: TextFormField(
                                textInputAction: TextInputAction.done,
                                onFieldSubmitted: (_) =>
                                    context.read<SignUpBloc>().add(
                                          ValidateFieldsEvent(_key,
                                              acceptEula: acceptEULA),
                                        ),
                                obscureText: true,
                                validator: (val) => validConfirmPassword(
                                    context, _passwordController.text, val),
                                onSaved: (String? val) {
                                  confirmPassword = val;
                                },
                                style: const TextStyle(
                                    height: 0.8, fontSize: 18.0),
                                cursorColor: const Color(colorPrimary),
                                decoration: InputDecoration(
                                  labelText: AppLocalizations.of(context)!
                                      .passwordconfirmation,
                                )),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: width * 0.35,
                                right: width * 0.35,
                                top: height * 0.02),
                            child: TextButton(
                              onPressed: () {
                                context.read<SignUpBloc>().add(
                                      ToggleEulaCheckboxEvent(
                                        eulaAccepted: true,
                                      ),
                                    );
                                Fluttertoast.showToast(
                                    msg:
                                        "${AppLocalizations.of(context)!.signupprocess}...");
                                context.read<SignUpBloc>().add(
                                      ValidateFieldsEvent(_key,
                                          acceptEula: true),
                                    );
                              },
                              child: Text(
                                AppLocalizations.of(context)!.signupbutton,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          /*
                          ListTile(
                            trailing: BlocBuilder<SignUpBloc, SignUpState>(
                              buildWhen: (old, current) =>
                                  current is EulaToggleState && old != current,
                              builder: (context, state) {
                                if (state is EulaToggleState) {
                                  acceptEULA = state.eulaAccepted;
                                }
                                return Checkbox(
                                  onChanged: (value) =>
                                      context.read<SignUpBloc>().add(
                                            ToggleEulaCheckboxEvent(
                                              eulaAccepted: value!,
                                            ),
                                          ),
                                  activeColor: const Color(colorPrimary),
                                  value: acceptEULA,
                                );
                              },
                            ),
                            title: RichText(
                              textAlign: TextAlign.left,
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text:
                                        'By creating an account you agree to our ',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  TextSpan(
                                    style: const TextStyle(
                                      color: Colors.blueAccent,
                                    ),
                                    text: 'Terms of Use',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async {
                                        if (await canLaunchUrl(
                                            Uri.parse(eula))) {
                                          await launchUrl(
                                            Uri.parse(eula),
                                          );
                                        }
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ),*/
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _onCameraClick(BuildContext context) {
    if (kIsWeb || Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
      context.read<SignUpBloc>().add(ChooseImageFromGalleryEvent());
    } else {
      final action = CupertinoActionSheet(
        title: const Text(
          'Add Profile Picture',
          style: TextStyle(fontSize: 15.0),
        ),
        actions: [
          CupertinoActionSheetAction(
            isDefaultAction: false,
            onPressed: () async {
              Navigator.pop(context);
              context.read<SignUpBloc>().add(ChooseImageFromGalleryEvent());
            },
            child: const Text('Choose from gallery'),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: false,
            onPressed: () async {
              Navigator.pop(context);
              context.read<SignUpBloc>().add(CaptureImageByCameraEvent());
            },
            child: const Text('Take a picture'),
          )
        ],
        cancelButton: CupertinoActionSheetAction(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context)),
      );
      showCupertinoModalPopup(context: context, builder: (context) => action);
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();

    super.dispose();
  }
}
