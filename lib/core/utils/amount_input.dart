import 'package:flutter/services.dart';

class DecimalAmountInputFormatter extends TextInputFormatter {
  const DecimalAmountInputFormatter();

  static final _partialDecimalPattern = RegExp(r'^\d*(?:\.\d*)?$');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (_partialDecimalPattern.hasMatch(newValue.text)) {
      return newValue;
    }
    return oldValue;
  }
}

String? validatePositiveAmount(
  String? value, {
  required String emptyMessage,
  String? minAmount,
  String? minMessage,
}) {
  final text = value?.trim() ?? '';
  if (text.isEmpty) {
    return emptyMessage;
  }
  if (!RegExp(r'^\d+(?:\.\d+)?$').hasMatch(text)) {
    return '请输入合法金额';
  }
  if (!text.codeUnits.any((unit) => unit >= 49 && unit <= 57)) {
    return '请输入大于 0 的金额';
  }
  final min = minAmount?.trim();
  if (min != null && min.isNotEmpty) {
    final comparison = _compareDecimalStrings(text, min);
    if (comparison != null && comparison < 0) {
      return minMessage ?? '金额不能低于 $min';
    }
  }
  return null;
}

int? _compareDecimalStrings(String left, String right) {
  final leftParts = _decimalParts(left);
  final rightParts = _decimalParts(right);
  if (leftParts == null || rightParts == null) {
    return null;
  }
  final intCompare = _compareDigits(leftParts.$1, rightParts.$1);
  if (intCompare != 0) {
    return intCompare;
  }
  final maxFracLength = leftParts.$2.length > rightParts.$2.length
      ? leftParts.$2.length
      : rightParts.$2.length;
  final leftFrac = leftParts.$2.padRight(maxFracLength, '0');
  final rightFrac = rightParts.$2.padRight(maxFracLength, '0');
  return leftFrac.compareTo(rightFrac);
}

(String, String)? _decimalParts(String value) {
  final text = value.trim();
  if (!RegExp(r'^\d+(?:\.\d+)?$').hasMatch(text)) {
    return null;
  }
  final parts = text.split('.');
  final integer = _trimLeadingZeros(parts.first);
  final fraction = parts.length > 1 ? _trimTrailingZeros(parts[1]) : '';
  return (integer, fraction);
}

String _trimLeadingZeros(String value) {
  final trimmed = value.replaceFirst(RegExp(r'^0+'), '');
  return trimmed.isEmpty ? '0' : trimmed;
}

String _trimTrailingZeros(String value) {
  return value.replaceFirst(RegExp(r'0+$'), '');
}

int _compareDigits(String left, String right) {
  final normalizedLeft = _trimLeadingZeros(left);
  final normalizedRight = _trimLeadingZeros(right);
  if (normalizedLeft.length != normalizedRight.length) {
    return normalizedLeft.length.compareTo(normalizedRight.length);
  }
  return normalizedLeft.compareTo(normalizedRight);
}
