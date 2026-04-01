extension StringExtensions on String {
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  String get capitalizeWords {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize).join(' ');
  }

  bool get isValidEmail {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(this);
  }

  bool get isValidPassword {
    if (length < 8) return false;
    final hasUppercase = RegExp('[A-Z]').hasMatch(this);
    final hasLowercase = RegExp('[a-z]').hasMatch(this);
    final hasDigit = RegExp('[0-9]').hasMatch(this);
    return hasUppercase && hasLowercase && hasDigit;
  }

  String? get nullIfEmpty => isEmpty ? null : this;

  String truncate(int maxLength, {String ellipsis = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength - ellipsis.length)}$ellipsis';
  }

  String get removeWhitespace => replaceAll(RegExp(r'\s+'), '');

  bool get isNumeric => double.tryParse(this) != null;

  String get orEmpty => this;
}
