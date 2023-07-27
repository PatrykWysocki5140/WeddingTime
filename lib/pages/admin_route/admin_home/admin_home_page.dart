// ignore_for_file: use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../services/helper.dart';

import 'package:flutter_svg/flutter_svg.dart';

class AdminHomePage extends StatefulWidget {
  @override
  State<AdminHomePage> createState() => _HomePageState();
}

class _HomePageState extends State<AdminHomePage> {
  final List<String> buttons = [
    'Dodaj harmonogram',
    'Dodaj historię',
    'Dodaj zdjęcie główne',
    'Dodaj listę gości',
    'Grupuj gości na stoliki',
    'Dodane zdjęcia',
  ];

  final List<Widget> pages = [
    const Text('Dodaj harmonogram'),
    const Text('Dodaj historię'),
    const Text('Dodaj zdjęcie główne'),
    const Text('Dodaj listę gości'),
    const Text('Grupuj gości na stoliki'),
    const Text('Dodane zdjęcia'),
  ];
  Future<ImageProvider> _loadImage() async {
    // Tutaj wczytujemy obraz z folderu assets
    // W tym przypadku zakładamy, że obraz nazywa się 'background.jpg'
    // i znajduje się w folderze 'assets'
    const imageProvider = AssetImage("asset/flowers/flowers_bg.jpg");
    await precacheImage(imageProvider, context); // Precache obrazu
    return imageProvider;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final availableWidth = width - 16.0 * 2;
    final buttonSize = (availableWidth / 2) - 8.0;

    return FutureBuilder<ImageProvider>(
        future: _loadImage(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                title: Text(AppLocalizations.of(context)!.homepage),
                centerTitle: true,
              ),
              body: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("asset/flowers/flowers_bg.jpg"),
                      fit: BoxFit.cover),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: width * 0.15,
                        right: width * 0.15,
                        top: height * 0.02),
                    child: Column(
                      children: <Widget>[
                        GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: width * 0.02,
                            mainAxisSpacing: height * 0.04,
                            childAspectRatio: 1.0,
                          ),
                          itemCount: buttons.length,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              width: buttonSize,
                              height: buttonSize,
                              child: TextButton(
                                onPressed: () {
                                  pushReplacement(context, pages[index]);
                                },
                                child: Text(buttons[index]),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        });
  }
}
