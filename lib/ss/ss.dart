import 'package:climbcost_profit_overhang_174_t/c/color_c.dart';
import 'package:climbcost_profit_overhang_174_t/c/dok_c.dart';
import 'package:climbcost_profit_overhang_174_t/c/moti_c.dart';
import 'package:climbcost_profit_overhang_174_t/c/precliubmo.dart';
import 'package:climbcost_profit_overhang_174_t/c/pro_c.dart';
import 'package:climbcost_profit_overhang_174_t/pppp/pppp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';

class Ss extends StatelessWidget {
  const Ss({super.key});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: getClimboProfff(),
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: false,
              title: Text(
                'Settings',
                style: TextStyle(
                  color: ColorC.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 28.sp,
                  height: 1.sp,
                ),
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 150),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    if (snapshot.data == false)
                      Stack(
                        children: [
                          Image.asset(
                            'assets/images/set_prem.png',
                          ),
                          Positioned(
                            bottom: 20,
                            left: 16,
                            right: 16,
                            child: CMotiBut(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => const Pppp(
                                      isSet: true,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: double.infinity,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: ColorC.yellow,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/icons/prem.png',
                                      width: 24,
                                      height: 24,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      'Go premium',
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
                    SizedBox(height: 16.h),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: ColorC.grey,
                      ),
                      child: Column(
                        children: [
                          S(
                            t: 'Privacy Policy',
                            i: '1',
                            onPressed: () {
                              lauchUrl(context, DokC.priPoli);
                            },
                          ),
                          Divider(
                            height: 0,
                            color: Colors.grey.withOpacity(0.3),
                          ),
                          S(
                            t: 'Terms of Use',
                            i: '2',
                            onPressed: () {
                              lauchUrl(context, DokC.terOfUse);
                            },
                          ),
                          Divider(
                            height: 0,
                            color: Colors.grey.withOpacity(0.3),
                          ),
                          S(
                            t: 'Support',
                            i: '3',
                            onPressed: () {
                              lauchUrl(context, DokC.suprF);
                            },
                          ),
                          Divider(
                            height: 0,
                            color: Colors.grey.withOpacity(0.3),
                          ),
                          S(
                            t: 'Share',
                            i: '4',
                            onPressed: () {
                              Share.share('https://apps.apple.com/us/app/climbcost-profit-overhang/id6743397450');
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class S extends StatelessWidget {
  const S({
    super.key,
    required this.t,
    required this.i,
    required this.onPressed,
  });
  final String t;
  final String i;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return CMotiBut(
      onPressed: onPressed,
      child: Container(
        width: double.infinity,
        height: 65,
        padding: const EdgeInsets.only(left: 20),
        color: Colors.transparent,
        child: Row(
          children: [
            Image.asset(
              'assets/icons/set$i.png',
              width: 28,
              height: 28,
            ),
            const SizedBox(width: 5),
            Text(
              t,
              style: TextStyle(
                color: ColorC.white,
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                height: 1.sp,
              ),
            ),
            const Spacer(),
            Image.asset(
              'assets/icons/arrow-right.png',
              width: 28,
              height: 28,
            ),
            const SizedBox(width: 15),
          ],
        ),
      ),
    );
  }
}
