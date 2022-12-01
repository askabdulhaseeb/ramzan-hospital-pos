// ignore_for_file: always_specify_types

import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';

import '../../../utilities/utilities.dart';

class LineItemDropdown extends StatelessWidget {
  const LineItemDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: Utlities.titleWidth,
          child: Text(
            'Line Item',
            style: Utlities.itemTitleTextStyle,
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 4),
            margin: const EdgeInsets.only(left: 18, right: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(Utlities.tileBorderRadius),
            ),
            child: DropdownButton(
                hint: const Text('-- select --'),
                isExpanded: true,
                borderRadius: BorderRadius.circular(Utlities.tileBorderRadius),
                underline: const SizedBox(),
                isDense: true,
                items: ['1', '2', '3']
                    .map((String e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                onChanged: (String? value) {}),
          ),
        ),
      ],
    );
  }
}
