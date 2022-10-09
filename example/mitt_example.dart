/*
 * @Author: Edward Zhang 
 * @Date: 2022-10-09 14:12:23 
 * @Last Modified by: Edward Zhang
 * @Last Modified time: 2022-10-09 14:56:04
 */
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
