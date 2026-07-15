final class Flag<T> {
  const Flag({
    required this.key,
    required this.description,
    required this.defaultValue,
  });

  final String key;
  final String description;
  final T defaultValue;
}
