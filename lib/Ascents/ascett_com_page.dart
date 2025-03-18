import 'package:climbcost_profit_overhang_174_t/Ascents/ascett_added_page.dart';
import 'package:climbcost_profit_overhang_174_t/c/cliimboopr.dart';
import 'package:climbcost_profit_overhang_174_t/c/color_c.dart';
import 'package:climbcost_profit_overhang_174_t/c/moti_c.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AscettComPage extends StatefulWidget {
  const AscettComPage({super.key});

  @override
  State<AscettComPage> createState() => _AscettComPageState();
}

class _AscettComPageState extends State<AscettComPage> {
  @override
  Widget build(BuildContext context) {
    final klimbitpr = context.watch<Klimbitpr>();
    final com = klimbitpr.ascektikLi
        .where(
          (element) => element.isVso,
        )
        .toList();
    return Scaffold(
      appBar: AppBar(
        leading: CMotiBut(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: SvgPicture.asset('assets/icons/bac.svg'),
        ),
        title: Text(
          'Completed ascents',
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
                if (com.isEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: Image.asset(
                      'assets/images/comem.png',
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
                                    AscettAddedPage(ascektik: com[index]),
                              ),
                            );
                          },
                          child: AddsCpAs(com: com[index]));
                    },
                    separatorBuilder: (context, index) => SizedBox(
                          height: 16.h,
                        ),
                    itemCount: com.length),
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

class AddsCpAs extends StatefulWidget {
  const AddsCpAs({
    super.key,
    required this.com,
  });

  final Ascektik com;

  @override
  State<AddsCpAs> createState() => _AddsCpAsState();
}

class _AddsCpAsState extends State<AddsCpAs> {
  bool isSasd = false;
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
              SvgPicture.asset('assets/images/flag2.svg'),
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
                  fontSize: 20.sp,
                  height: 1.sp,
                ),
              ),
              Expanded(
                child: Text(
                  widget.com.ascektikLoka,
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
                  fontSize: 20.sp,
                  height: 1.sp,
                ),
              ),
              Expanded(
                child: Text(
                  DateFormat('MMMM dd').format(widget.com.ascektikDate),
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
                  fontSize: 20.sp,
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
                            color: ColorC.green, shape: BoxShape.circle),
                      ),
                      Text(
                        widget.com.ascektikGol[index2],
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
              itemCount: widget.com.ascektikGol.length),
          if (isSasd)
            SizedBox(
              height: 24.h,
            ),
          if (isSasd)
            Text(
              'Expenses: ',
              style: TextStyle(
                color: ColorC.whiFAFAFA,
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                height: 1.sp,
              ),
            ),
          if (isSasd)
            SizedBox(
              height: 12.h,
            ),
          if (isSasd)
            ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index2) => Row(
                      children: [
                        Text(
                          widget.com.listKategAmont[index2].kateg,
                          style: TextStyle(
                            color: ColorC.whiFAFAFA.withOpacity(0.7),
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                            height: 1.sp,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '\$ ${widget.com.listKategAmont[index2].amont}',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              color: ColorC.green,
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
                itemCount: widget.com.listKategAmont.length),
          if (isSasd)
            SizedBox(
              height: 12.h,
            ),
          if (isSasd)
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
                    '\$ ${widget.com.listKategAmont.fold(0, (val1, val2) => val1 + val2.amont)}',
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
          if (widget.com.listKategAmont.isNotEmpty)
            Row(
              children: [
                Expanded(
                  child: CMotiBut(
                    onPressed: () {
                      setState(() {
                        isSasd = !isSasd;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(
                        14.h,
                      ),
                      decoration: BoxDecoration(
                        color: ColorC.green,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [SvgPicture.asset('assets/images/down.svg')],
                      ),
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
