import 'package:climbcost_profit_overhang_174_t/c/cliimboopr.dart';
import 'package:climbcost_profit_overhang_174_t/c/color_c.dart';
import 'package:climbcost_profit_overhang_174_t/c/moti_c.dart';
import 'package:climbcost_profit_overhang_174_t/c/precliubmo.dart';
import 'package:climbcost_profit_overhang_174_t/insurance/models/permit_model.dart';
import 'package:climbcost_profit_overhang_174_t/pppp/pppp.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Analytics extends StatefulWidget {
  const Analytics({super.key});

  @override
  State<Analytics> createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  DateTime date = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  DateTime addMorro(DateTime date, int months) {
    int newMonth = date.month + months;
    int newYear = date.year;

    while (newMonth <= 0) {
      newYear--;
      newMonth += 12;
    }

    while (newMonth > 12) {
      newYear++;
      newMonth -= 12;
    }

    int lastDayOfNewMonth = DateTime(newYear, newMonth + 1, 0).day;
    int newDay = date.day > lastDayOfNewMonth ? lastDayOfNewMonth : date.day;

    return DateTime(
        newYear, newMonth, newDay, date.hour, date.minute, date.second);
  }

  bool isSameMonth(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month;
  }

  String findMaxValue(int a, int b, int c) {
    if (a >= b && a >= c) {
      return 'Ascents';
    } else if (b >= a && b >= c) {
      return 'Insurance / permits';
    } else {
      return 'Gear';
    }
  }

  @override
  Widget build(BuildContext context) {
    final klimbitpr = context.watch<Klimbitpr>();
    final int1 = klimbitpr.ascektikLi
        .where((element) => isSameMonth(element.ascektikDate, date))
        .toList()
        .fold(
            0,
            (val1, val2) =>
                val1 +
                val2.listKategAmont.fold(0, (vl1, vl2) => vl1 + vl2.amont));

    final int2 = klimbitpr.geriTratyLi
        .where((element) => isSameMonth(element.geriTratyPurch, date))
        .toList()
        .fold(0, (val1, val2) => val1 + val2.geriTratyAmont);

    return FutureBuilder<bool>(
        future: getClimboProfff(),
        builder: (context, snapshot) {
          return ValueListenableBuilder(
              valueListenable: Hive.box<Permit>('permits').listenable(),
              builder: (context, Box<Permit> box, _) {
                final int3 = box.values
                    .toList()
                    .where((element) => isSameMonth(element.expiryDate, date))
                    .toList()
                    .fold(
                      0,
                      (vl1, vl2) => vl1 + vl2.amount.toInt(),
                    );

                final totl1 = int1 + int2 + int3;
                final List<double> values = [
                  int1.toDouble(),
                  int3.toDouble(),
                  int2.toDouble()
                ];

                final List<Color> colors = [
                  Color(0xFF1E88E5),
                  Color(0xFFFBC02D),
                  Color(0xFF43A047)
                ];

                return Scaffold(
                  appBar: AppBar(
                    centerTitle: false,
                    title: Text(
                      'Analytics',
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
                        padding: EdgeInsets.symmetric(
                            horizontal: 32.w, vertical: 16.h),
                        child: Column(
                          children: [
                            Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.w, vertical: 16.h),
                                decoration: BoxDecoration(
                                  color: ColorC.yellow,
                                  borderRadius: BorderRadius.circular(14.r),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      "Current month's costs:",
                                      style: TextStyle(
                                        color: ColorC.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.sp,
                                        height: 1.sp,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        totl1 == 0 ? "No cost" : '$totl1',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          color: ColorC.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15.sp,
                                          height: 1.sp,
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                            SizedBox(
                              height: 16.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Top-1 position:",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: ColorC.whiFAFAFA,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.sp,
                                    height: 1.sp,
                                  ),
                                ),
                                Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20.w, vertical: 8.h),
                                    decoration: BoxDecoration(
                                      color: ColorC.yellow,
                                      borderRadius: BorderRadius.circular(14.r),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          totl1 == 0
                                              ? "No position"
                                              : findMaxValue(int1, int3, int2),
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                            color: ColorC.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.sp,
                                            height: 1.sp,
                                          ),
                                        )
                                      ],
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 32.h,
                            ),
                            if (klimbitpr.geriTratyLi.isEmpty &&
                                klimbitpr.ascektikLi.isEmpty &&
                                box.isEmpty)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20.r),
                                child: Image.asset(
                                  'assets/images/anem.png',
                                  fit: BoxFit.fill,
                                  height: 381.h,
                                  width: double.infinity,
                                ),
                              ),
                            if (!(klimbitpr.geriTratyLi.isEmpty &&
                                    klimbitpr.ascektikLi.isEmpty &&
                                    box.isEmpty) &&
                                snapshot.data == true)
                              Column(
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CMotiBut(
                                        onPressed: () {
                                          setState(() {
                                            date = addMorro(date, -1);
                                          });
                                        },
                                        child: SvgPicture.asset(
                                            'assets/icons/bac.svg'),
                                      ),
                                      const Spacer(),
                                      Text(
                                        DateFormat('MMMM yyyy').format(date),
                                        style: TextStyle(
                                          color: ColorC.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14.sp,
                                          height: 1.sp,
                                        ),
                                      ),
                                      const Spacer(),
                                      CMotiBut(
                                        onPressed: () {
                                          setState(() {
                                            date = addMorro(date, 1);
                                          });
                                        },
                                        child: RotatedBox(
                                            quarterTurns: 2,
                                            child: SvgPicture.asset(
                                                'assets/icons/bac.svg')),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 32.h,
                                  ),
                                  SizedBox(
                                    height: 250.spMax,
                                    width: 250.spMax,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        SizedBox(
                                          height: 250.spMax,
                                          width: 250.spMax,
                                          child: PieChart(
                                            PieChartData(
                                              sectionsSpace: 0,
                                              centerSpaceRadius: 100,
                                              sections: List.generate(
                                                  values.length, (index) {
                                                double total = values
                                                    .reduce((a, b) => a + b);

                                                double percentage = (values[
                                                            index] /
                                                        total) *
                                                    100; // Процентное соотношение

                                                if (values
                                                    .every((v) => v == 0)) {
                                                  return PieChartSectionData(
                                                    color: Colors.grey[800],
                                                    value: 100,
                                                    title: '',
                                                    radius: 50,
                                                  );
                                                } else {
                                                  return PieChartSectionData(
                                                    color: colors[index],
                                                    value: values[index],
                                                    title:
                                                        '${percentage.toStringAsFixed(1)}%',
                                                    titleStyle: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    radius: 60,
                                                  );
                                                }
                                              }),
                                            ),
                                          ),
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            LegendItem(
                                                color: colors[0],
                                                text: 'Ascents'),
                                            LegendItem(
                                                color: colors[1],
                                                text: 'Insurance / permits'),
                                            LegendItem(
                                                color: colors[2], text: 'Gear'),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 48.h,
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      LegendItem2(
                                          color: colors[0],
                                          text: 'Ascents',
                                          val: '\$ $int1'),
                                      LegendItem2(
                                          color: colors[1],
                                          text: 'Insurance / permits',
                                          val: '\$ $int3'),
                                      LegendItem2(
                                          color: colors[2],
                                          text: 'Gear',
                                          val: '\$ $int2'),
                                    ],
                                  ),
                                ],
                              ),
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
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: ColorC.yellow,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                            SizedBox(
                              height: 200.h,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
        });
  }
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String text;
  final String val;

  const LegendItem({required this.color, required this.text, this.val = ''});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        SizedBox(width: 5),
        Text(text, style: TextStyle(color: Colors.white, fontSize: 14)),
      ],
    );
  }
}

class LegendItem2 extends StatelessWidget {
  final Color color;
  final String text;
  final String val;

  const LegendItem2({required this.color, required this.text, this.val = ''});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        SizedBox(width: 5),
        Text(text, style: TextStyle(color: Colors.white, fontSize: 14)),
        const Spacer(),
        Text(val, style: TextStyle(color: Colors.white, fontSize: 14)),
      ],
    );
  }
}
