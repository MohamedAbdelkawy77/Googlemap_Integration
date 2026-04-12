import 'package:shared_preferences/shared_preferences.dart';

class Savetoken {
  void setToken(String token) async {
    var pref = await SharedPreferences.getInstance();
    pref.setString("token", token);
  }

  Future<String> getToken() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString("token")!;
  }
}
