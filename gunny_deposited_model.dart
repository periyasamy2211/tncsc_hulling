class GunnyDepositedModel {
  final String id; // Firestore document ID
  final String truckMemoNumber;
  final DateTime date;
  final String acknowledgmentNumber;
  final int noOfBundlesOnb;
  final int noOfUnitsOnb;
  final int noOfBundlesSs;
  final int noOfUnitsSs;
  final int noOfBundlesSwp;
  final int noOfUnitsSwp;
  final int noOfBundlesUs;
  final int noOfUnitsUs;
  final String place;
  final String lorryNumber;
  final String kmsYear;

  GunnyDepositedModel({
    required this.id,
    required this.truckMemoNumber,
    required this.date,
    required this.acknowledgmentNumber,
    required this.noOfBundlesOnb,
    required this.noOfUnitsOnb,
    required this.noOfBundlesSs,
    required this.noOfUnitsSs,
    required this.noOfBundlesSwp,
    required this.noOfUnitsSwp,
    required this.noOfBundlesUs,
    required this.noOfUnitsUs,
    required this.place,
    required this.lorryNumber,
    required this.kmsYear,
  });

  /// Converts the model to a Firestore-compatible map
  Map<String, dynamic> toMap() {
    return {
      'truck_memo_number': truckMemoNumber,
      'date': date.toIso8601String(),
      'acknowledgment_number': acknowledgmentNumber,
      'no_of_bundles_onb': noOfBundlesOnb,
      'no_of_units_onb': noOfUnitsOnb,
      'no_of_bundles_ss': noOfBundlesSs,
      'no_of_units_ss': noOfUnitsSs,
      'no_of_bundles_swp': noOfBundlesSwp,
      'no_of_units_swp': noOfUnitsSwp,
      'no_of_bundles_us': noOfBundlesUs,
      'no_of_units_us': noOfUnitsUs,
      'place': place,
      'lorry_number': lorryNumber,
      'kms_year': kmsYear,
    };
  }

  /// Creates an object from a Firestore-compatible map
  factory GunnyDepositedModel.fromMap(Map<String, dynamic> map, String id) {
    return GunnyDepositedModel(
      id: id, // Use Firestore document ID
      truckMemoNumber: map['truck_memo_number'] as String,
      date: DateTime.parse(map['date']),
      acknowledgmentNumber: map['acknowledgment_number'] as String,
      noOfBundlesOnb: map['no_of_bundles_onb'] as int,
      noOfUnitsOnb: map['no_of_units_onb'] as int,
      noOfBundlesSs: map['no_of_bundles_ss'] as int,
      noOfUnitsSs: map['no_of_units_ss'] as int,
      noOfBundlesSwp: map['no_of_bundles_swp'] as int,
      noOfUnitsSwp: map['no_of_units_swp'] as int,
      noOfBundlesUs: map['no_of_bundles_us'] as int,
      noOfUnitsUs: map['no_of_units_us'] as int,
      place: map['place'] as String,
      lorryNumber: map['lorry_number'] as String,
      kmsYear: map['kms_year'] as String,
    );
  }

  /// Optional: Override `toString` for easier debugging
  @override
  String toString() {
    return 'GunnyDepositedModel(id: $id, truckMemoNumber: $truckMemoNumber, date: $date, '
        'acknowledgmentNumber: $acknowledgmentNumber, noOfBundlesOnb: $noOfBundlesOnb, noOfUnitsOnb: $noOfUnitsOnb, '
        'noOfBundlesSs: $noOfBundlesSs, noOfUnitsSs: $noOfUnitsSs, noOfBundlesSwp: $noOfBundlesSwp, '
        'noOfUnitsSwp: $noOfUnitsSwp, noOfBundlesUs: $noOfBundlesUs, noOfUnitsUs: $noOfUnitsUs, '
        'place: $place, lorryNumber: $lorryNumber, kmsYear: $kmsYear)';
  }
}