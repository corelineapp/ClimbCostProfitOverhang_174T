import 'package:climbcost_profit_overhang_174_t/Gear/geraar_aded_page.dart';
import 'package:climbcost_profit_overhang_174_t/c/cliimboopr.dart';
import 'package:climbcost_profit_overhang_174_t/c/color_c.dart';
import 'package:climbcost_profit_overhang_174_t/c/moti_c.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Gear extends StatefulWidget {
  const Gear({super.key});

  @override
  State<Gear> createState() => _GearState();
}

class _GearState extends State<Gear> {
  @override
  Widget build(BuildContext context) {
    final klimbitpr = context.watch<Klimbitpr>();

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CMotiBut(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const GeraarAdedPage(),
            ),
          );
        },
        child: Container(
          margin: EdgeInsets.only(left: 32.w, right: 32.w, bottom: 100.h),
          padding: EdgeInsets.symmetric(
            vertical: 14.h,
          ),
          decoration: BoxDecoration(
            color: ColorC.blue,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Add',
                style: TextStyle(
                  color: ColorC.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 20.sp,
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Gear Expenses',
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
            padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
            child: Column(
              children: [
                if (klimbitpr.geriTratyLi.isEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: Image.asset(
                      'assets/images/gerem.png',
                      fit: BoxFit.fill,
                      height: 381.h,
                      width: double.infinity,
                    ),
                  ),
                SizedBox(
                  height: 16.h,
                ),
                ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return CMotiBut(
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => GeraarAdedPage(
                                  geriTraty: klimbitpr.geriTratyLi[index]),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(16.r),
                          decoration: BoxDecoration(
                            color: Color(0xFF2B2B2B),
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    klimbitpr.geriTratyLi[index].geriTratyNam,
                                    style: TextStyle(
                                      color: klimbitpr.geriTratyLi[index]
                                                  .geriTratyReplc !=
                                              null
                                          ? ColorC.blue
                                          : ColorC.whiFAFAFA.withOpacity(0.7),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20.sp,
                                      height: 1.sp,
                                    ),
                                  ),
                                  const Spacer(),
                                  if (klimbitpr
                                          .geriTratyLi[index].geriTratyReplc !=
                                      null)
                                    SvgPicture.asset('assets/images/noit.svg'),
                                ],
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Category:',
                                    style: TextStyle(
                                      color: ColorC.whiFAFAFA.withOpacity(0.7),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp,
                                      height: 1.sp,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Gear',
                                      style: TextStyle(
                                        color: klimbitpr.geriTratyLi[index]
                                                    .geriTratyReplc !=
                                                null
                                            ? ColorC.blue
                                            : ColorC.whiFAFAFA.withOpacity(0.7),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.sp,
                                        height: 1.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Cost:',
                                    style: TextStyle(
                                      color: ColorC.whiFAFAFA.withOpacity(0.7),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp,
                                      height: 1.sp,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      '\$ ${klimbitpr.geriTratyLi[index].geriTratyAmont}',
                                      style: TextStyle(
                                        color: ColorC.whiFAFAFA,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.sp,
                                        height: 1.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Purchase date: ',
                                    style: TextStyle(
                                      color: ColorC.whiFAFAFA.withOpacity(0.7),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp,
                                      height: 1.sp,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      DateFormat('MMMM dd, yyyy').format(
                                          klimbitpr.geriTratyLi[index]
                                              .geriTratyPurch),
                                      style: TextStyle(
                                        color: ColorC.whiFAFAFA,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.sp,
                                        height: 1.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              if (klimbitpr.geriTratyLi[index].geriTratyReplc !=
                                  null)
                                SizedBox(
                                  height: 8.h,
                                ),
                              if (klimbitpr.geriTratyLi[index].geriTratyReplc !=
                                  null)
                                Divider(
                                  height: 1.r,
                                  color: ColorC.whiFAFAFA.withOpacity(0.12),
                                ),
                              if (klimbitpr.geriTratyLi[index].geriTratyReplc !=
                                  null)
                                SizedBox(
                                  height: 8.h,
                                ),
                              if (klimbitpr.geriTratyLi[index].geriTratyReplc !=
                                  null)
                                Row(
                                  children: [
                                    Text(
                                      'Replacement date: ',
                                      style: TextStyle(
                                        color:
                                            ColorC.whiFAFAFA.withOpacity(0.7),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp,
                                        height: 1.sp,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        DateFormat('MMMM dd, yyyy').format(
                                            klimbitpr.geriTratyLi[index]
                                                .geriTratyReplc!),
                                        style: TextStyle(
                                          color: ColorC.whiFAFAFA,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14.sp,
                                          height: 1.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                          height: 16.h,
                        ),
                    itemCount: klimbitpr.geriTratyLi.length),
                SizedBox(height: 200.h)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
