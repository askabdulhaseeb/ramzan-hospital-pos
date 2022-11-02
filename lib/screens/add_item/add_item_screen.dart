import 'package:flutter/material.dart';

import '../../widgets/custom_widgets/custom_board_widget.dart';
import '../../widgets/custom_widgets/custom_title_textformfield.dart';
import '../../widgets/custom_widgets/icon_button.dart';
import '../../widgets/item/dropdowns/item_dropdowns.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({Key? key}) : super(key: key);
  static const String routeName = '/add-product';

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final TextEditingController _barcode = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _qty = TextEditingController();
  final TextEditingController _averagePrice = TextEditingController();
  final TextEditingController _salePrice = TextEditingController();
  final TextEditingController _discount = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AddItemScreen')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
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
                            ),
                            CustomTitleTextFormField(
                              controller: _averagePrice,
                              title: 'Average Price',
                            ),
                            CustomTitleTextFormField(
                              controller: _salePrice,
                              title: 'Sale Price',
                            ),
                            CustomTitleTextFormField(
                              controller: _discount,
                              title: 'Discount',
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
                    onTap: () {},
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
    );
  }
}
