// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ko locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ko';

  static String m0(nameOfTheApp) => "${nameOfTheApp} 계정으로 로그인";

  static String m1(nameOfTheApp) => "${nameOfTheApp}에 로그인하세요";

  static String m2(nameOfTheApp) => "${nameOfTheApp}에 가입하세요";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "accountLoginButton": m0,
        "alreadyHaveAnAccount":
            MessageLookupByLibrary.simpleMessage("이미 계정이 있습니까?"),
        "appleButton": MessageLookupByLibrary.simpleMessage("애플 계정으로 로그인"),
        "emailPasswordButton":
            MessageLookupByLibrary.simpleMessage("이메일 & 비밀번호"),
        "facebookButton": MessageLookupByLibrary.simpleMessage("페이스북 계정으로 로그인"),
        "googleButton": MessageLookupByLibrary.simpleMessage("구글 계정으로 로그인"),
        "logIn": MessageLookupByLibrary.simpleMessage("로그인"),
        "loginTitle": m1,
        "signUpSubtitle": MessageLookupByLibrary.simpleMessage(
            "프로필을 만들고, 다른 계정을 팔로우하고, 자신만의 비디오를 만드는 등의 작업을 수행할 수 있습니다."),
        "signUpTitle": m2
      };
}
