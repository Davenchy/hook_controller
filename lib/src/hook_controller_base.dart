import 'dart:async';

/// A hook function used to read the current `context` and apply changes to it.
/// through the `commit` function.
typedef Hook<T> = void Function(T context, void Function(T newContext) commit);

class HookController<T> {
  final Set<Hook<T>> _hooks = {};

  /// register a `hook` into the controller
  void registerHook(Hook<T> hook) => _hooks.add(hook);

  /// remove a `hook` from the controller and return it back if exists
  Hook<T>? unregisterHook(Hook<T> hook) => _hooks.remove(hook);

  /// clear all hooks from controller
  void clear() => _hooks.clear();

  /// start executing the hooks series by passing the `context` at the beginning
  ///
  /// for each hook will pass the `commit` function to execute the next hook
  /// and the latest context changes by the hook before
  ///
  /// to apply a context change use the `commit` function
  Future<T> execute(T context) async {
    T currentContext = context;

    for (var hook in _hooks) {
      final completer = Completer<T>();
      hook(currentContext, (T value) => completer.complete(value));
      currentContext = await completer.future;
    }

    return currentContext;
  }
}
