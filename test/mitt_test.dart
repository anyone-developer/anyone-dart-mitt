import 'package:mitt/mitt.dart';
import 'package:test/test.dart';

void main() {
  group('one event test', () {
    final emitter = Mitt();
    const type = Symbol("Hello");
    const parameter = [
      <String, String>{'Foo': 'Bar'}
    ];
    handler(arg) {
      expect(arg, parameter);
    }

    setUp(() {
      emitter.on(type, eventHandler: handler);
    });

    test('execute event', () {
      emitter.emit(type, parameter);
      emitter.off(type, eventHandler: handler);
      expect(emitter.all.length, 0);
    });
  });

  group('multiple events test', () {
    final emitter = Mitt();
    const type = Symbol("Hello");
    const parameter = [
      <String, String>{'Foo': 'Bar'}
    ];

    handler1(arg) {
      expect(arg, parameter);
    }

    handler2(arg) {
      expect(arg, parameter);
    }

    handler3(arg) {
      expect(arg, parameter);
    }

    setUp(() {
      emitter.on(type, eventHandler: handler1);
      emitter.on(type, eventHandler: handler2);
      emitter.on(type, eventHandler: handler3);
    });

    test('execute event', () {
      emitter.emit(type, parameter);
      emitter.off(type);
      expect(emitter.all.length, 0);
    });
  });

  group('multiple wildcard event test', () {
    final emitter = Mitt();
    const type = Symbol("Hello");
    const wildcard = Symbol("*");
    const parameter = [
      <String, String>{'Foo': 'Bar'}
    ];
    const wildcardParameter = "this is wildcard parameter";

    handler1(arg) {
      assert(
          arg == parameter || arg == "$wildcardParameter with type: $wildcard",
          true);
      //expect(arg, parameter);
    }

    handler2(arg) {
      assert(
          arg == parameter || arg == "$wildcardParameter with type: $wildcard",
          true);
      //expect(arg, parameter);
    }

    handler3(arg) {
      assert(
          arg == parameter || arg == "$wildcardParameter with type: $wildcard",
          true);
      //expect(arg, parameter);
    }

    handleWildcard1(type, arg) {
      expect(arg, "$wildcardParameter with type: $wildcard");
    }

    handleWildcard2(type, arg) {
      expect(arg, "$wildcardParameter with type: $wildcard");
    }

    setUp(() {
      emitter.on(type, eventHandler: handler1);
      emitter.on(type, eventHandler: handler2);
      emitter.on(type, eventHandler: handler3);

      emitter.on(wildcard, wildcardHandler: handleWildcard1);
      emitter.on(wildcard, wildcardHandler: handleWildcard2);
    });

    test('execute event', () {
      emitter.emit(type, parameter);

      emitter.emit(wildcard, "$wildcardParameter with type: $wildcard");

      emitter.off(type);
      emitter.off(wildcard);
      expect(emitter.all.length, 0);
    });
  });
}
