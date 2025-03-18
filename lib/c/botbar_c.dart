import 'package:climbcost_profit_overhang_174_t/Analytics/analytics.dart';
import 'package:climbcost_profit_overhang_174_t/Ascents/Ascents.dart';
import 'package:climbcost_profit_overhang_174_t/Gear/Gear.dart';
import 'package:climbcost_profit_overhang_174_t/insurance/insurance.dart';
import 'package:climbcost_profit_overhang_174_t/c/color_c.dart';
import 'package:climbcost_profit_overhang_174_t/c/moti_c.dart';
import 'package:climbcost_profit_overhang_174_t/ss/ss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CBotomBar extends StatefulWidget {
  const CBotomBar({super.key, this.indexScr = 0});
  final int indexScr;

  @override
  State<CBotomBar> createState() => CBotomBarState();
}

class CBotomBarState extends State<CBotomBar> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.indexScr;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 80,
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        margin: EdgeInsets.only(
          right: 32.w,
          left: 32.w,
        ),
        decoration: BoxDecoration(
          color: ColorC.grey,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildNavItem(
              0,
              'assets/icons/f_1.png',
              'assets/icons/t_1.png',
            ),
            buildNavItem(
              1,
              'assets/icons/f_2.png',
              'assets/icons/t_2.png',
            ),
            buildNavItem(
              2,
              'assets/icons/f_3.png',
              'assets/icons/t_3.png',
            ),
            buildNavItem(
              3,
              'assets/icons/f_4.png',
              'assets/icons/t_4.png',
            ),
            buildNavItem(
              4,
              'assets/icons/f_5.png',
              'assets/icons/t_5.png',
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNavItem(int index, String iconPath, String iconTrue) {
    bool isActive = _currentIndex == index;

    return CMotiBut(
      onPressed: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Image.asset(
        isActive ? iconTrue : iconPath,
        width: 32,
        height: 32,
        color: isActive ? null : ColorC.white.withOpacity(0.3),
      ),
    );
  }

  final _pages = <Widget>[
    const Ascents(),
    const Insurance(),
    const Gear(),
    const Analytics(),
    const Ss(),
  ];
}
