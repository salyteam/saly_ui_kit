# Saly UI Kit

A cool branded set of UI components!

## Components

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
