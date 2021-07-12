import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInApi {
  static final _googleSignIn = GoogleSignIn(
      clientId:
          '949649090743-5udgqbmbmbemeenj9aoh0eot3mst10r6.apps.googleusercontent.com');
  static Future<GoogleSignInAccount> login() => _googleSignIn.signIn();
}
