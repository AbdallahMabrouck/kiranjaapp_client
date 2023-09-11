import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({super.key});

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

final _controller = PageController(
  initialPage: 0,
);

int _currentPage = 0;

List<Widget> _pages = [
  Column(
    children: [
      Expanded(child: Image.asset("assets/images/image22.png")),
      const Text(
        "Start Selling Online Effortlessly",
        style: kPageViewTextStyle,
        textAlign: TextAlign.center,
      )
    ],
  ),
  Column(
    children: [
      Expanded(child: Image.asset("assets/images/image1.png")),
      const Text("Get Customers and Earn Profit",
          style: kPageViewTextStyle, textAlign: TextAlign.center)
    ],
  ),
  Column(
    children: [
      Expanded(child: Image.asset("assets/images/image11.png")),
      const Text("Be Your Own Boss",
          style: kPageViewTextStyle, textAlign: TextAlign.center),
    ],
  ),
];

class _OnBoardScreenState extends State<OnBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView(
            controller: _controller,
            children: _pages,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        DotsIndicator(
          dotsCount: _pages.length,
          position: _currentPage.toDouble(),
          decorator: DotsDecorator(
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeColor: Theme.of(context).primaryColor,
            activeShape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
