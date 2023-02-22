import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../database/item_api/manufacturer_api.dart';
import '../../../function/time_date_function.dart';
import '../../../models/item/item_category.dart';
import '../../../models/item/item_manufacturer.dart';
import '../../../providers/item/item_category_provider.dart';
import '../../../providers/item/item_manufacturer_provider.dart';
import '../../../utilities/custom_validator.dart';
import '../../../utilities/utilities.dart';
import '../../custom_widgets/custom_textformfield.dart';

class ItemManufacturerDropdown extends StatefulWidget {
  const ItemManufacturerDropdown({super.key});

  @override
  State<ItemManufacturerDropdown> createState() =>
      _ItemManufacturerDropdownState();
}

class _ItemManufacturerDropdownState extends State<ItemManufacturerDropdown> {
  TextEditingController _manufacturer = TextEditingController();
  uploadData(BuildContext context) async {
    ItemManufacturerProvider manufacturerPro =
        Provider.of<ItemManufacturerProvider>(context, listen: false);
    ItemManufacturer value = ItemManufacturer(
        id: TimeStamp.timestamp.toString(), name: _manufacturer.text);
    bool temp = await ManufacturerAPI().add(value);
    manufacturerPro.manufacturerUpdate(value);
    if (temp) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context, 'ok');
      _manufacturer.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    ItemManufacturerProvider manuPro =
        Provider.of<ItemManufacturerProvider>(context);
    final List<ItemManufacturer> manu = manuPro.manufacturer;
    return Row(
      children: <Widget>[
        SizedBox(
          width: Utlities.titleWidth,
          child: Text(
            'Manufacturer',
            style: Utlities.itemTitleTextStyle,
          ),
        ),
        Expanded(
          child:  Padding(
              padding:
                  const EdgeInsets.only(left: 18, right: 8, top: 4, bottom: 4),
                   child: DropdownButtonFormField<ItemManufacturer>(
                  isExpanded: true,
                       decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
                alignment: Alignment.centerLeft,
               // value: manuPro.selectedManufacturer,
                style: const TextStyle(color: Colors.black),
                //underline: const SizedBox(),
                hint: const Text(
                  '',
                  style: TextStyle(color: Colors.black),
                ),
                items: manuPro.manufacturer
                    .map((ItemManufacturer cats) => DropdownMenuItem<ItemManufacturer>(
                          value: cats,
                          child: Text(
                            cats.name.toUpperCase(),
                            style: const TextStyle(),
                          ),
                        ))
                    .toList(),
                onChanged: (ItemManufacturer? value) =>
                    manuPro.onManufacturerUpdate(value!),
              ),
              
            ),
        ),
      manuPro.edit
            ? const SizedBox()
            : IconButton(
            onPressed: () {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Add Manufacturer'),
                  content: CustomTextFormField(
                    controller: _manufacturer,
                    hint: 'Manufacturer ',
                    validator: (value) => CustomValidator.lessThen2(value),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        uploadData(context);
                        ;
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
            splashRadius: 16,
            icon: const Icon(
              Icons.add_box_rounded,
            )),
      ],
    );
  }
}
