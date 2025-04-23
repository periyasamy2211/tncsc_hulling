class FrkReceivedModel {
  final String id; // Firestore document ID
  final DateTime date;
  final String lorryNumber;
  final String invoiceNumber;
  final int bagsCount;
  final double weightKg;

  FrkReceivedModel({
    required this.id,
    required this.date,
    required this.lorryNumber,
    required this.invoiceNumber,
    required this.bagsCount,
    required this.weightKg,
  });

  /// Converts the model to a Firestore-compatible map
  Map<String, dynamic> toMap() {
    return {
      'date': date.toIso8601String(),
      'lorry_number': lorryNumber,
      'invoice_number': invoiceNumber,
      'bags_count': bagsCount,
      'weight_kg': weightKg,
    };
  }

  /// Creates an object from a Firestore-compatible map
  factory FrkReceivedModel.fromMap(Map<String, dynamic> map, String id) {
    return FrkReceivedModel(
      id: id, // Use Firestore document ID
      date: DateTime.parse(map['date']),
      lorryNumber: map['lorry_number'] as String,
      invoiceNumber: map['invoice_number'] as String,
      bagsCount: map['bags_count'] as int,
      weightKg: map['weight_kg'] as double,
    );
  }

  /// Optional: Override `toString` for easier debugging
  @override
  String toString() {
    return 'FrkReceivedModel(id: $id, date: $date, lorryNumber: $lorryNumber, invoiceNumber: $invoiceNumber, '
        'bagsCount: $bagsCount, weightKg: $weightKg)';
  }
}