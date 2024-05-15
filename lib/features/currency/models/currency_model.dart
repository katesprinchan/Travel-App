class Currency {
  final String code;
  final double value;

  Currency({required this.code, required this.value});

  factory Currency.fromXml(dynamic currencyNode) {
    final code = currencyNode.getAttribute('code');
    final value = double.parse(currencyNode.text);
    return Currency(code: code, value: value);
  }
}
