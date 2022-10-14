<p align="center">
  <img src="https://raw.githubusercontent.com/anyone-developer/anyone-dart-mitt/main/misc/logo.png" width="300" height="300" alt="mitt">
  <br>
  <img src="https://badgen.net/pub/v/mitt" alt="pub version">
  <img src="https://badgen.net/pub/points/mitt" alt="points">
  <img src="https://badgen.net/pub/likes/mitt" alt="likes">
  <img src="https://badgen.net/pub/popularity/mitt" alt="popularity">
  <br>
  <img src="https://badgen.net/pub/sdk-version/mitt" alt="sdk">
  <img src="https://badgen.net/pub/flutter-platform/mitt" alt="platform">
  <a href="https://stackoverflow.com/questions/tagged/flutter?sort=votes">
    <img alt="Awesome Flutter" src="https://img.shields.io/badge/Awesome-Flutter-blue.svg?longCache=true&style=flat-square" />
  </a>
</p>

# Mitt (anyone-dart-mitt)

This package help you to use event emitter/pubsub with dart. The package is inspired by npm [mitt](https://www.npmjs.com/package/mitt#all). I just take same name because user would easily to use it with same way without any hesitate.

*If you like my module, please buy me a coffee.*

*More and more tiny and useful GitHub action modules are on the way. Please donate to me. I accept a part-time job contract. if you need, please contact me: zhang_nan_163@163.com*

## How to use

### Same with mitt

```dart
import 'package:mitt/mitt.dart';

void main() {
  final emitter = Mitt();
  // listen to an event
  emitter.on(Symbol('foo'), eventHandler: (e) => print('foo $e'));

  // listen to all events
  emitter.on(Symbol('*'), wildcardHandler: (type, e) => print('$type $e'));

  // fire an event
  emitter.emit(Symbol('foo'), [
    <String, String>{'a': 'b'}
  ]);

  // clearing all events
  emitter.all.clear();

  // working with handler references:
  onFoo(arg) => print('defined onFoo with $arg');

  emitter.on(Symbol('foo'), eventHandler: onFoo); // listen
  emitter.off(Symbol('foo'), eventHandler: onFoo); // unlisten
}
```

### You can reference example from example folder

## Donation

PalPal: https://paypal.me/nzhang4

<img src="https://raw.githubusercontent.com/anyone-developer/anyone-dart-mitt/main/misc/alipay.jpeg" width="500">

<img src="https://raw.githubusercontent.com/anyone-developer/anyone-dart-mitt/main/misc/wechat_pay.png" width="500">


