# Saly UI Kit

A cool branded set of UI components!

## Components structure

The Flutter package follows the structure below:

- [**src/buttons/**](lib/src/buttons) – Reusable button widgets.
- [**src/cards/**](lib/src/cards) – Card-based UI components.
- [**src/controls/**](lib/src/controls) – Controls such as toggles, switches, and other interactive elements.
- [**src/inputs/**](lib/src/inputs) – Input fields like PIN inputs, text fields, and similar components.
- [**src/layout/**](lib/src/layout) – Layout elements including headers, steppers, bottom navigation bars, etc.
- [**src/theme/**](lib/src/theme) – Theme extensions and styling utilities.
- [**src/gen/**](lib/src/gen) – Generated asset classes (e.g., from `flutter_gen`).
- [**src/utils/**](lib/src/utils) – Utility extensions for `BuildContext` and other helper functions.

## Package updating

Before updating the package, make sure to generate new assets if any were added:
```sh
dart run build_runner build -d
```

## Usage

Import the package and use any component:
```dart
import 'package:saly_ui_kit/saly_ui_kit.dart';

void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Center(
      child: SalyButton.primary(
        title: 'Primary button',
        onTap: () {}
      ),
    ),
  ),
);
```

Go to [`/example`](/example/) folder to see full kit preview.
