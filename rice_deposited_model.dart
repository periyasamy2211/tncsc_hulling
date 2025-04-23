class RiceDepositedModel {
  final String id; // Firestore document ID
  final DateTime date;
  final String lorryNumber;
  final String truckMemoNumber;
  final String acknowledgmentNumber;
  final String variety;
  final int bagsCount;
  final double weightKg;
  final int nb;
  final int onb;
  final int ss;
  final int swp;
  final int us;
  final String depositLocation;
  final String kmsYear;

  RiceDepositedModel({
    required this.id,
    required this.date,
    required this.lorryNumber,
    required this.truckMemoNumber,
    required this.acknowledgmentNumber,
    required this.variety,
    required this.bagsCount,
    required this.weightKg,
    required this.nb,
    required this.onb,
    required this.ss,
    required this.swp,
    required this.us,
    required this.depositLocation,
    required this.kmsYear,
  });

  /// Converts the model to a Firestore-compatible map
  Map<String, dynamic> toMap() {
    return {
      'date': date.toIso8601String(),
      'lorry_number': lorryNumber,
      'truck_memo_number': truckMemoNumber,
      'acknowledgment_number': acknowledgmentNumber,
      'variety': variety,
      'bags_count': bagsCount,
      'weight_kg': weightKg,
      'nb': nb,
      'onb': onb,
      'ss': ss,
      'swp': swp,
      'us': us,
      'deposit_location': depositLocation,
      'kms_year': kmsYear,
    };
  }

  /// Creates an object from a Firestore-compatible map
  factory RiceDepositedModel.fromMap(Map<String, dynamic> map, String id) {
    return RiceDepositedModel(
      id: id, // Use Firestore document ID
      date: DateTime.parse(map['date']),
      lorryNumber: map['lorry_number'] as String,
      truckMemoNumber: map['truck_memo_number'] as String,
      acknowledgmentNumber: map['acknowledgment_number'] as String,
      variety: map['variety'] as String,
      bagsCount: map['bags_count'] as int,
      weightKg: map['weight_kg'] as double,
      nb: map['nb'] as int,
      onb: map['onb'] as int,
      ss: map['ss'] as int,
      swp: map['swp'] as int,
      us: map['us'] as int,
      depositLocation: map['deposit_location'] as String,
      kmsYear: map['kms_year'] as String,
    );
  }

  /// Optional: Override `toString` for easier debugging
  @override
  String toString() {
    return 'RiceDepositedModel(id: $id, date: $date, lorryNumber: $lorryNumber, truckMemoNumber: $truckMemoNumber, '
        'acknowledgmentNumber: $acknowledgmentNumber, variety: $variety, bagsCount: $bagsCount, weightKg: $weightKg, '
        'nb: $nb, onb: $onb, ss: $ss, swp: $swp, us: $us, depositLocation: $depositLocation, kmsYear: $kmsYear)';
  }
}