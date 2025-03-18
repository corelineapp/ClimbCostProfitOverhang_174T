import 'package:climbcost_profit_overhang_174_t/c/color_c.dart';
import 'package:climbcost_profit_overhang_174_t/c/moti_c.dart';
import 'package:climbcost_profit_overhang_174_t/insurance/insurance_add.dart';
import 'package:climbcost_profit_overhang_174_t/insurance/models/insurance_model.dart';
import 'package:climbcost_profit_overhang_174_t/insurance/models/permit_model.dart';
import 'package:climbcost_profit_overhang_174_t/insurance/permits_add.dart';
import 'package:climbcost_profit_overhang_174_t/insurance/permits_edit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class Insurance extends StatefulWidget {
  const Insurance({super.key});

  @override
  State<Insurance> createState() => _InsuranceState();
}

class _InsuranceState extends State<Insurance> {
  late Box<Permit> _permitBox;

  @override
  void initState() {
    super.initState();
    _permitBox = Hive.box<Permit>('permits');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Insurance and permits',
          style: TextStyle(
            color: ColorC.white,
            fontWeight: FontWeight.w500,
            fontSize: 28.sp,
            height: 1.sp,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(32.r),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ValueListenableBuilder(
                  valueListenable:
                      Hive.box<InsuranceModel>('insurance').listenable(),
                  builder: (context, Box<InsuranceModel> box, _) {
                    InsuranceModel? lastInsurance;
                    if (box.isNotEmpty) {
                      lastInsurance = box.getAt(box.length - 1);
                    }

                    return CMotiBut(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const InsuranceAdd(),
                          ),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16.r),
                        decoration: BoxDecoration(
                          color: lastInsurance != null
                              ? ColorC.yellow
                              : Colors.grey[850],
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          children: <Widget>[
                            SvgPicture.asset(
                              "assets/icons/col.svg",
                              // ignore: deprecated_member_use
                              color: lastInsurance != null
                                  ? ColorC.background
                                  : ColorC.white,
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              lastInsurance != null
                                  ? lastInsurance.name
                                  : "Insurance/permits",
                              style: TextStyle(
                                color: lastInsurance != null
                                    ? ColorC.background
                                    : ColorC.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              lastInsurance != null
                                  ? DateFormat.yMMMMd()
                                      .format(lastInsurance.date)
                                  : "Select",
                              style: TextStyle(
                                color: lastInsurance != null
                                    ? Colors.black
                                    : ColorC.yellow,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 28.h),
                ValueListenableBuilder(
                  valueListenable: _permitBox.listenable(),
                  builder: (context, Box<Permit> box, _) {
                    if (box.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 50.h),
                          child: Image.asset(
                            'assets/images/perm.png',
                            width: double.infinity,
                          ),
                        ),
                      );
                    }
                    return Column(
                      children: [
                        ListView.builder(
                          reverse: true,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: box.length,
                          itemBuilder: (context, index) {
                            final permit = box.getAt(index);
                            return _PermitWidget(permit: permit!, index: index);
                          },
                        ),
                        SizedBox(height: 120.h),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CMotiBut(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const PermitsAdd();
              },
            ),
          );
        },
        child: Container(
          height: 48.h,
          width: double.infinity,
          margin: EdgeInsets.only(
            right: 32.w,
            left: 32.w,
            bottom: 84.h,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: ColorC.blue,
          ),
          child: Center(
            child: Text(
              "Add",
              style: TextStyle(
                fontSize: 16.sp,
                color: ColorC.white,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PermitWidget extends StatelessWidget {
  final Permit permit;
  final int index;

  const _PermitWidget({super.key, required this.permit, required this.index});

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat.yMMMMd().format(permit.expiryDate);

    return CMotiBut(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return PermitsEdit(
            permit: permit,
            index: index,
          );
        }));
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              permit.type,
              style: TextStyle(
                color: Colors.blue,
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 14.h),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Cost: ',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.white.withOpacity(0.3),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: '\$ ${permit.amount.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 6.h),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Deadline: ',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.white.withOpacity(0.3),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: formattedDate,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
