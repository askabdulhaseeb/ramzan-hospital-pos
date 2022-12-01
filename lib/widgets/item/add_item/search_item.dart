import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/item/item.dart';
import '../../../providers/item/item_provider.dart';
import '../../../utilities/custom_validator.dart';
import '../../custom_widgets/custom_textformfield.dart';
import 'update_item.dart';

class SearchAddScreen extends StatefulWidget {
  const SearchAddScreen({super.key});

  @override
  State<SearchAddScreen> createState() => _SearchAddScreenState();
}

class _SearchAddScreenState extends State<SearchAddScreen> {
  final TextEditingController _barcode = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    ItemProvider itemPro = Provider.of<ItemProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('EditAddScreen'),
      ),
      body: Form(
        key: _formKey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextFormField(
              width: 140,
              height: 35,
              hint: 'barcode add',
              controller: _barcode,
              color: Colors.white,
              validator: (String? value) => CustomValidator.isEmpty(value),
            ),
            IconButton(
              onPressed: () {
                if (!_formKey.currentState!.validate()) return;
                Item? item = itemPro.item(_barcode.text);

                if (item == null) {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('No item Found'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Cancel'),
                        ),
                      ],
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    // ignore: always_specify_types
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const UpdateItemScreen(),
                    ),
                  );
                }
              },
              icon: const Icon(
                Icons.save,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }
}
