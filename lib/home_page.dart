import 'package:audioplayers/audioplayers.dart';
import 'package:calculator_3d/utils/calculator_config.dart';
import 'package:calculator_3d/utils/calculator_key_data.dart';
import 'package:calculator_3d/widgets/calculator_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> scaleAnimation;
  final FocusNode keyboardListenerFocusNode = FocusNode();
  CalculatorKeyType? tappedKeyType;
  final player = AudioPlayer();
  bool muted = false;

  void _playSound() {
    if (player.state == PlayerState.playing) {
      player.stop();
    }
    if (!muted) {
      player.play(AssetSource('keyboard_tap.wav'));
    }
  }

  void _onKeyTap(CalculatorKeyType keyType) {
    _playSound();
    setState(() {
      tappedKeyType = keyType;
    });
  }

  KeyEventResult _handleKeyboardEvent(FocusNode node, RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      if (event.data.physicalKey == PhysicalKeyboardKey.tab) {
        if (animationController.isCompleted) {
          animationController.reverse();
        } else {
          animationController.forward();
        }
        return KeyEventResult.handled;
      }

      final logicalKey = event.data.logicalKey;
      CalculatorKeyType? calculatorKeyType =
          CalculatorKeyType.getFromKey(logicalKey);
      if (calculatorKeyType != null) {
        _onKeyTap(calculatorKeyType);
        return KeyEventResult.handled;
      }
    }
    return KeyEventResult.ignored;
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(keyboardListenerFocusNode);
    Size screenSize = MediaQuery.of(context).size;
    double size = screenSize.width > 600 ? 460 : screenSize.width * 0.7;
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade200,
      body: Focus(
        focusNode: keyboardListenerFocusNode,
        onKey: _handleKeyboardEvent,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => setState(() => muted = !muted),
                    icon: Icon(muted ? Icons.volume_off : Icons.volume_up),
                  ),
                  const SizedBox(width: 20),
                  IconButton(
                    onPressed: () {
                      if (animationController.isCompleted) {
                        animationController.reverse();
                      } else {
                        animationController.forward();
                      }
                    },
                    icon: const Icon(Icons.threed_rotation_rounded),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Center(
                child: CalculatorView(
                  animationController: animationController,
                  onKeyTap: _onKeyTap,
                  currentTappedKey: tappedKeyType,
                  onKeyAnimationEnd: () {
                    setState(() {
                      tappedKeyType = null;
                    });
                  },
                  config: CalculatorConfig(
                    calculatorSide: size,
                    autoTransform: false,
                    // This can be used to have the calculator scale with the screen
                    // However the performance is not good and some glitches happen
                    // calculatorSide: screenSize.width * 0.6,
                    keysHaveShadow: true,
                  ),
                ),
              ),
              const SizedBox(height: 70),
              Align(
                alignment: Alignment.bottomRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text(
                      '@roaakdm',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'A 3d-ish/Isometric Calculator built with Flutter 💙',
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      "Inspired by @yoavikadosh's CSS implementation",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
