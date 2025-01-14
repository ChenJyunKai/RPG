import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class BreakfastView extends StatelessWidget {
  const BreakfastView({
    Key? key,
    required this.animationController,
    required this.onNextClick,
  }) : super(key: key);

  final AnimationController animationController;
  final Function(int) onNextClick;
  static const List<String> options = ["醬油", "醬油膏", "番茄醬", "糖醋醬"];

  Animation<Offset> createSlideAnimation(double end) {
    return Tween<Offset>(begin: const Offset(0, 0), end: Offset(end, 0)).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.25, 0.5, curve: Curves.fastOutSlowIn),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final firstHalfAnimation = Tween<Offset>(begin: const Offset(0, 1), end: const Offset(0, 0)).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.0,
          0.25,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
    final titleAnimation = createSlideAnimation(-1);
    final optionsAnimation = createSlideAnimation(-2);
    final imageAnimation = createSlideAnimation(-4);

    return LayoutBuilder(
      builder: (context, constraints) {
        return SlideTransition(
          position: firstHalfAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SlideTransition(
                position: titleAnimation,
                child: Container(
                  width: constraints.maxWidth,
                  alignment: Alignment.center,
                  child: const Text(
                    "早餐的荷包蛋應該沾...?",
                    style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SlideTransition(
                position: optionsAnimation,
                child: Container(
                  height: constraints.maxHeight * 0.5,
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 36),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      for (String i in options)
                        SizedBox(
                          height: 50,
                          width: constraints.maxWidth * 0.7,
                          child: ElevatedButton(
                            onPressed: () => onNextClick(options.indexOf(i)),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.black,
                              backgroundColor: Colors.white,
                            ),
                            child: Text(i, style: const TextStyle(fontSize: 20)),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              SlideTransition(
                position: imageAnimation,
                child: Lottie.asset('assets/lottie/breakfast.json', height: 150),
              ),
            ],
          ),
        );
      },
    );
  }
}
