import 'package:flutter/material.dart';
import 'package:saly_ui_kit/saly_ui_kit.dart';

void main() {
  runApp(
    MaterialApp(
      builder: (context, child) {
        return SalyTheme(child: child!);
      },
      home: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(child: Text("Swithc theme", style: context.fonts.h5)),
                  SalySwitcher(
                    value: SalyTheme.of(context).isDartTheme,
                    onChange: (valur) {
                      SalyTheme.of(context).changeTheme();
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  spacing: 10,
                  children: [
                    for (int i = 0; i < 5; i++)
                      DiscountCard(
                        onTap: () {},
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
