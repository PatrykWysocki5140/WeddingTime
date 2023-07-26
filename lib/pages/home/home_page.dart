// ignore_for_file: use_key_in_widget_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wedding_time/models/user.dart';
import 'package:wedding_time/notifiers/admin.dart';
import 'package:wedding_time/services/fireStore/user.dart';
import 'package:wedding_time/test2/addData.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedding_time/pages/login/authentication_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final User user;
  late bool isAdmin = context.read<AuthenticationBloc>().state.user!.isAdmin;

/*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage'),
        centerTitle: true,
      ),
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state.authState == AuthState.authenticated) {
            var adminprovider =
                Provider.of<AdminNotifier>(context, listen: false);
            adminprovider.isAdmin(state.user!.userID);
          }
        },
        child: AddData(),
      ),
    );
  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage'),
        centerTitle: true,
      ),
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state.authState == AuthState.authenticated) {
            var adminprovider = Provider.of<AdminNotifier>(context);
            adminprovider
                .checkAdmin(state.user!.userID)
                .then((value) => isAdmin = value);
            log(isAdmin.toString());
          }
          return isAdmin ? AddData() : Text("data");
        },
      ),
    );
  }
  /*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage'),
        centerTitle: true,
      ),
      body: /*const Center(
        child: Text(
          'HomePage is working',
          style: TextStyle(fontSize: 20),
        ),
      ),*/
          //  AddPage(),
          AddData(),
    );
  }*/
}
