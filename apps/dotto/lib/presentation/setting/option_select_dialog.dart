import 'package:flutter/material.dart';

/// 「なし」を含む選択肢から 1 つを選ぶダイアログ。
///
/// 選ばれた値 (「なし」の場合は `null`) を [onSelected] に渡す。
final class OptionSelectDialog<T> extends StatelessWidget {
  const new({
    required this.title,
    required this.options,
    required this.selected,
    required this.labelOf,
    required this.onSelected,
    super.key,
  });

  final String title;
  final List<T> options;
  final T? selected;
  final String Function(T option) labelOf;
  final Future<void> Function(T? option) onSelected;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(title),
      children: [
        _OptionButton(
          label: 'なし',
          isSelected: selected == null,
          onPressed: () => _select(context, null),
        ),
        ...options.map(
          (option) => _OptionButton(
            label: labelOf(option),
            isSelected: selected == option,
            onPressed: () => _select(context, option),
          ),
        ),
      ],
    );
  }

  Future<void> _select(BuildContext context, T? option) async {
    await onSelected(option);
    if (!context.mounted) return;
    Navigator.of(context).pop();
  }
}

final class _OptionButton extends StatelessWidget {
  const new({
    required this.label,
    required this.isSelected,
    required this.onPressed,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: ListTile(
        title: Text(label),
        trailing: Icon(isSelected ? Icons.check : null),
      ),
    );
  }
}
