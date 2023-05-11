import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<UserCredential> signInWithGoogle() async {
  // 구글 로그인 흐름 시작
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  // 인증 세부 정보 가져오기
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;
  // 새 자격 증명 만들기
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // 로그인 후 UserCredential 반환
  return await FirebaseAuth.instance.signInWithCredential(credential);
}
