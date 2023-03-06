import 'package:shared_preferences/shared_preferences.dart';

class PlaybackConfigRepository {
  static const String _darkMode = 'darkMode';
  static const String _autoplay = 'autoplay';
  static const String _muted = 'muted';

  final SharedPreferences _preferences;

  PlaybackConfigRepository(this._preferences);

  Future<void> setDarkMode(bool value) async {
    _preferences.setBool(_darkMode, value);
  }

  Future<void> setMuted(bool value) async {
    _preferences.setBool(_muted, value);
  }

  Future<void> setAutoplay(bool value) async {
    _preferences.setBool(_autoplay, value);
  }

  bool isDarkMode() => _preferences.getBool(_darkMode) ?? false;

  bool isMuted() => _preferences.getBool(_muted) ?? false;

  bool isAutoplay() => _preferences.getBool(_autoplay) ?? false;
}
