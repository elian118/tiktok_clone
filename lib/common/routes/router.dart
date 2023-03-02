import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/videos/screens/video_recording_screen.dart';

// go_router 전용
final router = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const VideoRecordingScreen(),
    )
  ],
);
