class CodeModel {
  final String id;
  final String code;
  final DateTime date;

  CodeModel({
    required this.id,
    required this.code,
    required this.date,
  });

  factory CodeModel.fromMap(Map<String, dynamic> map) {
    return CodeModel(
      id: map['id'],
      code: map['code'],
      date: map['date'].toDate(),
    );
  }
}
