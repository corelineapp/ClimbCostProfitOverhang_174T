import 'package:climbcost_profit_overhang_174_t/Ascents/ascett_com_page.dart';
import 'package:climbcost_profit_overhang_174_t/Ascents/ascett_pla_page.dart';
import 'package:climbcost_profit_overhang_174_t/c/cliimboopr.dart';
import 'package:climbcost_profit_overhang_174_t/c/color_c.dart';
import 'package:climbcost_profit_overhang_174_t/c/moti_c.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class Ascents extends StatefulWidget {
  const Ascents({super.key});

  @override
  State<Ascents> createState() => _AscentsState();
}

class _AscentsState extends State<Ascents> {
  @override
  Widget build(BuildContext context) {
    final klimbitpr = context.watch<Klimbitpr>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'My Ascents',
          style: TextStyle(
            color: ColorC.white,
            fontWeight: FontWeight.w500,
            fontSize: 28.sp,
            height: 1.sp,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 31.w, vertical: 24.h),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Planned ascents',
                      style: TextStyle(
                        color: ColorC.whiFAFAFA,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        height: 1.sp,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Cards: ',
                      style: TextStyle(
                        color: ColorC.whiFAFAFA.withOpacity(0.7),
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp,
                        height: 1.sp,
                      ),
                    ),
                    Text(
                      '${klimbitpr.ascektikLi.where(
                            (element) => !element.isVso,
                          ).toList().length}',
                      style: TextStyle(
                        color: ColorC.blue,
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp,
                        height: 1.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8.h,
                ),
                Row(
                  children: [
                    Text(
                      'Completed ascents',
                      style: TextStyle(
                        color: ColorC.whiFAFAFA,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        height: 1.sp,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Cards: ',
                      style: TextStyle(
                        color: ColorC.whiFAFAFA.withOpacity(0.7),
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp,
                        height: 1.sp,
                      ),
                    ),
                    Text(
                      '${klimbitpr.ascektikLi.where(
                            (element) => element.isVso,
                          ).toList().length}',
                      style: TextStyle(
                        color: ColorC.blue,
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp,
                        height: 1.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 32.h,
                ),
                CMotiBut(
                  onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const AscettPlaPage(),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: Image.asset(
                      'assets/images/pla.png',
                      fit: BoxFit.fill,
                      height: 160.h,
                      width: double.infinity,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                CMotiBut(
                  onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const AscettComPage(),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: Image.asset(
                      'assets/images/com.png',
                      fit: BoxFit.fill,
                      height: 160.h,
                      width: double.infinity,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
