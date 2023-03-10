import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/videos/models/playback_config_model.dart';
import 'package:tiktok_clone/features/videos/repos/playback_config_repo.dart';

class PlaybackConfigViewModel extends Notifier<PlaybackConfigModel> {
  final PlaybackConfigRepository _repository;

  PlaybackConfigViewModel(this._repository);

  void setDarkMode(bool value) {
    _repository.setDarkMode(value);
    state = PlaybackConfigModel(
      darkMode: value,
      muted: state.muted,
      autoplay: state.autoplay,
    );
  }

  void setMuted(bool value) {
    _repository.setMuted(value);
    // state 재정의(setState 유사)
    state = PlaybackConfigModel(
      darkMode: state.darkMode,
      muted: value,
      autoplay: state.autoplay, // build() 리턴값이 get state{}에 담겨 전달
    );
  }

  void setAutoplay(bool value) {
    _repository.setAutoplay(value);
    state = PlaybackConfigModel(
      darkMode: state.darkMode,
      muted: state.muted,
      autoplay: value,
    );
  }

  // Notifier.build(): riverpod 설치 후 Notifier 상속 시 구현해야 하는 필수 메서드
  //  변경사항 감지하면 build() 재실행 => StatefulWidget 과 작동방식 동일
  @override
  build() {
    // 화면이 보길 바라는 초기상태 반환해야 함 => 모델 초기화코드를 여기에 넣어준다.
    // 아래 초기화 리턴문은 Notifier 상속클래스 내에서 변수 state 로 결과를 반환한다.
    return PlaybackConfigModel(
      darkMode: _repository.isDarkMode(),
      muted: _repository.isMuted(),
      autoplay: _repository.isAutoplay(),
    );
  }
}

// 외부로 export -> main.dart 에서 사용
final playbackConfigProvider =
    NotifierProvider<PlaybackConfigViewModel, PlaybackConfigModel>(
  () => throw UnimplementedError(), // 초기화 콜백: 예외 처리 후 main.dart 에서 오버라이드 위임
);

/*
  원래대로라면 초기화 함수로 아래와 같이 키 랩퍼를 매개변수 없이 넣어야 한다.

  final playbackConfigProvider =
      NotifierProvider<PlaybackConfigViewModel, PlaybackConfigModel>(
    () => PlaybackConfigViewModel(), // 초기화: 생성자 호출(매개변수 생성자 X)
  );

   하지만, 이 키 랩퍼는 매개변수로 main.dart 에서만 호출 가능한 SharedPreferences 인스턴스 필요
   -> 어쩔 수 없이, 여기서는 playbackConfigProvider 초기화가 불가능하므로,
      예외 처리 후 import 하는 main.dart 에 오버라이드 위임

   -> 이후 main.dart 에서 오버라이드 해주면,
     throw UnimplementedError() 가 실행되지 않고 정상 처리된다.

     // main.dart
     void main() async {
       WidgetsFlutterBinding.ensureInitialized();

       final preferences = await SharedPreferences.getInstance();
       final repository = PlaybackConfigRepository(preferences);

       runApp(ProviderScope(overrides: [
         playbackConfigProvider.overrideWith(
             () => PlaybackConfigViewModel(repository)) // 기기 저장소 연동 설정 오버라이드
       ], child: const TickTokApp()));
     }
 */
