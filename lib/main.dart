import 'dart:developer';

import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:preload_page_view/preload_page_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'PreloadPageView Demo',
      home: PreloadPageViewDemo(),
    );
  }
}

class PreloadPageViewDemo extends StatefulWidget {
  const PreloadPageViewDemo({super.key});

  @override
  PreloadPageViewState createState() => PreloadPageViewState();
}

class PreloadPageViewState extends State<PreloadPageViewDemo> {
  final List<String> videoUrls = [
    'https://devstreaming-cdn.apple.com/videos/streaming/examples/adv_dv_atmos/main.m3u8?ref=developerinsider.co',
    'https://sample.vodobox.net/skate_phantom_flex_4k/skate_phantom_flex_4k.m3u8?ref=developerinsider.co',
    'https://content.jwplatform.com/manifests/vM7nH0Kl.m3u8?ref=developerinsider.co',
    'https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8?ref=developerinsider.co',
    'https://test-streams.mux.dev/dai-discontinuity-deltatre/manifest.m3u8?ref=developerinsider.co',
    'https://flipfit-cdn.akamaized.net/flip_hls/661f570aab9d840019942b80-473e0b/video_h1.m3u8?ref=developerinsider.co',
    'https://flipfit-cdn.akamaized.net/flip_hls/662aae7a42cd740019b91dec-3e114f/video_h1.m3u8?ref=developerinsider.co',
    'https://flipfit-cdn.akamaized.net/flip_hls/663e5a1542cd740019b97dfa-ccf0e6/video_h1.m3u8?ref=developerinsider.co',
    'https://flipfit-cdn.akamaized.net/flip_hls/663d1244f22a010019f3ec12-f3c958/video_h1.m3u8?ref=developerinsider.co',
    'https://flipfit-cdn.akamaized.net/flip_hls/664ce52bd6fcda001911a88c-8f1c4d/video_h1.m3u8?ref=developerinsider.co',
    'https://flipfit-cdn.akamaized.net/flip_hls/664d87dfe8e47500199ee49e-dbd56b/video_h1.m3u8?ref=developerinsider.co',

    'https://devstreaming-cdn.apple.com/videos/streaming/examples/adv_dv_atmos/main.m3u8?ref=developerinsider.co',
    'https://sample.vodobox.net/skate_phantom_flex_4k/skate_phantom_flex_4k.m3u8?ref=developerinsider.co',
    'https://content.jwplatform.com/manifests/vM7nH0Kl.m3u8?ref=developerinsider.co',
    'https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8?ref=developerinsider.co',
    'https://test-streams.mux.dev/dai-discontinuity-deltatre/manifest.m3u8?ref=developerinsider.co',
    'https://flipfit-cdn.akamaized.net/flip_hls/661f570aab9d840019942b80-473e0b/video_h1.m3u8?ref=developerinsider.co',
    'https://flipfit-cdn.akamaized.net/flip_hls/662aae7a42cd740019b91dec-3e114f/video_h1.m3u8?ref=developerinsider.co',
    'https://flipfit-cdn.akamaized.net/flip_hls/663e5a1542cd740019b97dfa-ccf0e6/video_h1.m3u8?ref=developerinsider.co',
    'https://flipfit-cdn.akamaized.net/flip_hls/663d1244f22a010019f3ec12-f3c958/video_h1.m3u8?ref=developerinsider.co',
    'https://flipfit-cdn.akamaized.net/flip_hls/664ce52bd6fcda001911a88c-8f1c4d/video_h1.m3u8?ref=developerinsider.co',
    'https://flipfit-cdn.akamaized.net/flip_hls/664d87dfe8e47500199ee49e-dbd56b/video_h1.m3u8?ref=developerinsider.co',

  ];

  int _currentPage = 0; // Biến lưu vị trí hiện tại
  late PreloadPageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PreloadPageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PreloadPageView Demo"),
      ),
      body: PreloadPageView.builder(
        itemCount: videoUrls.length,
        scrollDirection: Axis.vertical,
        preloadPagesCount: 10,
        itemBuilder: (BuildContext context, int position) {
          return DemoPage(position, videoUrls[position], isCurrentPage: position == _currentPage);
        },
        controller: _pageController,
        onPageChanged: (int position) {
          log('Page changed. Current: $position');
          setState(() {
            _currentPage = position;
          });
        },
      ),
    );
  }
}

class DemoPage extends StatefulWidget {
  const DemoPage(this.index, this.videoUrl, {required this.isCurrentPage, super.key});

  final int index;
  final String videoUrl;
  final bool isCurrentPage;

  @override
  DemoPageState createState() => DemoPageState();
}

class DemoPageState extends State<DemoPage> {
  late BetterPlayerController _betterPlayerController;

  @override
  void initState() {
    super.initState();
    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      widget.videoUrl,
      videoFormat: BetterPlayerVideoFormat.hls,
      videoExtension: ".m3u8",
      bufferingConfiguration: const BetterPlayerBufferingConfiguration(
        minBufferMs: 2000,
        maxBufferMs: 5000,
        bufferForPlaybackMs: 1000,
        bufferForPlaybackAfterRebufferMs: 2000,
      ),
    );
    _betterPlayerController = BetterPlayerController(
      BetterPlayerConfiguration(
        autoPlay: widget.isCurrentPage,
        aspectRatio: 16 / 9,
        controlsConfiguration: const BetterPlayerControlsConfiguration(
            enablePlayPause: true,
            enableMute: false,
            enableFullscreen: false,
            enableSkips: false,
            showControls: false),
      ),
      betterPlayerDataSource: betterPlayerDataSource,
    );
  }

  @override
  void didUpdateWidget(covariant DemoPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isCurrentPage) {
      _betterPlayerController.play();
    } else {
      _betterPlayerController.pause();
    }
  }

  @override
  void dispose() {
    _betterPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log('Page loaded: ${widget.index}');
    return Center(
      child: BetterPlayer(
        controller: _betterPlayerController,
      ),
    );
  }
}
