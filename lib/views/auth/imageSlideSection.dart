import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:possystem/utils/appColors.dart';
import 'package:possystem/utils/appTexts.dart';

class ImageSlideSection extends StatefulWidget {
  const ImageSlideSection({super.key});

  @override
  State<ImageSlideSection> createState() => _ImageSlideSectionState();
}

class _ImageSlideSectionState extends State<ImageSlideSection> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> _texts = [
    'Pretzley brings a range of exciting and bold flavors, pushing the boundaries of traditional pretzel-making to cater to diverse taste preferences.',
    'Experience the perfect blend of traditional craftsmanship and modern innovation in every bite of our artisanal pretzels.',
    'Join us in redefining the pretzel experience with our unique flavors and commitment to quality.',
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Image
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/login/login-1.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // SVG Overlay 1
        Positioned(
          top: 30,
          left: 10,
          child: SvgPicture.asset(
            'assets/svg/login/watermark.svg',
            alignment: Alignment.topLeft,
            width: MediaQuery.of(context).size.width * 0.2,
            fit: BoxFit.contain,
          ),
        ),
        // SVG Overlay 2
        Positioned(
          bottom: 140,
          left: 50,
          child: SvgPicture.asset(
            'assets/svg/login/comma.svg',
            alignment: Alignment.bottomLeft,
            width: MediaQuery.of(context).size.width * 0.04,
            fit: BoxFit.contain,
          ),
        ),
        // Text Overlay
        Positioned(
          bottom: 6,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              spacing: 6,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: 80,
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      itemCount: _texts.length,
                      itemBuilder: (context, index) {
                        return Text(
                          _texts[index],
                          style:
                              AppTexts.regular(size: 18, color: Colors.white),
                          textAlign: TextAlign.center,
                        );
                      },
                    ),
                  ),
                ),
                // Page indicator bubbles
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _texts.length,
                    (index) => GestureDetector(
                      onTap: () {
                        _pageController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: index == _currentPage
                              ? AppColors.secondary
                              : AppColors.inactive,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
