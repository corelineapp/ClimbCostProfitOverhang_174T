import 'package:apphud/apphud.dart';
import 'package:climbcost_profit_overhang_174_t/c/botbar_c.dart';
import 'package:climbcost_profit_overhang_174_t/c/color_c.dart';
import 'package:climbcost_profit_overhang_174_t/c/dok_c.dart';
import 'package:climbcost_profit_overhang_174_t/c/moti_c.dart';
import 'package:climbcost_profit_overhang_174_t/c/precliubmo.dart';
import 'package:climbcost_profit_overhang_174_t/c/pro_c.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Pppp extends StatefulWidget {
  const Pppp({super.key, this.isSet = false});
  final bool isSet;
  @override
  State<Pppp> createState() => _PpppState();
}

class _PpppState extends State<Pppp> {
  bool isPPmfmfds = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/prem.png'),
            fit: BoxFit.cover,
            // alignment: Alignment.topCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        lauchUrl(context, DokC.terOfUse);
                      },
                      child: Text(
                        'Terms of use',
                        style: TextStyle(
                          color: const Color(0xFFFAFAFA),
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        climboProfffRes(context);
                      },
                      child: Text(
                        'Restore',
                        style: TextStyle(
                          color: const Color(0xFFFAFAFA),
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        lauchUrl(context, DokC.priPoli);
                      },
                      child: Text(
                        'Privacy Policy',
                        style: TextStyle(
                          color: const Color(0xFFFAFAFA),
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  'Get premium\nJust for \$0.99',
                  style: TextStyle(
                    color: ColorC.yellow,
                    fontWeight: FontWeight.w500,
                    fontSize: 28.sp,
                    height: 0.9.sp,
                  ),
                ),
                SizedBox(height: 30.h),
                Text(
                  'After purchasing the premium,\nyou will receive:',
                  style: TextStyle(
                    color: ColorC.yellow,
                    fontWeight: FontWeight.w500,
                    fontSize: 20.sp,
                    height: 1.sp,
                  ),
                ),
                SizedBox(height: 25.h),
                const Pr(
                  title:
                      'Monthly total cost analysis in the\nAnalytics section',
                ),
                SizedBox(height: 14.h),
                const Pr(
                  title:
                      'Detailed cost analysis for each category\nin the Analytics section',
                ),
                SizedBox(height: 32.h),
                Row(
                  children: [
                    Expanded(
                      child: CMotiBut(
                        onPressed: () {
                          if (widget.isSet) {
                            Navigator.pop(context);
                          } else {
                            Navigator.pushAndRemoveUntil(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => const CBotomBar(),
                              ),
                              (remove) => false,
                            );
                          }
                        },
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.transparent,
                          ),
                          child: Center(
                            child: Text(
                              'Close',
                              style: TextStyle(
                                color: ColorC.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 16.sp,
                                height: 1.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: CMotiBut(
                        onPressed: () async {
                          setState(() {
                            isPPmfmfds = true;
                          });
                          final rerrr = await Apphud.placements();
                          print(rerrr);

                          await Apphud.purchase(
                                  product: rerrr.first.paywall?.products?.first)
                              .whenComplete(
                            () async {
                              if (await Apphud.hasPremiumAccess() ||
                                  await Apphud.hasActiveSubscription()) {
                                await setClimboProfff();
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const CBotomBar(),
                                  ),
                                  (route) => false,
                                );
                              }
                            },
                          );
                          setState(() {
                            isPPmfmfds = false;
                          });
                        },
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: ColorC.yellow,
                          ),
                          child: isPPmfmfds
                              ? const CupertinoActivityIndicator(
                                  color: Colors.white)
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/icons/prem.png',
                                      width: 28,
                                      height: 28,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      'Go premium',
                                      style: TextStyle(
                                        color: ColorC.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17.sp,
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
                SizedBox(height: 25.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Pr extends StatelessWidget {
  const Pr({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        children: [
          Image.asset(
            'assets/icons/..png.png',
            width: 8.w,
            height: 8.h,
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(
              color: const Color(0xFFFAFAFA).withOpacity(0.8),
              fontWeight: FontWeight.w400,
              fontSize: 16.sp,
              height: 1.sp,
            ),
          ),
        ],
      ),
    );
  }
}
