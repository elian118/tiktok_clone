import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/common/constants/rawData/video_data.dart';
import 'package:tiktok_clone/features/videos/models/video_model.dart';

class TimelineViewModel extends AsyncNotifier<List<VideoModel>> {
  List<VideoModel> _list = [
    // 임시 데이터 -> api 연동 후 없앨 예정
    for (var rawVideo in rawVideos) VideoModel(title: rawVideo),
  ];

  void uploadVideo() async {
    state = const AsyncValue.loading(); // 데이터를 가져오기 전까지 초기값을 로딩상태로 만든다.
    await Future.delayed(const Duration(seconds: 2)); // 2초 후에 데이터가 온다고 가정(테스트)
    final newVideo = VideoModel(title: '${DateTime.now()}');
    _list = [..._list, newVideo];
    // AsyncNotifier 상속 클래스 -> AsyncValue.data(newValue) 사용해 변경. state = _list 불가.
    state = AsyncValue.data(_list);
  }

  @override
  FutureOr<List<VideoModel>> build() async {
    await Future.delayed(const Duration(seconds: 5)); // 5초 후에 데이터가 온다고 가정(테스트)
    // throw Exception("OMG can't fetch!");
    return _list;
  }
}

final timelineProvider =
    AsyncNotifierProvider<TimelineViewModel, List<VideoModel>>(
  () => TimelineViewModel(),
);
