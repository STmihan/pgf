import 'package:shared_preferences/shared_preferences.dart';

const String DefaultGif =
    "https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExaWV1NWhudXpxZWkwOXVrdjFtYWpwOWM2YzNyaGs1MTI1YnduNG1yciZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9cw/7tAbc02I6uDiJ10fON/giphy.gif";

Future<void> saveParameter(String key, String value) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, value);
}

Future<String?> loadParameter(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(key);
}