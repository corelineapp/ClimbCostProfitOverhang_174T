// ignore_for_file: use_build_context_synchronously

import 'package:apphud/apphud.dart';
import 'package:climbcost_profit_overhang_174_t/c/botbar_c.dart';
import 'package:climbcost_profit_overhang_174_t/c/dok_c.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> setClimboProfff() async {
  final climboProfffset = await SharedPreferences.getInstance();
  climboProfffset.setBool('ClimboProfffClimboProfff', true);
}

Future<bool> getClimboProfff() async {
  final climboProfffset = await SharedPreferences.getInstance();
  return climboProfffset.getBool('ClimboProfffClimboProfff') ?? false;
}

Future<void> climboProfffRes(BuildContext context) async {
  final climboProfffResAccess = await Apphud.hasPremiumAccess();
  final climboProfffResActiveSubs = await Apphud.hasActiveSubscription();
  if (climboProfffResAccess || climboProfffResActiveSubs) {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("ClimboProfffClimboProfff", true);
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Success!'),
        content: const Text('Your purchase has been restored!'),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => const CBotomBar(
                    indexScr: 0,
                  ),
                ),
                (route) => false,
              );
            },
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  } else {
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Restore purchase'),
        content: const Text(
            'Your purchase is not found. Write to support: ${DokC.suprF}'),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => {Navigator.of(context).pop()},
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }
}
