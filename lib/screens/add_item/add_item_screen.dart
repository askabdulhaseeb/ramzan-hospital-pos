import 'dart:developer';

import 'package:firedart/generated/google/protobuf/timestamp.pb.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../database/item_api/item_api.dart';
import '../../function/time_date_function.dart';
import '../../models/item/item.dart';
import '../../providers/item/item_category_provider.dart';
import '../../providers/item/item_formula_provider.dart';
import '../../providers/item/item_manufacturer_provider.dart';
import '../../providers/item/item_provider.dart';
import '../../providers/item/item_supplier_provider.dart';
import '../../utilities/custom_validator.dart';
import '../../widgets/custom_widgets/custom_board_widget.dart';
import '../../widgets/custom_widgets/custom_title_textformfield.dart';
import '../../widgets/custom_widgets/icon_button.dart';
import '../../widgets/item/add_item/search_item.dart';
import '../../widgets/item/add_item/update_item.dart';
import '../../widgets/item/dropdowns/item_dropdowns.dart';
import '../sale_screen/sale_screen.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({Key? key}) : super(key: key);
  static const String routeName = '/add-product';

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final TextEditingController _barcode = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _qty = TextEditingController(text: '0');
  final TextEditingController _averagePrice = TextEditingController(text: '0');
  final TextEditingController _salePrice = TextEditingController(text: '0');
  final TextEditingController _discount = TextEditingController(text: '0');
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ItemProvider itemPro = Provider.of<ItemProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('AddItemScreen')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              children: <Widget>[
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
                              const LineItemDropdown(),
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
                      title: 'Add',
                      icon: Icons.add,
                      onTap: () async => await addItem(context),
                    ),
                    const SizedBox(width: 20),
                    CustomIconButton(
                      title: 'Edit',
                      icon: Icons.edit,
                      bgColor: Colors.greenAccent,
                      onTap: () async{
                        await itemPro.load();
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                          context,
                          // ignore: always_specify_types
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const UpdateItemScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 20),
                    CustomIconButton(
                      title: 'Remove',
                      icon: Icons.remove,
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      bgColor: Colors.red,
                      onTap: () {},
                    ),
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
          builder: (BuildContext context) => const SaleScreen(),
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
