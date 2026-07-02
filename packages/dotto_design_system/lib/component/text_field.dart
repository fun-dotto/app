import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

final class DottoTextField extends StatelessWidget {
  const DottoTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.placeholder,
    this.onCleared,
    this.onChanged,
    this.onSubmitted,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? placeholder;
  final VoidCallback? onCleared;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    final controller = this.controller;
    if (controller == null) {
      return TextField(
        focusNode: focusNode,
        decoration: InputDecoration(hintText: placeholder),
        onChanged: onChanged,
        onSubmitted: onSubmitted,
      );
    }

    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        return TextField(
          controller: controller,
          focusNode: focusNode,
          decoration: InputDecoration(
            hintText: placeholder,
            suffixIcon: controller.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      controller.clear();
                      onCleared?.call();
                    },
                  )
                : null,
          ),
          onChanged: onChanged,
          onSubmitted: onSubmitted,
        );
      },
    );
  }
}

final class _Demo extends StatelessWidget {
  const _Demo({
    //
    // ignore: unused_element_parameter
    this.controller,
    //
    // ignore: unused_element_parameter
    this.focusNode,
    this.placeholder,
    //
    // ignore: unused_element_parameter
    this.onCleared,
    //
    // ignore: unused_element_parameter
    this.onChanged,
    //
    // ignore: unused_element_parameter
    this.onSubmitted,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? placeholder;
  final VoidCallback? onCleared;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        spacing: 16,
        children: [
          DottoTextField(
            controller: controller,
            focusNode: focusNode,
            placeholder: placeholder,
            onCleared: onCleared,
            onChanged: onChanged,
            onSubmitted: onSubmitted,
          ),
        ],
      ),
    );
  }
}

@widgetbook.UseCase(name: 'TextField', type: DottoTextField)
Widget textField(BuildContext context) {
  return const _Demo(placeholder: 'Type here...');
}
