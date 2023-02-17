import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utilities/utilities.dart';

class CustomLableTextFormField extends StatefulWidget {
  const CustomLableTextFormField({
    required this.lable,
    required TextEditingController controller,
    this.lablewidth = 80,
    this.width,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.validator,
    this.initialValue,
    this.hint = '',
    this.color,
    this.contentPadding,
    this.minLines = 1,
    this.maxLines = 1,
    this.maxLength,
    this.showSuffixIcon = true,
    this.readOnly = false,
    this.autoFocus = false,
    this.textAlign = TextAlign.start,
    this.style,
    this.border,
    this.starticon,
    this.borderColor,
    Key? key,
  })  : _controller = controller,
        super(key: key);
  final String lable;
  final double lablewidth;
  final double? width;
  final TextEditingController? _controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final void Function(String)? onChanged;
  final bool showSuffixIcon;
  final String? Function(String? value)? validator;
  final EdgeInsetsGeometry? contentPadding;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final Color? color;
  final String? initialValue;
  final String? hint;
  final bool readOnly;
  final bool autoFocus;
  final TextAlign textAlign;
  final InputBorder? border;
  final TextStyle? style;
  final IconData? starticon;
  final Color? borderColor;
  @override
  CustomLableTextFormFieldState createState() =>
      CustomLableTextFormFieldState();
}

class CustomLableTextFormFieldState extends State<CustomLableTextFormField> {
  void _onListen() => setState(() {});
  @override
  void initState() {
    widget._controller!.addListener(_onListen);
    super.initState();
  }

  @override
  void dispose() {
    widget._controller!.removeListener(_onListen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      constraints: BoxConstraints(maxWidth: 300),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: widget.lablewidth,
            child: Text(
              widget.lable,
              style: const TextStyle(fontSize: 12),
            ),
          ),
          Expanded(
            child: TextFormField(
              initialValue: widget.initialValue,
              controller: widget._controller,
              readOnly: widget.readOnly,
              inputFormatters: widget.keyboardType == TextInputType.number
                  ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
                  : null,
              keyboardType: widget.keyboardType == TextInputType.number
                  ? const TextInputType.numberWithOptions(
                      signed: true, decimal: true)
                  : widget.maxLines! > 1
                      ? TextInputType.multiline
                      : widget.keyboardType ?? TextInputType.text,
              textInputAction: widget.maxLines! > 1
                  ? TextInputAction.newline
                  : widget.textInputAction ?? TextInputAction.next,
              autofocus: widget.autoFocus,
              textAlign: widget.textAlign,
              onChanged: widget.onChanged,
              minLines: widget.minLines,
              maxLines:
                  (widget._controller!.text.isEmpty) ? 1 : widget.maxLines,
              maxLength: widget.maxLength,
              style: widget.style ?? const TextStyle(fontSize: 14),
              validator: (String? value) =>
                  widget.validator == null ? null : widget.validator!(value),
              decoration: InputDecoration(
                contentPadding: widget.contentPadding ??
                    EdgeInsets.only(
                        left: 10,
                        top: widget._controller!.text.isEmpty ? 0 : 12),
                fillColor: widget.color ??
                    Theme.of(context).textTheme.bodyLarge!.color!,
                hintText: widget.hint,
                hintStyle: TextStyle(color: Colors.grey.shade400),
                suffixIcon: (widget._controller!.text.isEmpty ||
                        !widget.showSuffixIcon ||
                        widget.showSuffixIcon == false ||
                        widget.readOnly)
                    ? null
                    : IconButton(
                        splashRadius: 6,
                        onPressed: () => setState(() {
                          widget._controller!.clear();
                        }),
                        icon: const Icon(
                          CupertinoIcons.clear_circled,
                          size: 16,
                        ),
                      ),
                focusColor: Theme.of(context).primaryColor,
                border: widget.border ?? InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
