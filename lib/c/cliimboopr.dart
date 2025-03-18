// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Klimbitpr with ChangeNotifier {
  List<Ascektik> ascektikLi = [];
  List<GeriTraty> geriTratyLi = [];

  Klimbitpr() {
    _gg1241();
  }

  Future<void> _gg1241() async {
    final kashiki = await SharedPreferences.getInstance();

    final bbgdfg = kashiki.getStringList('Ascektik') ?? [];

    ascektikLi = bbgdfg.map((item) => Ascektik.fromJson(item)).toList();

    final bh43332 = kashiki.getStringList('geriTratyLi') ?? [];

    geriTratyLi = bh43332.map((item) => GeriTraty.fromJson(item)).toList();

    notifyListeners();
  }

  Future<void> _gg31223() async {
    final kashiki = await SharedPreferences.getInstance();

    final vbfdf = ascektikLi.map((item) => item.toJson()).toList();
    await kashiki.setStringList('Ascektik', vbfdf);

    final y3434 = geriTratyLi.map((item) => item.toJson()).toList();
    await kashiki.setStringList('geriTratyLi', y3434);
  }

  void crakAscektik(Ascektik newAscektik, Ascektik? oldAscektik) {
    if (oldAscektik != null) {
      final innfff = ascektikLi.indexWhere(
        (element) => newAscektik.ascektikIdd == oldAscektik.ascektikIdd,
      );
      if (innfff != -1) {
        ascektikLi[innfff] = newAscektik;
      }
    } else {
      ascektikLi.add(newAscektik);
    }
    _gg31223();
    notifyListeners();
  }

  void deAscektik(Ascektik newAscektik) {
    final iinde = ascektikLi.indexWhere(
      (element) => element.ascektikIdd == newAscektik.ascektikIdd,
    );
    if (iinde != -1) {
      ascektikLi.removeAt(iinde);
    }
    _gg31223();
    notifyListeners();
  }

  void crakGeriTraty(GeriTraty newGeriTraty, GeriTraty? oldGeriTraty) {
    if (oldGeriTraty != null) {
      final innfff = geriTratyLi.indexWhere(
        (element) => newGeriTraty.geriTratyId == oldGeriTraty.geriTratyId,
      );
      if (innfff != -1) {
        geriTratyLi[innfff] = newGeriTraty;
      }
    } else {
      geriTratyLi.add(newGeriTraty);
    }
    _gg31223();
    notifyListeners();
  }

  void deGeriTraty(GeriTraty newGeriTraty) {
    final iinde = geriTratyLi.indexWhere(
      (element) => element.geriTratyId == newGeriTraty.geriTratyId,
    );
    if (iinde != -1) {
      geriTratyLi.removeAt(iinde);
    }
    _gg31223();
    notifyListeners();
  }
}

class KategAmont {
  final String kateg;
  final int amont;
  KategAmont({
    required this.kateg,
    required this.amont,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'kateg': kateg,
      'amont': amont,
    };
  }

  factory KategAmont.fromMap(Map<String, dynamic> map) {
    return KategAmont(
      kateg: map['kateg'] as String,
      amont: map['amont'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory KategAmont.fromJson(String source) =>
      KategAmont.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Ascektik {
  final int ascektikIdd;
  final bool isVso;
  final DateTime ascektikDate;
  final String ascektikLoka;
  final List<String> ascektikGol;
  final List<KategAmont> listKategAmont;
  Ascektik(
      {required this.ascektikIdd,
      required this.isVso,
      required this.ascektikDate,
      required this.ascektikLoka,
      required this.ascektikGol,
      required this.listKategAmont});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ascektikIdd': ascektikIdd,
      'isVso': isVso,
      'ascektikDate': ascektikDate.millisecondsSinceEpoch,
      'ascektikLoka': ascektikLoka,
      'ascektikGol': ascektikGol,
      'listKategAmont': listKategAmont.map((x) => x.toMap()).toList(),
    };
  }

  factory Ascektik.fromMap(Map<String, dynamic> map) {
    return Ascektik(
      ascektikIdd: map['ascektikIdd'] as int,
      isVso: map['isVso'] as bool,
      ascektikDate:
          DateTime.fromMillisecondsSinceEpoch(map['ascektikDate'] as int),
      ascektikLoka: map['ascektikLoka'] as String,
      ascektikGol: List<String>.from((map['ascektikGol'] as List)),
      listKategAmont: List<KategAmont>.from(
        (map['listKategAmont'] as List).map<KategAmont>(
          (x) => KategAmont.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Ascektik.fromJson(String source) =>
      Ascektik.fromMap(json.decode(source) as Map<String, dynamic>);
  Ascektik copyWith(
      {int? ascektikIdd,
      bool? isVso,
      DateTime? ascektikDate,
      String? ascektikLoka,
      List<String>? ascektikGol,
      List<KategAmont>? listKategAmont}) {
    return Ascektik(
        ascektikIdd: ascektikIdd ?? this.ascektikIdd,
        isVso: isVso ?? this.isVso,
        ascektikDate: ascektikDate ?? this.ascektikDate,
        ascektikLoka: ascektikLoka ?? this.ascektikLoka,
        ascektikGol: ascektikGol ?? this.ascektikGol,
        listKategAmont: listKategAmont ?? this.listKategAmont);
  }
}

class GeriTraty {
  final int geriTratyId;
  final String geriTratyNam;
  final int geriTratyAmont;
  final DateTime geriTratyPurch;
  final DateTime? geriTratyReplc;
  final bool isgeriTratyNot;
  GeriTraty({
    required this.geriTratyId,
    required this.geriTratyNam,
    required this.geriTratyAmont,
    required this.geriTratyPurch,
    this.geriTratyReplc,
    required this.isgeriTratyNot,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'geriTratyId': geriTratyId,
      'geriTratyNam': geriTratyNam,
      'geriTratyAmont': geriTratyAmont,
      'geriTratyPurch': geriTratyPurch.millisecondsSinceEpoch,
      'geriTratyReplc': geriTratyReplc?.millisecondsSinceEpoch,
      'isgeriTratyNot': isgeriTratyNot,
    };
  }

  factory GeriTraty.fromMap(Map<String, dynamic> map) {
    return GeriTraty(
      geriTratyId: map['geriTratyId'] as int,
      geriTratyNam: map['geriTratyNam'] as String,
      geriTratyAmont: map['geriTratyAmont'] as int,
      geriTratyPurch:
          DateTime.fromMillisecondsSinceEpoch(map['geriTratyPurch'] as int),
      geriTratyReplc: map['geriTratyReplc'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['geriTratyReplc'] as int)
          : null,
      isgeriTratyNot: map['isgeriTratyNot'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory GeriTraty.fromJson(String source) =>
      GeriTraty.fromMap(json.decode(source) as Map<String, dynamic>);
}

List<String> katagaoer = [
  'Travel',
  'Accommodation',
  'Nutrition',
  'Transport',
  'Other',
];
