class MoneyFormatters {
  static String amount(String? value, {String fallback = '--'}) {
    final text = value?.trim();
    if (text == null || text.isEmpty) {
      return fallback;
    }
    return text;
  }

  static String balance(String? value, {String fallback = '--'}) {
    return fixedAmount(value, fallback: fallback);
  }

  static String fixedAmount(
    String? value, {
    String fallback = '--',
    int fractionDigits = 2,
  }) {
    final text = amount(value, fallback: fallback);
    if (text == fallback) {
      return fallback;
    }
    return _fixedDecimal(text, fractionDigits: fractionDigits) ?? text;
  }

  static String number(String? value, {String fallback = '--'}) {
    final text = amount(value, fallback: fallback);
    if (text == fallback) {
      return fallback;
    }
    return _groupNumber(text) ?? text;
  }

  static String usdt(String? value, {String fallback = '--'}) {
    final text = amount(value, fallback: fallback);
    return text == fallback ? fallback : '$text USDT';
  }

  static String usdtBalance(String? value, {String fallback = '--'}) {
    final text = balance(value, fallback: fallback);
    return text == fallback ? fallback : '$text USDT';
  }
}

String? _fixedDecimal(String value, {required int fractionDigits}) {
  var text = value.trim().replaceAll(',', '').replaceAll(' ', '');
  if (text.isEmpty) {
    return null;
  }

  var isNegative = false;
  if (text.startsWith('-') || text.startsWith('+')) {
    isNegative = text.startsWith('-');
    text = text.substring(1);
  }

  final parts = text.split('.');
  if (parts.length > 2) {
    return null;
  }

  final integerPart = parts[0].isEmpty ? '0' : parts[0];
  final fractionalPart = parts.length == 2 ? parts[1] : '';
  final digitsOnly = RegExp(r'^\d+$');
  if (!digitsOnly.hasMatch(integerPart) ||
      (fractionalPart.isNotEmpty && !digitsOnly.hasMatch(fractionalPart))) {
    return null;
  }

  final paddedFraction = fractionalPart.padRight(fractionDigits + 1, '0');
  final keptFraction = paddedFraction.substring(0, fractionDigits);
  final roundingDigit = int.parse(paddedFraction[fractionDigits]);
  var scaled = BigInt.parse('$integerPart$keptFraction');
  if (roundingDigit >= 5) {
    scaled += BigInt.one;
  }

  final scale = BigInt.from(10).pow(fractionDigits);
  final integer = scaled ~/ scale;
  final fraction = (scaled % scale).toString().padLeft(fractionDigits, '0');
  final sign = isNegative && scaled != BigInt.zero ? '-' : '';
  return '$sign${_groupInteger(integer.toString())}.$fraction';
}

String _groupInteger(String value) {
  final buffer = StringBuffer();
  for (var i = 0; i < value.length; i += 1) {
    if (i > 0 && (value.length - i) % 3 == 0) {
      buffer.write(',');
    }
    buffer.write(value[i]);
  }
  return buffer.toString();
}

String? _groupNumber(String value) {
  var text = value.trim().replaceAll(',', '').replaceAll(' ', '');
  if (text.isEmpty) {
    return null;
  }

  var sign = '';
  if (text.startsWith('-') || text.startsWith('+')) {
    sign = text[0];
    text = text.substring(1);
  }

  final parts = text.split('.');
  if (parts.length > 2) {
    return null;
  }

  final integerPart = parts[0].isEmpty ? '0' : parts[0];
  final fractionalPart = parts.length == 2 ? parts[1] : null;
  final digitsOnly = RegExp(r'^\d+$');
  if (!digitsOnly.hasMatch(integerPart) ||
      (fractionalPart != null &&
          fractionalPart.isNotEmpty &&
          !digitsOnly.hasMatch(fractionalPart))) {
    return null;
  }

  final grouped = '$sign${_groupInteger(integerPart)}';
  if (fractionalPart == null || fractionalPart.isEmpty) {
    return grouped;
  }
  return '$grouped.$fractionalPart';
}
