import 'package:climbcost_profit_overhang_174_t/c/color_c.dart';
import 'package:climbcost_profit_overhang_174_t/c/moti_c.dart';
import 'package:climbcost_profit_overhang_174_t/insurance/models/permit_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class PermitsAdd extends StatefulWidget {
  const PermitsAdd({super.key});

  @override
  State<PermitsAdd> createState() => _PermitsAddState();
}

class _PermitsAddState extends State<PermitsAdd> {
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  DateTime? _selectedDate;
  bool _isButtonEnabled = false;

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = _typeController.text.isNotEmpty &&
          _amountController.text.isNotEmpty &&
          _selectedDate != null;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 300.h,
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              height: 200.h,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: DateTime.now(),
                onDateTimeChanged: (DateTime newDate) {
                  setState(() {
                    _selectedDate = newDate;
                  });
                  _updateButtonState();
                },
              ),
            ),
            CupertinoButton(
              child: const Text('Select'),
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _savePermit() async {
    final permitBox = await Hive.openBox<Permit>('permits');
    final newPermit = Permit(
      type: _typeController.text,
      amount: double.parse(_amountController.text),
      expiryDate: _selectedDate!,
    );
    await permitBox.add(newPermit);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Add insurance/permits',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 22.sp,
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24.h),
      
              Row(
                children: [
                  Icon(Icons.circle, color: Colors.blue, size: 8.r),
                  SizedBox(width: 8.w),
                  Flexible(
                    child: Text(
                      "Specify the type of insurance or permits",
                      style: TextStyle(fontSize: 14.sp, color: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              TextField(
                controller: _typeController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[900],
                  hintText: "Enter type",
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14.r),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                ),
                style: TextStyle(color: Colors.white),
                onChanged: (value) => _updateButtonState(),
              ),
              SizedBox(height: 20.h),
      
              // Сумма страховки
              Row(
                children: [
                  Icon(Icons.circle, color: Colors.blue, size: 8.r),
                  SizedBox(width: 8.w),
                  Flexible(
                    child: Text(
                      "Specify the amount of this permit or insurance",
                      style: TextStyle(fontSize: 14.sp, color: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[900],
                  hintText: "Enter amount",
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  suffixIcon: Padding(
                    padding: EdgeInsets.all(12.r),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Text(
                        "\$",
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                      ),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                ),
                style: const TextStyle(color: Colors.white),
                onChanged: (value) => _updateButtonState(),
              ),
              SizedBox(height: 20.h),
      
              // Срок действия
              Row(
                children: [
                  Icon(Icons.circle, color: Colors.blue, size: 8.r),
                  SizedBox(width: 8.w),
                  Flexible(
                    child: Text(
                      "Specify the period of validity of the insurance/permit",
                      style: TextStyle(fontSize: 14.sp, color: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _selectedDate == null
                            ? "Select date"
                            : DateFormat.yMMMMd().format(_selectedDate!),
                        style: TextStyle(
                          color:
                              _selectedDate == null ? Colors.grey : Colors.white,
                          fontSize: 14.sp,
                        ),
                      ),
                      Text(
                        "Select",
                        style: TextStyle(color: Colors.blue, fontSize: 14.sp),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 32.h),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: CMotiBut(
          onPressed: _isButtonEnabled ? _savePermit : null,
          child: Container(
            height: 48.h,
            width: double.infinity,
            margin: EdgeInsets.only(
              right: 32.w,
              left: 32.w,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color:
                  _isButtonEnabled ? ColorC.blue : ColorC.blue.withOpacity(0.5),
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
      ),
    );
  }
}
