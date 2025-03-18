import 'package:climbcost_profit_overhang_174_t/c/cliimboopr.dart';
import 'package:climbcost_profit_overhang_174_t/c/color_c.dart';
import 'package:climbcost_profit_overhang_174_t/c/moti_c.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class GeraarAdedPage extends StatefulWidget {
  const GeraarAdedPage({super.key, this.geriTraty});
  final GeriTraty? geriTraty;

  @override
  State<GeraarAdedPage> createState() => _GeraarAdedPageState();
}

class _GeraarAdedPageState extends State<GeraarAdedPage> {
  final TextEditingController _t1c = TextEditingController();
  final TextEditingController _t2c = TextEditingController();
  final TextEditingController _t3c = TextEditingController();
  final TextEditingController _t4c = TextEditingController();

  DateTime? dat1c;
  DateTime? dat2c;

  bool isnnO = false;

  @override
  void initState() {
    if (widget.geriTraty != null) {
      _t1c.text = widget.geriTraty!.geriTratyNam;
      _t2c.text = widget.geriTraty!.geriTratyAmont.toString();
      dat1c = widget.geriTraty!.geriTratyPurch;
      dat2c = widget.geriTraty!.geriTratyReplc;
      _t3c.text = DateFormat('MMMM dd, yyyy').format(dat1c!);
      if (dat2c != null) {
        _t4c.text = DateFormat('MMMM dd, yyyy').format(dat2c!);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CMotiBut(
        onPressed: () {
          if (dat1c == null || _t1c.text.isEmpty || _t2c.text.isEmpty) {
            return;
          }
          final klimbitpr = context.read<Klimbitpr>();

          klimbitpr.crakGeriTraty(
              GeriTraty(
                  geriTratyId: widget.geriTraty != null
                      ? widget.geriTraty!.geriTratyId
                      : DateTime.now().microsecondsSinceEpoch,
                  geriTratyNam: _t1c.text.trim(),
                  geriTratyAmont: int.tryParse(_t2c.text.trim()) ?? 0,
                  geriTratyPurch:
                      dat1c ?? DateTime.now().add(Duration(days: 2)),
                  geriTratyReplc: dat2c,
                  isgeriTratyNot: widget.geriTraty != null
                      ? widget.geriTraty!.isgeriTratyNot
                      : isnnO),
              widget.geriTraty);
          Navigator.of(context).pop();
        },
        child: Container(
          margin: EdgeInsets.only(left: 32.w, right: 32.w),
          padding: EdgeInsets.symmetric(
            vertical: 14.h,
          ),
          decoration: BoxDecoration(
            color: dat1c == null || _t1c.text.isEmpty || _t2c.text.isEmpty
                ? ColorC.blue.withAlpha(150)
                : ColorC.blue,
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
        leading: CMotiBut(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: SvgPicture.asset('assets/icons/bac.svg'),
        ),
        title: Text(
          widget.geriTraty == null ? 'Add gear' : 'Edit gear',
          style: TextStyle(
            color: ColorC.white,
            fontWeight: FontWeight.w500,
            fontSize: 20.sp,
            height: 1.sp,
          ),
        ),
        actions: [
          if (widget.geriTraty != null)
            CMotiBut(
              onPressed: () {
                showCupertinoDialog<bool>(
                  context: context,
                  builder: (BuildContext context) {
                    return CupertinoAlertDialog(
                      title: Text(
                        'Delete gear',
                        style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      content: Text(
                        'Are you sure you want to delete the gear? This action cannot be undone. ',
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
                            'Delete',
                            style: TextStyle(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF0A84FF),
                            ),
                          ),
                          onPressed: () {
                            final klimbitpr = context.read<Klimbitpr>();
                            klimbitpr.deGeriTraty(widget.geriTraty!);
                            Navigator.of(context).pop(false);

                            Navigator.of(context).pop(true);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: SvgPicture.asset('assets/icons/dele.svg'),
            ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.r),
                    color: Color(0xFF2B2B2B),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.w, vertical: 13.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Category',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 16.w,
                      ),
                      Image.asset(
                        'assets/icons/lin.png',
                        fit: BoxFit.fill,
                        width: 120.w,
                      ),
                      SizedBox(
                        width: 16.w,
                      ),
                      Text(
                        'Gear',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: ColorC.blue,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                Row(
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
                      'Specify the name of the gear',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                CupertinoTextField(
                  autofocus: false,
                  onChanged: (value) {
                    setState(() {});
                  },
                  cursorColor: ColorC.blue,
                  controller: _t1c,
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                  placeholderStyle: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.white.withOpacity(0.71),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.r),
                    color: Color(0xFF2B2B2B),
                  ),
                  placeholder: 'Enter name',
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.w, vertical: 13.h),
                ),
                SizedBox(
                  height: 24.h,
                ),
                Row(
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
                      'Specify the amount spent on gear',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                CupertinoTextField(
                  autofocus: false,
                  onChanged: (value) {
                    setState(() {});
                  },
                  cursorColor: ColorC.blue,
                  controller: _t2c,
                  keyboardType: const TextInputType.numberWithOptions(),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  suffix: Padding(
                    padding: EdgeInsets.only(right: 14.0.w),
                    child: SvgPicture.asset('assets/icons/mon.svg'),
                  ),
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                  placeholderStyle: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.white.withOpacity(0.71),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.r),
                    color: Color(0xFF2B2B2B),
                  ),
                  placeholder: 'Enter amount spent',
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.w, vertical: 13.h),
                ),
                SizedBox(
                  height: 24.h,
                ),
                Row(
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
                    Expanded(
                      child: Text(
                        'Specify the date on which the gear was purchased',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                CupertinoTextField(
                  autofocus: false,
                  onChanged: (value) {
                    setState(() {});
                  },
                  onTap: () async {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (BuildContext cont) {
                        DateTime? nndd = dat1c ?? DateTime.now();
                        return CupertinoActionSheet(
                          actions: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 200.h,
                                  child: CupertinoDatePicker(
                                    initialDateTime: nndd,
                                    mode: CupertinoDatePickerMode.date,
                                    onDateTimeChanged: (val) {
                                      nndd = val;
                                    },
                                  ),
                                ),
                                CupertinoActionSheetAction(
                                  onPressed: () async {
                                    Navigator.of(cont).pop(nndd);
                                    setState(() {
                                      dat1c = nndd;
                                      _t3c.text = DateFormat('MMMM dd, yyyy')
                                          .format(dat1c!);
                                    });
                                  },
                                  child: Text(
                                    'Select',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          ],
                          cancelButton: CupertinoActionSheetAction(
                            onPressed: () {
                              Navigator.of(cont).pop();
                            },
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  cursorColor: ColorC.blue,
                  controller: _t3c,
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                  placeholderStyle: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.white.withOpacity(0.71),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.r),
                    color: Color(0xFF2B2B2B),
                  ),
                  placeholder: 'Select date',
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.w, vertical: 13.h),
                ),
                SizedBox(
                  height: 40.h,
                ),
                Row(
                  children: [
                    Text.rich(
                      TextSpan(
                        text: 'Replacing this gear ',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                        children: [
                          TextSpan(
                            text: '(optional)',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white.withOpacity(0.3),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 32.h,
                ),
                Row(
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
                    Expanded(
                      child: Text(
                        'Specify the date on which this gear may need to be replaced',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                CupertinoTextField(
                  autofocus: false,
                  onChanged: (value) {
                    setState(() {});
                  },
                  onTap: () async {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (BuildContext cont) {
                        DateTime? nndd = dat2c ?? DateTime.now();
                        return CupertinoActionSheet(
                          actions: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 200.h,
                                  child: CupertinoDatePicker(
                                    initialDateTime: nndd,
                                    mode: CupertinoDatePickerMode.date,
                                    onDateTimeChanged: (val) {
                                      nndd = val;
                                    },
                                  ),
                                ),
                                CupertinoActionSheetAction(
                                  onPressed: () async {
                                    Navigator.of(cont).pop(nndd);
                                    setState(() {
                                      dat2c = nndd;
                                      _t4c.text = DateFormat('MMMM dd, yyyy')
                                          .format(dat2c!);
                                    });
                                  },
                                  child: Text(
                                    'Select',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          ],
                          cancelButton: CupertinoActionSheetAction(
                            onPressed: () {
                              Navigator.of(cont).pop();
                            },
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  cursorColor: ColorC.blue,
                  controller: _t4c,
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                  placeholderStyle: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.white.withOpacity(0.71),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.r),
                    color: Color(0xFF2B2B2B),
                  ),
                  placeholder: 'Select date',
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.w, vertical: 13.h),
                ),
                SizedBox(
                  height: 24.h,
                ),
                Row(
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
                    Expanded(
                      child: Text(
                        "Allow notifications so you don't forget about the replacement.",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.r),
                    color: Color(0xFF2B2B2B),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.w, vertical: 13.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset('assets/images/noit.svg'),
                      SizedBox(
                        width: 6.w,
                      ),
                      Text(
                        'Notification',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      CupertinoSwitch(
                        value: isnnO,
                        activeColor: ColorC.blue,
                        trackColor: Colors.grey,
                        onChanged: (value) {
                          setState(() {
                            isnnO = value;
                          });
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(height: 200.h)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
