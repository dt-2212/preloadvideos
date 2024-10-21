import 'dart:developer';
import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:preloadvideos/video_urls.dart';

class PreloadPageViewDemo extends StatefulWidget {
  const PreloadPageViewDemo({super.key});

  @override
  PreloadPageViewState createState() => PreloadPageViewState();
}

class PreloadPageViewState extends State<PreloadPageViewDemo> {


  int _currentPage = 0;
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
        preloadPagesCount: 7,
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
          // enablePlayPause: true,
          // enableMute: false,
          // enableFullscreen: false,
          // enableSkips: false,
          showControls: false,
        ),
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
      child: BetterPlayer(controller: _betterPlayerController),
    );
  }
}
