import 'package:flutter/material.dart';

class TitleTextFormField extends StatefulWidget {
  const TitleTextFormField({
    required this.controller,
    required this.title,
    this.width,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.validator,
    this.initialValue,
    this.hint = '',
    this.color,
    this.contentPadding,
    this.maxLength,
    this.readOnly = false,
    this.autoFocus = false,
    this.textAlign = TextAlign.start,
    this.style,
    this.border,
    Key? key,
  }) : super(key: key);
  final TextEditingController controller;
  final String title;
  final double? width;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final void Function(String)? onChanged;
  final String? Function(String? value)? validator;
  final EdgeInsetsGeometry? contentPadding;
  final int? maxLength;
  final Color? color;
  final String? initialValue;
  final String? hint;
  final bool readOnly;
  final bool autoFocus;
  final TextAlign textAlign;
  final InputBorder? border;
  final TextStyle? style;

  @override
  State<TitleTextFormField> createState() => _TitleTextFormFieldState();
}

class _TitleTextFormFieldState extends State<TitleTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(' ${widget.title}'),
        const SizedBox(height: 2),
        SizedBox(
          width: widget.width,
          child: TextFormField(
            initialValue: widget.initialValue,
            controller: widget.controller,
            readOnly: widget.readOnly,
            keyboardType: widget.keyboardType == TextInputType.number
                ? const TextInputType.numberWithOptions(
                    signed: true, decimal: true)
                : widget.keyboardType ?? TextInputType.text,
            textInputAction: widget.textInputAction ?? TextInputAction.next,
            autofocus: widget.autoFocus,
            textAlign: widget.textAlign,
            onChanged: widget.onChanged,
            maxLength: widget.maxLength,
            style: widget.style,
            validator: (String? value) => widget.validator!(value),
            cursorColor: Theme.of(context).colorScheme.secondary,
            scrollPadding: const EdgeInsets.all(2),
            decoration: InputDecoration(
              contentPadding: widget.contentPadding ??
                  const EdgeInsets.symmetric(horizontal: 8),
              fillColor: widget.color ??
                  Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .color!
                      .withOpacity(0.15),
              hintText: widget.hint,
              hintStyle: widget.hint!.length > 15
                  ? const TextStyle(fontSize: 14)
                  : const TextStyle(fontSize: 15),
              focusColor: Theme.of(context).primaryColor,
              border: widget.border ??
                  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
