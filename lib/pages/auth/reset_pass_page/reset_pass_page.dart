import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedding_time/constants.dart';
import 'package:wedding_time/blocs/reset_password/reset_pass_cubit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wedding_time/services/helper.dart';

import '../../../widgets/loading/loading_cubit.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final GlobalKey<FormState> _key = GlobalKey();
  AutovalidateMode _validate = AutovalidateMode.disabled;
  String _emailAddress = '';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocProvider<ResetPasswordCubit>(
      create: (context) => ResetPasswordCubit(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text(AppLocalizations.of(context)!.forgetpasswordinfo2),
            ),
            body: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
              listenWhen: (old, current) => old != current,
              listener: (context, state) async {
                if (state is ResetPasswordDone) {
                  context.read<LoadingCubit>().hideLoading();
                  Fluttertoast.showToast(
                      msg: AppLocalizations.of(context)!.sendResetEmail,
                      backgroundColor: kErrorColor);
                  Navigator.pop(context);
                } else if (state is ValidResetPasswordField) {
                  await context.read<LoadingCubit>().showLoading(context,
                      AppLocalizations.of(context)!.forgetpasswordinfo2, false);
                  if (!mounted) return;
                  context
                      .read<ResetPasswordCubit>()
                      .resetPassword(_emailAddress);
                } else if (state is ResetPasswordFailureState) {
                  Fluttertoast.showToast(
                      msg: state.errorMessage, backgroundColor: kErrorColor);
                }
              },
              buildWhen: (old, current) =>
                  current is ResetPasswordFailureState && old != current,
              builder: (context, state) {
                if (state is ResetPasswordFailureState) {
                  _validate = AutovalidateMode.onUserInteraction;
                }
                return Form(
                  autovalidateMode: _validate,
                  key: _key,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, top: 32, right: 16, bottom: 8),
                          child: Text(
                            AppLocalizations.of(context)!.forgetpasswordinfo,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 24.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.2),
                          child: TextFormField(
                            textAlignVertical: TextAlignVertical.center,
                            textInputAction: TextInputAction.done,
                            validator: validateEmail,
                            onFieldSubmitted: (_) => context
                                .read<ResetPasswordCubit>()
                                .checkValidField(_key),
                            onSaved: (val) => _emailAddress = val!,
                            style: const TextStyle(fontSize: 18.0),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!.email,
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
                              context
                                  .read<ResetPasswordCubit>()
                                  .checkValidField(_key);
                            },
                            child: Text(
                              AppLocalizations.of(context)!
                                  .forgetpasswordbutton,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
