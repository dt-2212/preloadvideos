import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:preloadvideos/video_screen.dart';
import 'package:preloadvideos/video_urls.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'M3U8 PLAYER',
      color: Colors.white,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const PreloadPageViewDemo()));
            },
            child: const Icon(Icons.video_collection, color: Colors.red, size: 50)),
      ),
    );
  }
}

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   late BetterPlayerController _betterPlayerController;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _preloadFirstVideo();
//   }
//
//   void _preloadFirstVideo() {
//     BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
//       BetterPlayerDataSourceType.network,
//       videoUrls[0],
//       videoFormat: BetterPlayerVideoFormat.hls,
//       videoExtension: ".m3u8",
//       bufferingConfiguration: const BetterPlayerBufferingConfiguration(
//         minBufferMs: 2000,
//         maxBufferMs: 5000,
//         bufferForPlaybackMs: 1000,
//         bufferForPlaybackAfterRebufferMs: 2000,
//       ),
//     );
//     _betterPlayerController = BetterPlayerController(
//         const BetterPlayerConfiguration(
//           autoPlay: false,
//         ),
//         betterPlayerDataSource: betterPlayerDataSource);
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     _betterPlayerController.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       child: Center(
//         child: ElevatedButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => PreloadPageViewDemo(
//                     preloadedController: _betterPlayerController,
//                   ),
//                 ),
//               );
//             },
//             child: const Icon(Icons.video_collection, color: Colors.red, size: 50)),
//       ),
//     );
//   }
// }
