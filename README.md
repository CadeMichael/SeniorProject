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
  flutter_native_splash: ^1.3.2
  fast_rsa: ^3.4.6

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

## Encryption 

- using fast_rsa plugin for encryption. It is very performant (written in go) and integrates seamlessly. It is secure and perfect for peer to peer async encryption. However it is not ubiquitous and the size of keys it makes means that unless you have another app that uses RSA encryption of the same strength only the crypt can be used with these keys. With this in mind we will try to make an OpenPGP version aswell. 

## Presentation 
- all information about the final product can be found in the ![presentation](Presentation.pdf)
