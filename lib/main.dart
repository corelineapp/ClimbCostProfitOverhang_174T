import 'package:apphud/apphud.dart';
import 'package:climbcost_profit_overhang_174_t/c/botbar_c.dart';
import 'package:climbcost_profit_overhang_174_t/c/cliimboopr.dart';
import 'package:climbcost_profit_overhang_174_t/c/color_c.dart';
import 'package:climbcost_profit_overhang_174_t/c/dok_c.dart';
import 'package:climbcost_profit_overhang_174_t/c/onb_c.dart';
import 'package:climbcost_profit_overhang_174_t/insurance/models/insurance_model.dart';
import 'package:climbcost_profit_overhang_174_t/insurance/models/permit_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(PermitAdapter());
  Hive.registerAdapter(InsuranceModelAdapter());
  await Hive.openBox<Permit>('permits');
  await Hive.openBox<InsuranceModel>('insurance');
  SharedPreferences bbb444clibbl = await SharedPreferences.getInstance();
  bool typ = bbb444clibbl.getBool('nnnmyyyy') ?? true;
  Widget nmmmgf55 = typ
      ? const COnBoDi()
      : const CBotomBar(
          indexScr: 0,
        );
  if (typ) {
    await bbb444clibbl.setBool('nnnmyyyy', false);
    await Future.delayed(const Duration(seconds: 3));
    try {
      final InAppReview ppoikclibmo = InAppReview.instance;

      if (await ppoikclibmo.isAvailable()) {
        ppoikclibmo.requestReview();
      }
    } catch (sdvk) {
      throw Exception(sdvk);
    }
  }

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          lazy: false,
          create: (_) => Klimbitpr(),
        ),
      ],
      child: MyApp(
        nnnnyy44: nmmmgf55,
      )));

  await Apphud.start(apiKey: DokC.aPpHdKF);
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.nnnnyy44,
  });

  final Widget nnnnyy44;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Climb Cost',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: ColorC.background,
          ),
          scaffoldBackgroundColor: ColorC.background,
          fontFamily: "SF Compat",
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
        ),
        home: nnnnyy44,
      ),
    );
  }
}
