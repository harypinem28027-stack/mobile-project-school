enum CodeType {
  normal,
  error,
  success,
}

class CodeLine {
  final String number;
  final String text;
  final CodeType type;

  CodeLine({
    required this.number,
    required this.text,
    required this.type,
  });
}
