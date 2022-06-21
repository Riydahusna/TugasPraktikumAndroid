extension StringExtensions on String {
  String topCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1)}' : '';

  String toTitleCase() => replaceAll(RegExp('+'), '')
      .split("")
      .map((str) => str.topCapitalized())
      .join("");
}
