import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/item/item_provider.dart';
import '../../providers/sale_provider.dart';
import '../../providers/user_provider.dart';
import '../../utilities/custom_validator.dart';
import '../../widgets/custom_widgets/title_textformfield.dart';

class SaleScreen extends StatelessWidget {
  const SaleScreen({Key? key}) : super(key: key);
  static const String routeName = '/sale-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sale Screen')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 160,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color:
                                  Theme.of(context).textTheme.bodySmall!.color!,
                            ),
                          ),
                          child: Text(
                            'Ranzan Hospital',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Consumer3<UserProvider, ItemProvider, SaleProvider>(
                            builder: (
                          BuildContext context,
                          UserProvider userPro,
                          ItemProvider itemPro,
                          SaleProvider salePro,
                          _,
                        ) {
                          return Row(
                            children: <Widget>[
                              const Text('salesman'),
                              const SizedBox(width: 10),
                              TitleTextFormField(
                                controller: salePro.defaultQuantity,
                                title: 'Qty',
                                width: 100,
                                validator: (String? value) =>
                                    CustomValidator.isEmpty(value),
                              ),
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
                  Expanded(child: Container(color: Colors.amber)),
                  const SaleButtonSide(),
                ],
              ),
            ),
            const SaleTotalSide()
          ],
        ),
      ),
    );
  }
}

class SaleButtonSide extends StatelessWidget {
  const SaleButtonSide({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: double.infinity,
      color: Colors.blue,
    );
  }
}

class SaleTotalSide extends StatelessWidget {
  const SaleTotalSide({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: 300,
      color: Colors.black,
    );
  }
}
