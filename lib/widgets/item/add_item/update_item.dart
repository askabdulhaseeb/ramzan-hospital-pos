import 'dart:developer';

import 'package:firedart/generated/google/protobuf/timestamp.pb.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ramzanhospital_pos/widgets/item/add_item/search_item.dart';

import '../../../database/item_api/item_api.dart';
import '../../../function/time_date_function.dart';
import '../../../models/item/item.dart';
import '../../../providers/item/item_category_provider.dart';
import '../../../providers/item/item_formula_provider.dart';
import '../../../providers/item/item_manufacturer_provider.dart';
import '../../../providers/item/item_provider.dart';
import '../../../providers/item/item_supplier_provider.dart';
import '../../../screens/add_item/add_item_screen.dart';
import '../../../utilities/custom_validator.dart';
import '../../custom_widgets/custom_board_widget.dart';
import '../../custom_widgets/custom_text_field.dart';
import '../../custom_widgets/custom_textformfield.dart';
import '../../custom_widgets/custom_title_textformfield.dart';
import '../../custom_widgets/icon_button.dart';
import '../dropdowns/item_cat_dropdown.dart';
import '../dropdowns/item_formula_dropdown.dart';
import '../dropdowns/item_manufacturer_dropdown.dart';
import '../dropdowns/item_sub_cat_dropdown.dart';
import '../dropdowns/item_supplier_dropdown.dart';
import '../dropdowns/line_item_dropdown.dart';

class UpdateItemScreen extends StatefulWidget {
  const UpdateItemScreen({Key? key}) : super(key: key);
  static const String routeName = '/add-product';

  @override
  State<UpdateItemScreen> createState() => _UpdateItemScreenState();
}

class _UpdateItemScreenState extends State<UpdateItemScreen> {
  TextEditingController _barcode = TextEditingController();
  TextEditingController _name = TextEditingController();
   TextEditingController _qty = TextEditingController(text: '0');
   TextEditingController _averagePrice = TextEditingController(text: '0');
   TextEditingController _salePrice = TextEditingController(text: '0');
   TextEditingController _discount = TextEditingController(text: '0');
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ItemProvider itemPro = Provider.of<ItemProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('UpdateItemScreen')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextFormField(
                      width: 140,
                      height: 35,
                      hint: 'barcode add',
                      controller: _barcode,
                      color: Colors.white,
                      validator: (String? value) =>
                          CustomValidator.isEmpty(value),
                    ),
                    IconButton(
                      onPressed: () {
                        Item? item = itemPro.item(_barcode.text);

                        if (item == null) {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('No item Found'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancel'),
                                ),
                              ],
                            ),
                          );
                        } else {
                          setState(() {
                            _name = TextEditingController(text: 'medicine');
                          });
                        }
                      },
                      icon: const Icon(
                        Icons.save,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        // BASIC
                        CustomBoardWidget(
                          title: 'Basic Info',
                          width: 420,
                          child: Column(
                            children: <Widget>[
                              CustomTitleTextFormField(
                                controller: _barcode,
                                title: 'Item Code',
                                validator: (String? value) =>
                                    CustomValidator.lessThen5(value),
                              ),
                              CustomTitleTextFormField(
                                controller: _name,
                                title: 'Item Name',
                                validator: (String? value) =>
                                    CustomValidator.lessThen4(value),
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
                    const SizedBox(width: 20),
                    // Source
                    Column(
                      children: <Widget>[
                        CustomBoardWidget(
                          title: 'Source',
                          width: 420,
                          child: Column(
                            children: const <Widget>[
                              ItemManufacturerDropdown(),
                              ItemSupplierDropdown(),
                            ],
                          ),
                        ),
                        CustomBoardWidget(
                          title: 'Pricing (Per Unit)',
                          width: 420,
                          child: Column(
                            children: <Widget>[
                              CustomTitleTextFormField(
                                controller: _qty,
                                title: 'Item Quantity',
                                readOnly: true,
                                validator: (String? value) =>
                                    CustomValidator.isEmpty(value),
                              ),
                              CustomTitleTextFormField(
                                controller: _averagePrice,
                                title: 'Average Price',
                                validator: (String? value) =>
                                    CustomValidator.isEmpty(value),
                              ),
                              CustomTitleTextFormField(
                                controller: _salePrice,
                                title: 'Sale Price',
                                validator: (String? value) =>
                                    CustomValidator.greaterThen(
                                        value, _averagePrice.text),
                              ),
                              CustomTitleTextFormField(
                                controller: _discount,
                                title: 'Discount',
                                validator: (String? value) => null,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Row(
                  children: <Widget>[
                    const SizedBox(width: 320),
                    CustomIconButton(
                      title: 'Update',
                      icon: Icons.update,
                      onTap: () async => await addItem(context),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addItem(BuildContext context) async {
    log('Starting');
    if (!_key.currentState!.validate()) return;
    log('Add Item');
    final ItemCatProvider catPro =
        Provider.of<ItemCatProvider>(context, listen: false);
    final ItemFormulaProvider formulaPro =
        Provider.of<ItemFormulaProvider>(context, listen: false);
    final ItemManufacturerProvider manuPro =
        Provider.of<ItemManufacturerProvider>(context, listen: false);
    final ItemSupplierProvider supplyPro =
        Provider.of<ItemSupplierProvider>(context, listen: false);
    final Item value = Item(
      id: TimeStamp.timestamp.toString(),
      name: _name.text,
      code: _barcode.text,
      line: '',
      category: catPro.selectedCategroy!.catID,
      subCategory: catPro.selectedSubCategory!.subCatID,
      formula: formulaPro.selectedFormula!.id,
      manufacturer: manuPro.selectedManufacturer!.id,
      supplier: supplyPro.selectedSupplier!.id,
      quantity: int.parse(_qty.text),
      averagePrice: double.parse(_averagePrice.text),
      salePrice: double.parse(_salePrice.text),
      discount: double.parse(_discount.text),
    );
    bool temp = await ItemAPI().add(value);
    if (temp) {
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        // ignore: always_specify_types
        MaterialPageRoute(
          builder: (BuildContext context) => const AddItemScreen(),
        ),
      );
      _name.clear();
      _barcode.clear();
      _qty.clear();
      _averagePrice.clear();
      _salePrice.clear();
      _discount.clear();
    }
  }
}
