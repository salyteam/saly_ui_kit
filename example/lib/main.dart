import 'package:flutter/material.dart';
import 'package:saly_ui_kit/saly_ui_kit.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPref = await SharedPreferences.getInstance();

  runApp(
    MaterialApp(
      builder: (context, child) {
        return SalyTheme(storage: sharedPref, child: child!);
      },
      home: const MyApp(),
    ),
  );
}

Brightness? getInitBrightness(SharedPreferences sharedPref) {
  final value = sharedPref.getInt("color_theme");
  if (value == null) return null;
  return Brightness.values[value];
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          spacing: 20,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(child: Text("Color theme", style: context.fonts.h5)),
                  SalySwitcher(
                    value: false,
                    onChange: (valur) {
                      SalyTheme.of(context).changeTheme();
                    },
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  spacing: 10,
                  children: [
                    for (int i = 0; i < 5; i++)
                      DiscountCard(
                        onTap: () {
                          print('asdfas');
                        },
                        description:
                            "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore ma",
                        sale: 50,
                        name: "Lorem ipsum",
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SalyButton.primary(onTap: () {}, title: "Button"),
            ),
          ],
        ),
      ),
    );
  }
}
