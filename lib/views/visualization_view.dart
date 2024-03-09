import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:hashcode/models/visualization_data.dart';

class VisualizationView extends StatefulWidget {
  final VisualizationData visualizationData;
  final String paragraph;

  const VisualizationView({super.key, 
    required this.visualizationData,
    required this.paragraph,
  });

  @override
  _VisualizationViewState createState() => _VisualizationViewState();
}

class _VisualizationViewState extends State<VisualizationView> {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _loadAudio(); // Load audio on initialization
  }

  Future<void> _loadAudio() async {
    await _audioPlayer.setUrl(widget.visualizationData.audio);
    _audioPlayer.playerStateStream.listen((playerState) {
      if (playerState.playing != _isPlaying) {
        setState(() {
          _isPlaying = playerState.playing;
        });
      }
    });
  }

  Future<void> _toggleAudio() async {
    if (_isPlaying) {
      await _audioPlayer.stop();
    } else {
      await _audioPlayer.play();
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(
            widget.visualizationData.image,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.paragraph,
                  style: const TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _toggleAudio,
                      icon: Icon(_isPlaying ? Icons.stop : Icons.play_arrow),
                      label: Text(_isPlaying ? 'Stop' : 'Play Audio'),
                    ),
                    const SizedBox(width: 8.0),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Close'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
