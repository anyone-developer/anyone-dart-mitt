/*
 * @Author: Edward Zhang 
 * @Date: 2022-10-09 13:16:49 
 * @Last Modified by: Edward Zhang
 * @Last Modified time: 2022-10-09 13:52:48
 */

typedef MittEventHandler = void Function(dynamic arg);
typedef MittWildcardEventHandler = void Function(Symbol type, dynamic arg);

const wildcard = Symbol('*');

class Mitt {
  final _events = <Symbol, List<dynamic>>{};

  _isWildcard(Symbol type) => type == wildcard;

  ///subscribe event [type] with event [handler]
  ///if [type] is not [wildcard]. use [MittEventHandler] as [eventHandler]
  ///if [type] is [wildcard]. use [MittWildcardEventHandler] as [wildcardHandler]
  void on(
    Symbol type, {
    MittEventHandler? eventHandler,
    MittWildcardEventHandler? wildcardHandler,
  }) {
    final isWildcard = _isWildcard(type);

    if (_events.containsKey(type)) {
      List<dynamic>? typeHandlers = _events[type];

      if (typeHandlers != null) {
        if (isWildcard) {
          List<MittWildcardEventHandler> handlers =
              typeHandlers.cast<MittWildcardEventHandler>();
          if (wildcardHandler != null) handlers.add(wildcardHandler);
        } else {
          List<MittEventHandler> handlers =
              typeHandlers.cast<MittEventHandler>();
          if (eventHandler != null) handlers.add(eventHandler);
        }
      }
//      _events[type] = handlers;
      return;
    }
    _events[type] = [isWildcard ? wildcardHandler : eventHandler];
  }

  ///remove specific [handler] with event [type] or leave null will remove all handlers
  ///if [type] is not [wildcard]. use [MittEventHandler] as [eventHandler]
  ///if [type] is [wildcard]. use [MittWildcardEventHandler] as [wildcardHandler]
  void off(
    Symbol type, {
    MittEventHandler? eventHandler,
    MittWildcardEventHandler? wildcardHandler,
  }) {
    final isWildcard = _isWildcard(type);
    final typeHandlers = _events[type];

    if (typeHandlers != null) {
      if (isWildcard) {
        if (wildcardHandler != null) {
          typeHandlers.remove(wildcardHandler);
          if (typeHandlers.isEmpty) _events.remove(type);
        } else {
          _events.remove(type);
        }
      } else {
        if (eventHandler != null) {
          typeHandlers.remove(eventHandler);
          if (typeHandlers.isEmpty) _events.remove(type);
        } else {
          _events.remove(type);
        }
      }
    }
  }

  ///emit event by [type]. and pass [arg] as parameter when calling it.
  void emit(Symbol type, dynamic arg) {
    final isWildcardType = _isWildcard(type);
    if (isWildcardType) {
      for (MapEntry<Symbol, List<dynamic>> entry in _events.entries) {
        final wildCardEvent = _isWildcard(entry.key);
        final handlers = wildCardEvent
            ? entry.value.cast<MittWildcardEventHandler>()
            : entry.value.cast<MittEventHandler>();
        for (dynamic handler in handlers) {
          if (handler is MittWildcardEventHandler) {
            handler.call(entry.key, arg);
          } else if (handler is MittEventHandler) {
            handler.call(arg);
          }
        }
      }
    } else {
      final typeHandlers = _events[type];
      if (typeHandlers != null) {
        for (final typeHandler in typeHandlers) {
          final handler = typeHandler as MittEventHandler;
          handler.call(arg);
        }
      }
    }
  }

  /// get [all] events
  Map<Symbol, List<dynamic>> get all => _events;

  /// get specific events by [type]
  operator [](type) {
    if (type is Symbol) {
      _events[type];
    } else {
      _events[Symbol(type.toString())];
    }
  }
}
