import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:jarvis/src/constant/apiURL.dart';

import '../pages/login_page/TokenManager.dart';

class AuthService {
  static String token = '';  /* Access token */
  static String tokenRefresh = '';
  static String googleToken = '';

  static Future<void> getCurrentUser() async {
    token = await TokenManager.getToken() ?? "";
    var headers = {
      'x-jarvis-guid': '',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest('GET', Uri.parse(APIURL.getCurrentUser));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }


  }


  static Future<bool> isLoggedIn() async {
    token = await TokenManager.getToken() ?? "";
      return token!=null && token.isNotEmpty;
    }

  static Future<void> loginWithBasicSignIn({
    required String email,
    required String password,
    required Function(String) onSuccess,
  }) async {
    final response = await post(
      Uri.parse(APIURL.signIn),
      body: {
        'email': email,
        'password': password,
      },
    );

    final jsonDecode = json.decode(response.body);
    //print(jsonDecode);


    if (response.statusCode != 200) {
      print("-------------------------------------");
      throw Exception(jsonDecode['message']);
    }
    token = jsonDecode['token']["accessToken"];
    tokenRefresh = jsonDecode['token']['refreshToken'];
    await TokenManager.saveToken(token, tokenRefresh);
    await onSuccess(token);
  }

  /*TODO : not complete yet */
  static Future<void> signInWithGoogle() async {

    print('--------------------------------------------');
    print('------------SIGN WITH GOOGLE----------------');
    print('--------------------------------------------');
    final GoogleSignIn _googleSignIn = GoogleSignIn(
      // scopes: ['email', 'profile', 'openid'],
      // clientId: '417235733986-b06caeulfu6ad20td3uimockcq6ro6ik.apps.googleusercontent.com',

    );

    try {
      // Bước 1: Đăng nhập qua Google
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        print("Google Sign-In was cancelled.");
        return;
      }

      print(googleUser.email);
      // Bước 2: Lấy authentication từ Google
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      print("Access Token is ${googleAuth.accessToken}");
      print("ID Token is ${googleAuth.idToken}");


      final String? googleToken = googleAuth.accessToken;
      // // Bước 3: Lấy token từ Google
      // final String? googleToken = googleAuth.idToken;
      // if (googleToken == null) {
      //   print("Failed to get Google ID Token.");
      //   return;
      // }
      // print("Google Token: $googleToken");

      // Bước 4: Gửi token đến server qua API của bạn
      await loginWithGoogleSignIn(googleToken);
    } catch (e) {
      print("Error during Google Sign-In: $e");
    }
  }
  static Future<void> loginWithGoogleSignIn(String? token) async {
    var headers = {'Content-Type': 'application/json'};
    var request =
        http.Request('POST', Uri.parse(APIURL.googleSignIn));
    request.body = json.encode({"token": token});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }




  static Future<bool> signUp(
      {required String email,
      required String password,
      required String username}) async {
    var headers = {'x-jarvis-guid': '', 'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse(APIURL.signUp));
    request.body = json
        .encode({"email": email, "password": password, "username": username});
    request.headers.addAll(headers);
    print('username: $username , email : $email , password : $password ,  '  );
    try {
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 201) {
        String responseBody = await response.stream.bytesToString();
        print("-------------------------------------");
        print('Success: $responseBody');
        print("-------------------------------------");
        return true;
      } else {
        print("-------------------------------------");
        print('Error: ${response.statusCode} - ${response.reasonPhrase}');
        print("-------------------------------------");
        return false;

      }
    } catch (e) {
      print('Exception caught: $e');
    }
    return false;

  }

  static Future<void> logOut() async {
    token = (await TokenManager.getToken())!;
    print("current token $token}");
    var headers = {'x-jarvis-guid': '', 'Authorization': 'Bearer $token'};
    var request = http.Request('GET', Uri.parse(APIURL.signOut));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    print('-----------------------------------------------');
    print('--------------------LOG OUT--------------------');
    print('-----------------------------------------------');

    await TokenManager.deleteToken();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      await TokenManager.deleteToken();
      token = (await TokenManager.getToken()) ?? '';
      tokenRefresh = (await TokenManager.getRefreshToken()) ?? '';

      print('-----------------------------------------------');
      print('-------LOG OUT SUCCESSFULLY--------------------');
      print('-----------------------------------------------');

    } else {
      print(await response.stream.bytesToString());
    }
  }

  static Future<bool> ensureTokenIsValid() async {

    token = await TokenManager.getToken() ?? '';
    tokenRefresh =  await TokenManager.getRefreshToken() ?? '';
    //print('token $token and token refresh $tokenRefresh' );

    bool isCurrentTokenExpired = await isTokenExpired( token: token);
    bool isCurrentTokenRefreshExpired = await isTokenExpired(token: tokenRefresh );

    /*nếu chưa hết hạn */
    if (!isCurrentTokenExpired){
      getCurrentUser();
      return true;}

    /*Nếu hết hạn nhưng refresh chưa hết hạn */
    if (isCurrentTokenExpired && !isCurrentTokenRefreshExpired) {
      await refreshToken();
      return true;
    }

    /*Cả hai đều hết hạng */
    return false;
  }


  static Future<bool> isTokenExpired({required String token}) async {
    if (token.isNotEmpty) {
      try {
        final payload = token.split('.')[1];
        final decoded = utf8.decode(base64Url.decode(base64Url.normalize(payload)));
        final data = json.decode(decoded);

        final exp = data['exp'] as int;
        final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;

        //print(exp);
        return now > exp;
      } catch (e) {
        print("Error parsing token: $e");
      }
    }
    return true;
  }

  static Future<void> refreshToken() async {

    tokenRefresh = await TokenManager.getRefreshToken() as String;

    print("TokenRefresh $tokenRefresh");
    var headers = {'x-jarvis-guid': ''};
    var request =
        http.Request('GET', Uri.parse('${APIURL.refreshToken}?refreshToken=$tokenRefresh'));

    request.headers.addAll(headers);

    print('-----------------------------------------------');
    print('--------------REFRESH TOKEN--------------------');
    print('-----------------------------------------------');
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {

      final responseBody = await response.stream.bytesToString();
      final jsonResponse = json.decode(responseBody);
      final newToken = jsonResponse['token']['accessToken'];
      print("new token $newToken");

      /*Token Refresh không đổi*/
      await TokenManager.saveToken(newToken,tokenRefresh);

    } else {
      print("Fail ${response.reasonPhrase}");
    }
  }
}
