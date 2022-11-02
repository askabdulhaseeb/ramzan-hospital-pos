import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    required this.title,
    required this.icon,
    required this.onTap,
    this.iconSize,
    this.iconColor,
    this.width,
    this.margin,
    this.padding,
    this.bgColor,
    this.borderRadius,
    this.border,
    this.textStyle,
    Key? key,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final double? iconSize;
  final Color? iconColor;
  final VoidCallback onTap;
  final double? width;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color? bgColor;
  final BorderRadius? borderRadius;
  final BoxBorder? border;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: margin ?? const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: bgColor ?? Theme.of(context).primaryColor,
        borderRadius: borderRadius ?? BorderRadius.circular(20),
        border: border,
      ),
      child: Material(
        borderRadius: borderRadius ?? BorderRadius.circular(20),
        color: bgColor ?? Theme.of(context).primaryColor,
        child: InkWell(
          borderRadius: borderRadius ?? BorderRadius.circular(20),
          onTap: onTap,
          child: Padding(
            padding: padding ??
                const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
            child: Column(
              children: <Widget>[
                Icon(
                  icon,
                  size: iconSize ?? 32,
                  color: iconColor ?? Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    title,
                    style: textStyle ??
                        const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
