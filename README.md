# senior project 

## pgp application 

- pgp encryption application, take a look at flutter code, everything is in lib/ is where the dart code is 

## Dependencies 

- all in pubspec.yaml

```yaml
dependencies:
  flutter:
    sdk: flutter

  qr_flutter: ^4.0.0
  font_awesome_flutter: '>= 4.7.0'

  # The following adds the Cupertino Icons font to your application.
  # Use with the CupertinoIcons class for iOS style icons.
  cupertino_icons: ^1.0.2
  objectbox_flutter_libs: ^1.4.1
  objectbox: ^1.4.1

dev_dependencies:
  build_runner: ^2.1.7
  objectbox_generator: ^1.4.1
  flutter_test:
    sdk: flutter
```

- to create the objectbox_generator
- flutter pub run build_runner build

## SplashScreen

- using [native splash](https://pub.dev/packages/flutter_native_splash)
- there is a `flutter_native_splash.yaml` in the root dir and this has the setup for the splash screen 
- the splash image is in `assets/splash.png`
