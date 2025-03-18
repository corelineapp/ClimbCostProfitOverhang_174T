import 'package:climbcost_profit_overhang_174_t/c/color_c.dart';
import 'package:climbcost_profit_overhang_174_t/c/moti_c.dart';
import 'package:climbcost_profit_overhang_174_t/insurance/models/permit_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class PermitsEdit extends StatefulWidget {
  final Permit permit;
  final int index;

  const PermitsEdit({
    super.key,
    required this.permit,
    required this.index,
  });

  @override
  State<PermitsEdit> createState() => _PermitsEditState();
}

class _PermitsEditState extends State<PermitsEdit> {
  late TextEditingController _typeController;
  late TextEditingController _amountController;
  DateTime? _selectedDate;
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _typeController = TextEditingController(text: widget.permit.type);
    _amountController =
        TextEditingController(text: widget.permit.amount.toString());
    _selectedDate = widget.permit.expiryDate;
    _updateButtonState();
  }

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
                initialDateTime: _selectedDate,
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

  Future<void> _saveChanges() async {
    final permitBox = Hive.box<Permit>('permits');
    widget.permit
      ..type = _typeController.text
      ..amount = double.parse(_amountController.text)
      ..expiryDate = _selectedDate!;
    await permitBox.putAt(widget.index, widget.permit);
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  Future<void> _deletePermit() async {
    final permitBox = Hive.box<Permit>('permits');
    await permitBox.deleteAt(widget.index);
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Edit insurance/permits',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 22.sp,
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 12.w),
              child: CMotiBut(
                onPressed: _deletePermit,
                child: SvgPicture.asset('assets/icons/delete.svg'),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24.h),

              // Вид страховки/разрешения
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
                  suffixIcon: Padding(
                    padding: EdgeInsets.all(12.r),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8),
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
                  padding:
                      EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat.yMMMMd().format(_selectedDate!),
                        style: TextStyle(color: Colors.blue, fontSize: 14.sp),
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
          onPressed: _isButtonEnabled ? _saveChanges : null,
          child: Container(
            height: 48.h,
            width: double.infinity,
            margin: EdgeInsets.only(right: 32.w, left: 32.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color:
                  _isButtonEnabled ? ColorC.blue : ColorC.blue.withOpacity(0.5),
            ),
            child: Center(
              child: Text(
                "Save",
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
