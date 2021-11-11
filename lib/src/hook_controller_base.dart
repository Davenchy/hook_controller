import 'dart:async';

typedef Hook<T> = void Function(T context, void Function(T newContext) next);

class HookController<T> {
  final Set<Hook<T>> hooks = {};

  registerHook(Hook<T> hook) => hooks.add(hook);

  Future<T> execute(T context) async {
    T currentContext = context;

    for (var hook in hooks) {
      final completer = Completer<T>();
      hook(currentContext, (T value) => completer.complete(value));
      currentContext = await completer.future;
    }

    return currentContext;
  }
}
