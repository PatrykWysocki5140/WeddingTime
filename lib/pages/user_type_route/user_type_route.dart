// ignore_for_file: use_key_in_widget_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wedding_time/models/user.dart';
import 'package:wedding_time/notifiers/admin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedding_time/blocs/auth/authentication_bloc.dart';
import 'package:wedding_time/pages/user_route/home/home_page.dart';

import '../admin_route/admin_home/admin_home_page.dart';

class UserTypeRoute extends StatefulWidget {
  @override
  State<UserTypeRoute> createState() => _UserTypeRouteState();
}

class _UserTypeRouteState extends State<UserTypeRoute> {
  late final User user;
  late bool isAdmin = context.read<AuthenticationBloc>().state.user!.isAdmin;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state.authState == AuthState.authenticated) {
          var adminprovider = Provider.of<AdminNotifier>(context);
          adminprovider
              .checkAdmin(state.user!.userID)
              .then((value) => isAdmin = value);
          log(isAdmin.toString());
        }
        return isAdmin ? AdminHomePage() : HomePage();
      },
    );
  }
}
