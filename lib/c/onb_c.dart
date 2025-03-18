import 'package:climbcost_profit_overhang_174_t/c/color_c.dart';
import 'package:climbcost_profit_overhang_174_t/c/moti_c.dart';
import 'package:climbcost_profit_overhang_174_t/pppp/pppp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class COnBoDi extends StatefulWidget {
  const COnBoDi({super.key});

  @override
  State<COnBoDi> createState() => _COnBoDiState();
}

class _COnBoDiState extends State<COnBoDi> {
  final PageController _controller = PageController();
  int introIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            physics: const ClampingScrollPhysics(),
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                introIndex = index;
              });
            },
            children: const [
              OnWid(
                image: '1',
              ),
              OnWid(
                image: '2',
              ),
              OnWid(
                image: '3',
              ),
            ],
          ),
          Positioned(
            top: 650.h,
            left: 28.w,
            right: 28.w,
            bottom: 0,
            child: Row(
              children: [
                Expanded(
                  child: CMotiBut(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Pppp(),
                        ),
                        (protected) => false,
                      );
                    },
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.transparent,
                      ),
                      child: Center(
                        child: Text(
                          'Skip',
                          style: TextStyle(
                            color: ColorC.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                            height: 1.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: CMotiBut(
                    onPressed: () {
                      if (introIndex != 2) {
                        _controller.animateToPage(
                          introIndex + 1,
                          duration: const Duration(milliseconds: 350),
                          curve: Curves.ease,
                        );
                      } else {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Pppp(),
                          ),
                          (protected) => false,
                        );
                      }
                    },
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: ColorC.blue,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            introIndex != 2 ? 'Next' : 'Start',
                            style: TextStyle(
                              color: ColorC.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp,
                              height: 1.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnWid extends StatelessWidget {
  const OnWid({
    super.key,
    required this.image,
  });
  final String image;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/on$image.png',
      height: 812.h,
      width: 375.w,
      fit: BoxFit.cover,
      alignment: Alignment.bottomCenter,
    );
  }
}
