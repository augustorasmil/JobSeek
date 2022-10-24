import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class JobSeekFirebaseUser {
  JobSeekFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

JobSeekFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<JobSeekFirebaseUser> jobSeekFirebaseUserStream() => FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<JobSeekFirebaseUser>(
      (user) {
        currentUser = JobSeekFirebaseUser(user);
        return currentUser!;
      },
    );
