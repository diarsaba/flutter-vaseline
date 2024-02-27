import 'package:flutter/material.dart';

class SoundWaveController {
  late void Function() resetAnimation;
}

class SoundWave extends StatefulWidget {
  const SoundWave({
    super.key,
    required this.onStartRecord,
    required this.onStopRecord,
    required this.controller,
  });
  final Function() onStartRecord;
  final Function() onStopRecord;
  final SoundWaveController controller;

  @override
  State<SoundWave> createState() => _SoundWaveState(controller);
}

class _SoundWaveState extends State<SoundWave> with TickerProviderStateMixin {
  late AnimationController controller;
  _SoundWaveState(SoundWaveController controllers) {
    controllers.resetAnimation = resetAnimation;
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void resetAnimation() {
    controller.reset();
  }

  @override
  Widget build(BuildContext context) {
    const count = 8;
    const minHeight = 6.0;
    const maxHeight = 30.0;
    const duration = 2000;
    return InkWell(
      hoverColor: null,
      focusColor: null,
      overlayColor: null,
      highlightColor: null,
      splashColor: null,
      onTap: () {
        if (controller.isAnimating) {
          //controller.reset();
          widget.onStopRecord();
        } else {
          controller.repeat();
          widget.onStartRecord();
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10, top: 8),
        child: SizedBox(
          height: 30,
          child: AnimatedBuilder(
            animation: controller,
            builder: (c, child) {
              double t = controller.value;
              int current = (count * t).floor();
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  count,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: duration ~/ count),
                    margin: index == (count - 1)
                        ? EdgeInsets.zero
                        : const EdgeInsets.only(right: 5),
                    height: index == current
                        ? controller.isAnimating
                            ? maxHeight
                            : minHeight
                        : minHeight,
                    width: 6,
                    decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(9999)),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
