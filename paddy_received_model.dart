class PaddyReceivedModel {
  final String id; // Firestore document ID
  final DateTime date;
  final String lorryNumber;
  final String issueMemoNumber;
  final String variety;
  final int bagsCount;
  final double weightKg;
  final int nb;
  final int onb;
  final int ss;
  final int swp;
  final int us;
  final String place;
  final String kmsYear;

  PaddyReceivedModel({
    required this.id,
    required this.date,
    required this.lorryNumber,
    required this.issueMemoNumber,
    required this.variety,
    required this.bagsCount,
    required this.weightKg,
    required this.nb,
    required this.onb,
    required this.ss,
    required this.swp,
    required this.us,
    required this.place,
    required this.kmsYear,
  });

  /// Converts the model to a Firestore-compatible map
  Map<String, dynamic> toMap() {
    return {
      'date': date.toIso8601String(),
      'lorry_number': lorryNumber,
      'issue_memo_number': issueMemoNumber,
      'variety': variety,
      'bags_count': bagsCount,
      'weight_kg': weightKg,
      'nb': nb,
      'onb': onb,
      'ss': ss,
      'swp': swp,
      'us': us,
      'place': place,
      'kms_year': kmsYear,
    };
  }

  /// Creates an object from a Firestore-compatible map
  factory PaddyReceivedModel.fromMap(Map<String, dynamic> map, String id) {
    return PaddyReceivedModel(
      id: id, // Use Firestore document ID
      date: DateTime.parse(map['date']),
      lorryNumber: map['lorry_number'] as String,
      issueMemoNumber: map['issue_memo_number'] as String,
      variety: map['variety'] as String,
      bagsCount: map['bags_count'] as int,
      weightKg: map['weight_kg'] as double,
      nb: map['nb'] as int,
      onb: map['onb'] as int,
      ss: map['ss'] as int,
      swp: map['swp'] as int,
      us: map['us'] as int,
      place: map['place'] as String,
      kmsYear: map['kms_year'] as String,
    );
  }

  /// Optional: Override `toString` for easier debugging
  @override
  String toString() {
    return 'PaddyReceivedModel(id: $id, date: $date, lorryNumber: $lorryNumber, issueMemoNumber: $issueMemoNumber, '
        'variety: $variety, bagsCount: $bagsCount, weightKg: $weightKg, nb: $nb, '
        'onb: $onb, ss: $ss, swp: $swp, us: $us, place: $place, kmsYear: $kmsYear)';
  }
}