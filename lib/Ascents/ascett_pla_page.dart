import 'package:climbcost_profit_overhang_174_t/c/cliimboopr.dart';
import 'package:climbcost_profit_overhang_174_t/c/color_c.dart';
import 'package:climbcost_profit_overhang_174_t/c/moti_c.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'ascett_added_page.dart';

class AscettPlaPage extends StatefulWidget {
  const AscettPlaPage({super.key});

  @override
  State<AscettPlaPage> createState() => _AscettPlaPageState();
}

class _AscettPlaPageState extends State<AscettPlaPage> {
  @override
  Widget build(BuildContext context) {
    final klimbitpr = context.watch<Klimbitpr>();
    final pla = klimbitpr.ascektikLi
        .where(
          (element) => !element.isVso,
        )
        .toList();
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CMotiBut(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AscettAddedPage(),
            ),
          );
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 32.w),
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
                'Add ascent',
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
        leading: CMotiBut(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: SvgPicture.asset('assets/icons/bac.svg'),
        ),
        title: Text(
          'Planned ascents',
          style: TextStyle(
            color: ColorC.white,
            fontWeight: FontWeight.w500,
            fontSize: 20.sp,
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
                if (pla.isEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: Image.asset(
                      'assets/images/plaem.png',
                      fit: BoxFit.fill,
                      height: 412.h,
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
                                builder: (context) =>
                                    AscettAddedPage(ascektik: pla[index]),
                              ),
                            );
                          },
                          child: DatAskett(pla: pla[index]));
                    },
                    separatorBuilder: (context, index) => SizedBox(
                          height: 16.h,
                        ),
                    itemCount: pla.length),
                SizedBox(
                  height: 100.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DatAskett extends StatefulWidget {
  const DatAskett({
    super.key,
    required this.pla,
  });

  final Ascektik pla;

  @override
  State<DatAskett> createState() => _DatAskettState();
}

class _DatAskettState extends State<DatAskett> {
  bool islar = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: Color(0xFF2B2B2B),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset('assets/images/flag1.svg'),
              SizedBox(
                width: 8.w,
              ),
              Text(
                'Planned ascents',
                style: TextStyle(
                  color: ColorC.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 20.sp,
                  height: 1.sp,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            children: [
              Text(
                'Location: ',
                style: TextStyle(
                  color: ColorC.whiFAFAFA.withOpacity(0.7),
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                  height: 1.sp,
                ),
              ),
              Expanded(
                child: Text(
                  widget.pla.ascektikLoka,
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
            height: 8.h,
          ),
          Row(
            children: [
              Text(
                'Data: ',
                style: TextStyle(
                  color: ColorC.whiFAFAFA.withOpacity(0.7),
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                  height: 1.sp,
                ),
              ),
              Expanded(
                child: Text(
                  DateFormat('MMMM dd').format(widget.pla.ascektikDate),
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
            height: 8.h,
          ),
          Row(
            children: [
              Text(
                'Goals: ',
                style: TextStyle(
                  color: ColorC.whiFAFAFA.withOpacity(0.7),
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                  height: 1.sp,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8.h,
          ),
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index2) => Row(
                    children: [
                      Container(
                        height: 6.h,
                        width: 6.h,
                        decoration: BoxDecoration(
                            color: ColorC.blue, shape: BoxShape.circle),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Text(
                        widget.pla.ascektikGol[index2],
                        style: TextStyle(
                          color: ColorC.whiFAFAFA,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                          height: 1.sp,
                        ),
                      ),
                    ],
                  ),
              separatorBuilder: (context, index) => SizedBox(
                    height: 4.h,
                  ),
              itemCount: widget.pla.ascektikGol.length),
          if (islar)
            SizedBox(
              height: 24.h,
            ),
          if (islar)
            Text(
              'Expenses: ',
              style: TextStyle(
                color: ColorC.whiFAFAFA,
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                height: 1.sp,
              ),
            ),
          if (islar)
            SizedBox(
              height: 12.h,
            ),
          if (islar)
            ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index2) => Row(
                      children: [
                        Text(
                          widget.pla.listKategAmont[index2].kateg,
                          style: TextStyle(
                            color: ColorC.whiFAFAFA.withOpacity(0.7),
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                            height: 1.sp,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '\$ ${widget.pla.listKategAmont[index2].amont}',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              color: ColorC.blue,
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              height: 1.sp,
                            ),
                          ),
                        )
                      ],
                    ),
                separatorBuilder: (context, index) => SizedBox(
                      height: 4.h,
                    ),
                itemCount: widget.pla.listKategAmont.length),
          if (islar)
            SizedBox(
              height: 12.h,
            ),
          if (islar)
            Row(
              children: [
                Text(
                  'Total amount spent',
                  style: TextStyle(
                    color: ColorC.whiFAFAFA,
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    height: 1.sp,
                  ),
                ),
                Expanded(
                  child: Text(
                    '\$ ${widget.pla.listKategAmont.fold(0, (val1, val2) => val1 + val2.amont)}',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: ColorC.yellow,
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      height: 1.sp,
                    ),
                  ),
                )
              ],
            ),
          SizedBox(
            height: 12.h,
          ),
          Row(
            children: [
              Expanded(
                child: CMotiBut(
                  onPressed: () {
                    showCupertinoDialog<bool>(
                      context: context,
                      builder: (BuildContext context) {
                        return CupertinoAlertDialog(
                          title: Text(
                            'Completed ascents',
                            style: TextStyle(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          content: Text(
                            'Confirm, was this ascent actually completed? This action cannot be canceled. ',
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          actions: <Widget>[
                            CupertinoDialogAction(
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF0A84FF),
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                            ),
                            CupertinoDialogAction(
                              child: Text(
                                'Yes',
                                style: TextStyle(
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF0A84FF),
                                ),
                              ),
                              onPressed: () {
                                final klimbitpr = context.read<Klimbitpr>();
                                klimbitpr.crakAscektik(
                                    widget.pla.copyWith(isVso: true),
                                    widget.pla);

                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
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
                          'Complete ascent',
                          style: TextStyle(
                            color: ColorC.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 16.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (widget.pla.listKategAmont.isNotEmpty)
                SizedBox(
                  width: 12.w,
                ),
              if (widget.pla.listKategAmont.isNotEmpty)
                CMotiBut(
                  onPressed: () {
                    setState(() {
                      islar = !islar;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(
                      18.h,
                    ),
                    decoration: BoxDecoration(
                      color: ColorC.blue,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(!islar
                            ? 'assets/images/down.svg'
                            : 'assets/images/up.svg')
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
