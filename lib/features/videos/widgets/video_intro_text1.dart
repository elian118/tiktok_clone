import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/common/constants/sizes.dart';
import 'package:tiktok_clone/utils/utils.dart';

class VideoIntroText1 extends StatelessWidget {
  const VideoIntroText1({
    super.key,
    required bool isSeeMore,
    required String descText,
    required TapGestureRecognizer tapRecognizer,
  })  : _isSeeMore = isSeeMore,
        _descText = descText,
        _tapRecognizer = tapRecognizer;

  final bool _isSeeMore;
  final String _descText;
  final TapGestureRecognizer _tapRecognizer;

  @override
  Widget build(BuildContext context) {
    return RichText(
      softWrap: false,
      overflow: TextOverflow.ellipsis,
      maxLines: _isSeeMore ? 5 : 1,
      text: TextSpan(
        style: const TextStyle(
          color: Colors.white,
          fontSize: Sizes.size16,
        ),
        children: <TextSpan>[
          TextSpan(
            text: '${_descText.substring(
              0,
              _isSeeMore
                  ? _descText.length
                  : (Utils.getWinWidth(context) * 0.75 / 9).ceil(),
            )}${_isSeeMore ? '' : '...'}',
            // 'Watching wild flowers',
          ),
          TextSpan(
            recognizer: _tapRecognizer,
            text: _isSeeMore ? '  Briefly...' : '  See More...',
            style: const TextStyle(
              color: Colors.white,
              fontSize: Sizes.size18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
