import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:som_spot/share/controller/screen_export.dart';

import '../../../utils/api_urls/api_urls.dart';

class AppVideoOverlay {
  static void show(
    BuildContext context, {
    required String videoUrl,
    String? title,
  }) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Video",
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (_, _, _) {
        return Center(
          child: AppVideoPlayer(
            url: getVideoUrl(
              // "https://nc5cnwcx-8000.inc1.devtunnels.ms/uploads/draftVideo/1785900922470-534162-21.mp4" ??
              videoUrl,
              ApiUrls.base, // your actual base url
            ),
            title: title,
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: CurvedAnimation(parent: animation, curve: Curves.easeOut),
            child: child,
          ),
        );
      },
    );
  }

  static String getVideoUrl(String? videoUrl, String baseUrl) {
    if (videoUrl == null || videoUrl.trim().isEmpty) {
      return '';
    }

    var url = videoUrl.trim();

    url = url.replaceAll("\\", "/");

    if (url.startsWith('http://') || url.startsWith('https://')) {
      return url;
    }

    return '${baseUrl.replaceAll(RegExp(r'/$'), '')}/${url.replaceFirst(RegExp(r'^/'), '')}';
  }
}

class AppVideoPlayer extends StatefulWidget {
  const AppVideoPlayer({super.key, required this.url, this.title});

  final String url;
  final String? title;

  @override
  State<AppVideoPlayer> createState() => _AppVideoPlayerState();
}

class _AppVideoPlayerState extends State<AppVideoPlayer> {
  late final Player player;
  late final VideoController videoController;
  String? videoError;

  @override
  void initState() {
    super.initState();

    player = Player();
    videoController = VideoController(
      player,
      configuration: const VideoControllerConfiguration(
        enableHardwareAcceleration: true,
      ),
    );

    debugPrint("🎬 VIDEO URL: ${widget.url}");

    player.stream.playing.listen((playing) {
      debugPrint("▶️ Playing: $playing");
    });

    player.stream.position.listen((position) {
      debugPrint("⏱ Position: $position");
    });

    player.stream.duration.listen((duration) {
      debugPrint("⌛ Duration: $duration");
    });

    player.stream.buffer.listen((buffer) {
      debugPrint("📦 Buffer: $buffer");
    });

    player.stream.width.listen((width) {
      debugPrint("📐 Video Width: $width");
    });

    player.stream.height.listen((height) {
      debugPrint("📏 Video Height: $height");
    });

    player.stream.completed.listen((value) {
      debugPrint("COMPLETED: $value");
    });
    videoController.player.stream.videoParams.listen((params) {
      debugPrint("VIDEO PARAMS: $params");
    });

    player.stream.error.listen((error) {
      debugPrint("""
  ❌ MEDIA KIT ERROR

  URL:
  ${widget.url}

  Error:
  $error

  State:
  ${player.state}
  """);
      if (!mounted) return;

      setState(() {
        videoError = error.toString();
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _openVideo();
    });
  }

  Future<void> _openVideo() async {
    try {
      debugPrint("🚀 Opening video...");

      await player.open(Media(widget.url), play: true);

      debugPrint("✅ Video opened");

      debugPrint("""
      PLAYER STATE:
      Playing: ${player.state.playing}
      Position: ${player.state.position}
      Duration: ${player.state.duration}
      Volume: ${player.state.volume}
      """);
    } catch (e, stack) {
      debugPrint("🔥 OPEN VIDEO ERROR: $e");
      debugPrint(stack.toString());

      if (!mounted) return;

      setState(() {
        videoError = "Unable to play this video";
      });
    }
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * .92,
          height: MediaQuery.of(context).size.height * .4,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(20),
          ),
          // clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              // Header
              Container(
                height: 56,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                color: Colors.black87,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.title ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Gap(30),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: ColoredBox(
                      color: Colors.black,
                      child: videoError != null
                          ? _VideoErrorView(
                              onRetry: () {
                                setState(() {
                                  videoError = null;
                                });

                                _openVideo();
                              },
                            )
                          : Video(
                              controller: videoController,
                              fit: BoxFit.contain,

                              fill: Colors.black,
                              controls: MaterialVideoControls,
                              wakelock: true,
                              pauseUponEnteringBackgroundMode: true,
                              resumeUponEnteringForegroundMode: true,
                            ),
                    ),
                  ),
                ),
              ),

              /*
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  margin: EdgeInsets.all(12),
                  color: Colors.white,
                  child: videoError != null
                      ? _VideoErrorView(
                          onRetry: () {
                            setState(() {
                              videoError = null;
                            });

                            _openVideo();
                          },
                        )
                      :
                        // Video(
                        //     controller: videoController,
                        //     fit: BoxFit.contain,
                        //     fill: Colors.black,
                        //     controls: AdaptiveVideoControls,
                        //     filterQuality: FilterQuality.high,
                        //     wakelock: true,
                        //     pauseUponEnteringBackgroundMode: true,
                        //     resumeUponEnteringForegroundMode: true,
                        //     onEnterFullscreen: () async {
                        //       await defaultEnterNativeFullscreen();
                        //     },
                        //     onExitFullscreen: () async {
                        //       await defaultExitNativeFullscreen();
                        //     },
                        //   ),
                        Video(
                          controller: videoController,
                          fit: BoxFit.contain,
                          fill: Colors.black,
                          controls: MaterialVideoControls,
                          wakelock: true,
                          pauseUponEnteringBackgroundMode: true,
                          resumeUponEnteringForegroundMode: true,
                        ),
                ),
              ),
*/
            ],
          ),
        ),
      ),
    );
  }
}

class _VideoErrorView extends StatelessWidget {
  final VoidCallback onRetry;

  const _VideoErrorView({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.white, size: 42),

            const SizedBox(height: 12),

            const Text(
              "Unable to play video",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              "The video may be unavailable or the connection failed.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 13),
            ),

            const SizedBox(height: 16),

            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text("Try again"),
            ),
          ],
        ),
      ),
    );
  }
}
