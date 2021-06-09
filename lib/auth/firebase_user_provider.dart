import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class Bee3FirebaseUser {
  Bee3FirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

Bee3FirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<Bee3FirebaseUser> bee3FirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<Bee3FirebaseUser>((user) => currentUser = Bee3FirebaseUser(user));
