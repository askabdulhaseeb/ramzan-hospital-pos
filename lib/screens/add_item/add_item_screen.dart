import 'package:flutter/material.dart';

import '../../widgets/custom_widgets/custom_board_widget.dart';
import '../../widgets/custom_widgets/custom_title_textformfield.dart';
import '../../widgets/item/dropdowns/item_cat_dropdown.dart';
import '../../widgets/item/dropdowns/item_formula_dropdown.dart';
import '../../widgets/item/dropdowns/item_sub_cat_dropdown.dart';
import '../../widgets/item/dropdowns/line_item_dropdown.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({Key? key}) : super(key: key);
  static const String routeName = '/add-product';

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final TextEditingController _barcode = TextEditingController();
  final TextEditingController _name = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AddItemScreen')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // BASIC
              CustomBoardWidget(
                title: 'Basic Info',
                width: 420,
                child: Column(
                  children: <Widget>[
                    const LineItemDropdown(),
                    CustomTitleTextFormField(
                      controller: _barcode,
                      title: 'Item Code',
                    ),
                    CustomTitleTextFormField(
                      controller: _name,
                      title: 'Item Name',
                    ),
                  ],
                ),
              ),
              // INFO
              CustomBoardWidget(
                title: 'About Item',
                width: 420,
                child: Column(
                  children: const <Widget>[
                    ItemCatDropdown(),
                    ItemSubCatDropdown(),
                    ItemFormulaDropdown(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
