import 'package:climbcost_profit_overhang_174_t/c/cliimboopr.dart';
import 'package:climbcost_profit_overhang_174_t/c/color_c.dart';
import 'package:climbcost_profit_overhang_174_t/c/moti_c.dart';
import 'package:dropdown_flutter/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AscettAddedPage extends StatefulWidget {
  const AscettAddedPage({super.key, this.ascektik});

  final Ascektik? ascektik;

  @override
  State<AscettAddedPage> createState() => _AscettAddedPageState();
}

class _AscettAddedPageState extends State<AscettAddedPage> {
  PageController pageController = PageController();
  int selInn = 0;
  DateTime? dat1c;
  final TextEditingController _t1c = TextEditingController();
  final TextEditingController _t2c = TextEditingController();
  final TextEditingController _t3c = TextEditingController();

  List<TextEditingController> golLICon = [TextEditingController()];
  List<KategAmont> catExpp = [];
  SingleSelectController<String> selectController =
      SingleSelectController<String>(null);

  String? selCateg;
  @override
  void initState() {
    super.initState();
    if (widget.ascektik != null) {
      dat1c = widget.ascektik!.ascektikDate;
      _t1c.text = DateFormat('MMMM dd,yyyy').format(dat1c ?? DateTime.now());
      _t2c.text = widget.ascektik!.ascektikLoka;
      golLICon.clear();
      for (var fdsf in widget.ascektik!.ascektikGol) {
        golLICon.add(TextEditingController(text: fdsf));
      }
      catExpp = widget.ascektik!.listKategAmont;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Row(
          children: [
            if (selInn > 0)
              Expanded(
                child: CMotiBut(
                  onPressed: () {
                    showCupertinoDialog<bool>(
                      context: context,
                      builder: (BuildContext context) {
                        return CupertinoAlertDialog(
                          title: Text(
                            'Skip adding expenses',
                            style: TextStyle(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          content: Text(
                            'The expense categories have already been added. Are you sure you want to skip this step? If so, the expense categories will not be added. ',
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          actions: <Widget>[
                            CupertinoDialogAction(
                              child: Text(
                                'Skip',
                                style: TextStyle(
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF0A84FF),
                                ),
                              ),
                              onPressed: () {
                                if (dat1c == null ||
                                    _t1c.text.isEmpty ||
                                    _t2c.text.isEmpty) {
                                  return;
                                }
                                Navigator.of(context).pop();
                                final klimbitpr = context.read<Klimbitpr>();

                                for (int i = 0; i < golLICon.length; i++) {
                                  if (golLICon[i].text.isEmpty) {
                                    golLICon.removeAt(i);
                                    i--;
                                  }
                                }

                                klimbitpr.crakAscektik(
                                    Ascektik(
                                        ascektikIdd: widget.ascektik != null
                                            ? widget.ascektik!.ascektikIdd
                                            : DateTime.now()
                                                .microsecondsSinceEpoch,
                                        isVso: widget.ascektik != null
                                            ? widget.ascektik!.isVso
                                            : dat1c!.isBefore(DateTime.now()),
                                        ascektikDate: dat1c ??
                                            DateTime.now()
                                                .add(Duration(days: 2)),
                                        ascektikLoka: _t2c.text.trim(),
                                        ascektikGol: golLICon
                                            .map(
                                              (e) => e.text.trim(),
                                            )
                                            .toList(),
                                        listKategAmont: catExpp),
                                    widget.ascektik);
                                Navigator.of(context).pop();
                              },
                            ),
                            CupertinoDialogAction(
                              child: Text(
                                'Add',
                                style: TextStyle(
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF0A84FF),
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    decoration: BoxDecoration(
                      color: Color(0xFF2B2B2B),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Skip',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            if (selInn == 0)
              Expanded(
                child: CMotiBut(
                  onPressed: () {
                    if (dat1c == null && _t2c.text.isEmpty) {
                      return;
                    }
                    pageController.nextPage(
                        duration: Durations.medium1, curve: Curves.decelerate);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    decoration: BoxDecoration(
                      color: dat1c == null && _t2c.text.isEmpty
                          ? ColorC.blue.withAlpha(150)
                          : ColorC.blue,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Next',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            if (selInn > 0)
              SizedBox(
                width: 16.w,
              ),
            if (selInn > 0)
              Expanded(
                child: CMotiBut(
                  onPressed: () {
                    Navigator.of(context).pop();
                    final klimbitpr = context.read<Klimbitpr>();
                    for (int i = 0; i < golLICon.length; i++) {
                      if (golLICon[i].text.isEmpty) {
                        golLICon.removeAt(i);
                        i--;
                      }
                    }
                    klimbitpr.crakAscektik(
                        Ascektik(
                            ascektikIdd: widget.ascektik != null
                                ? widget.ascektik!.ascektikIdd
                                : DateTime.now().microsecondsSinceEpoch,
                            isVso: widget.ascektik != null
                                ? widget.ascektik!.isVso
                                : dat1c!.isBefore(DateTime.now()),
                            ascektikDate:
                                dat1c ?? DateTime.now().add(Duration(days: 2)),
                            ascektikLoka: _t2c.text.trim(),
                            ascektikGol: golLICon
                                .map(
                                  (e) => e.text.trim(),
                                )
                                .toList(),
                            listKategAmont: catExpp),
                        widget.ascektik);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    decoration: BoxDecoration(
                      color: dat1c == null && _t2c.text.isEmpty
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
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
          ],
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
          widget.ascektik == null ? 'Add ascent' : 'Edit ascent',
          style: TextStyle(
            color: ColorC.white,
            fontWeight: FontWeight.w500,
            fontSize: 20.sp,
            height: 1.sp,
          ),
        ),
        actions: [
          if (widget.ascektik != null)
            CMotiBut(
              onPressed: () {
                showCupertinoDialog<bool>(
                  context: context,
                  builder: (BuildContext context) {
                    return CupertinoAlertDialog(
                      title: Text(
                        'Delete ascents',
                        style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      content: Text(
                        'Are you sure you want to delete this ascents? This action cannot be canceled.',
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
                            klimbitpr.deAscektik(widget.ascektik!);
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(selInn == 0
                      ? 'assets/icons/1_act.svg'
                      : 'assets/icons/1_noact.svg'),
                  SizedBox(
                    width: 16.w,
                  ),
                  Image.asset('assets/icons/lin.png'),
                  SizedBox(
                    width: 16.w,
                  ),
                  SvgPicture.asset(selInn == 1
                      ? 'assets/icons/2_act.svg'
                      : 'assets/icons/2_noact.svg'),
                ],
              ),
              SizedBox(
                height: 32.h,
              ),
              Expanded(
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: pageController,
                  onPageChanged: (value) {
                    setState(() {
                      selInn = value;
                    });
                  },
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                                'Specify the date of ascent',
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
                            readOnly: true,
                            onTap: () async {
                              selectDate(context);
                            },
                            cursorColor: ColorC.blue,
                            controller: _t1c,
                            suffix: Padding(
                              padding: EdgeInsets.only(right: 14.0.w),
                              child: Text(
                                'Select',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: ColorC.blue,
                                ),
                              ),
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
                            placeholder: 'Select date',
                            padding: EdgeInsets.symmetric(
                                horizontal: 14.w, vertical: 13.h),
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
                                'Specify the location of the ascent ',
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
                            placeholder: 'Enter a location',
                            padding: EdgeInsets.symmetric(
                                horizontal: 14.w, vertical: 13.h),
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
                                child: Text.rich(
                                  TextSpan(
                                    text: 'Specify the goals of your ascent ',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: '(optional)',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white.withOpacity(0.3),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 16.w,
                              ),
                              CMotiBut(
                                onPressed: () {
                                  if (golLICon.any(
                                        (element) =>
                                            element.text.trim().isEmpty,
                                      ) &&
                                      golLICon.isNotEmpty) {
                                    return;
                                  }
                                  setState(() {
                                    golLICon.add(TextEditingController());
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 29.w, vertical: 13.h),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF2B2B2B),
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  child: Text(
                                    'Add',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: golLICon.any(
                                                (element) =>
                                                    element.text.trim().isEmpty,
                                              ) &&
                                              golLICon.isNotEmpty
                                          ? Colors.white.withOpacity(0.3)
                                          : Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return CupertinoTextField(
                                  autofocus: false,
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                  cursorColor: ColorC.blue,
                                  controller: golLICon[index],
                                  suffix: Padding(
                                    padding: EdgeInsets.only(right: 14.0.w),
                                    child: CMotiBut(
                                        onPressed: () {
                                          setState(() {
                                            golLICon.removeAt(index);
                                          });
                                        },
                                        child: SvgPicture.asset(
                                            'assets/icons/cle.svg')),
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
                                  placeholder: 'Enter a goal',
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 14.w, vertical: 13.h),
                                );
                              },
                              separatorBuilder: (context, index) => SizedBox(
                                    height: 12.h,
                                  ),
                              itemCount: golLICon.length)
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DropdownFlutter<String>(
                            controller: selectController,
                            hintText: 'Select category',
                            items: katagaoer,
                            decoration: CustomDropdownDecoration(
                                closedFillColor: Color(0xFF2B2B2B),
                                expandedFillColor: Color(0xFF2B2B2B),
                                closedSuffixIcon:
                                    SvgPicture.asset('assets/images/down.svg'),
                                expandedSuffixIcon:
                                    SvgPicture.asset('assets/images/up.svg'),
                                closedBorderRadius:
                                    BorderRadius.circular(12.r)),
                            closedHeaderPadding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 18.w),
                            listItemBuilder:
                                (context, item, isSelected, onItemSelect) =>
                                    Text(item,
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          color: Colors.white.withOpacity(0.8),
                                          fontWeight: FontWeight.w400,
                                        )),
                            headerBuilder: (context, selectedItem, enabled) =>
                                Text(selectedItem,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    )),
                            onChanged: (value) {
                              setState(() {
                                if (catExpp.any(
                                  (element) => element.kateg == value,
                                )) {
                                  selCateg = null;
                                  selectController.value = null;
                                  return;
                                }

                                selCateg = value;
                                selectController.value = value;
                              });
                            },
                          ),
                          if (selCateg != null)
                            Padding(
                              padding: EdgeInsets.only(top: 12.0.h),
                              child: CupertinoTextField(
                                autofocus: false,
                                onChanged: (value) {
                                  setState(() {});
                                },
                                cursorColor: Colors.blue,
                                controller: _t3c,
                                keyboardType:
                                    const TextInputType.numberWithOptions(),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                                suffix: Padding(
                                  padding: EdgeInsets.only(right: 14.0.w),
                                  child:
                                      SvgPicture.asset('assets/icons/mon.svg'),
                                ),
                                placeholderStyle: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white.withOpacity(0.3),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  color: Color(0xFF2B2B2B),
                                ),
                                placeholder: 'Enter amount',
                                padding: EdgeInsets.symmetric(
                                    horizontal: 14.w, vertical: 13.h),
                              ),
                            ),
                          SizedBox(
                            height: 20.h,
                          ),
                          CMotiBut(
                            onPressed: () {
                              if (_t3c.text.isEmpty && selCateg == null) {
                                return;
                              }
                              setState(
                                () {
                                  catExpp.add(
                                    KategAmont(
                                        kateg: selCateg!,
                                        amont: int.tryParse(_t3c.text.trim()) ??
                                            0),
                                  );

                                  _t3c.clear();
                                  selCateg = null;
                                  selectController.clear();
                                },
                              );
                            },
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 14.h, horizontal: 21.w),
                                decoration: BoxDecoration(
                                  color: _t3c.text.isEmpty
                                      ? Color(0xFF2B2B2B).withAlpha(100)
                                      : Color(0xFF2B2B2B),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Confirm',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => Container(
                                  padding: EdgeInsets.all(16.r),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.r),
                                    color: Color(0xFF2B2B2B),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        catExpp[index].kateg,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        "\$ ${catExpp[index].amont}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 16.w,
                                      ),
                                      CMotiBut(
                                          onPressed: () {
                                            setState(() {
                                              catExpp.removeAt(index);
                                            });
                                          },
                                          child: SvgPicture.asset(
                                              'assets/icons/cle.svg')),
                                    ],
                                  )),
                              separatorBuilder: (context, index) => SizedBox(
                                    height: 12.h,
                                  ),
                              itemCount: catExpp.length),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? fds = await dateShh(context);

    if (fds != null) {
      if (fds.isBefore(DateTime.now())) {
        final bool? reselect = await showCupertinoDialog<bool>(
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
                'Your ascent has already taken place, so it will be automatically stored in the completed ascents subsection.',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text(
                    'Re-select',
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF0A84FF),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
                CupertinoDialogAction(
                  child: Text(
                    'OK',
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0A84FF),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
              ],
            );
          },
        );

        if (reselect == true) {
          await selectDate(context);
        } else {
          setState(() {
            dat1c = fds;
            _t1c.text = DateFormat('MMMM dd, yyyy').format(dat1c!);
          });
        }
      } else {
        setState(() {
          dat1c = fds;
          _t1c.text = DateFormat('MMMM dd, yyyy').format(dat1c!);
        });
      }
    }
  }

  Future<DateTime?> dateShh(BuildContext context) {
    return showCupertinoModalPopup(
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
  }
}
