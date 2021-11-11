# HookController

Simple hooks system, used to modify value or the context of specific type by series of hooks, each one gets the previous value and the commit method to apply changes.

## Usage

A simple usage example:

```dart
import 'package:hook_controller/hook_controller.dart';

void main() async {
  final beforeSendHook = HookController<String>();

  // salt password
  beforeSendHook.registerHook(
    (password, commit) => commit('salt $password salt'),
  );

  // hash password
  beforeSendHook.registerHook(
    (password, commit) => commit('hash $password hash'),
  );

  final String password = 'my_password';

  final hashedPassword = await beforeSendHook.execute(password);
  print(
    'Hashed password is \'$hashedPassword\'.',
  ); // Hashed password is 'hash salt my_password salt hash'.
}

```
