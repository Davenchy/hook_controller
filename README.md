# HookController

Simple hooks system

## Usage

A simple usage example:

```dart
import 'package:hook_controller/hook_controller.dart';

void main() async {
  final beforeSendHook = HookController<String>();

  // salt password
  beforeSendHook.registerHook((password, next) => next('salt $password salt'));

  // hash password
  beforeSendHook.registerHook((password, next) => next('hash $password hash'));

  final String password = 'my_password';

  final hashedPassword = await beforeSendHook.execute(password);
  print(
    'Hashed password is \'$hashedPassword\'.',
  ); // Hashed password is 'hash salt my_password salt hash'.
}

```
