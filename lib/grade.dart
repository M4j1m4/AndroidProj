class Grade {
  final String subjectCode;
  final String description;
  final int units;
  final int prelim;
  final int midterm;
  final int prefinals;

  Grade({
    required this.subjectCode,
    required this.description,
    required this.units,
    required this.prelim,
    required this.midterm,
    required this.prefinals,
  });

  factory Grade.fromJson(Map<String, dynamic> json) {
  return Grade(
    subjectCode: json['subjectCode'],
    description: json['description'],
    units: int.parse(json['units']),
    prelim: int.parse(json['prelim']),
    midterm: int.parse(json['midterm']),
    prefinals: int.parse(json['prefinals']),
  );
}
}
