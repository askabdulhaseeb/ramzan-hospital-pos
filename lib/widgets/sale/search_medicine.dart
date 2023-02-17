import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/item/item.dart';
import '../../models/patient.dart';
import '../../providers/cart_provider.dart';
import '../../providers/item/item_provider.dart';
import '../../providers/patient_provider.dart';
import 'add_patient.dart';

class SearchMedicine extends StatelessWidget {
  const SearchMedicine({required this.quantity, super.key});
  final String quantity;
  @override
  Widget build(BuildContext context) {
    ItemProvider itemPro = Provider.of<ItemProvider>(context);
    CartProvider cartPro = Provider.of<CartProvider>(context);
    final List<Item> items = itemPro.itemSearch();

    return Column(children: <Widget>[
      const SizedBox(height: 30),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Container(
          height: 40,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            color: Theme.of(context).cardColor,
          ),
          child: const Center(
              child: Text('Search Medicine with Barcode or name or Price')),
        ),
      ),
      const SizedBox(height: 30),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color:
                        const Color.fromARGB(255, 66, 66, 66).withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: TextField(
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search...'),
                onChanged: (String val) => itemPro.onSearch(val),
              ),
            ),
            SearchItems(itemPro)
            // Row(
            //   children: [
            //     searchItems(text: 'name'),
            //     searchItems(text: 'name'),
            //     searchItems(text: 'name'),
            //   ],
            // ),
          ],
        ),
      ),
      const SizedBox(height: 15),
      const SizedBox(height: 20),
      itemPro.items.isEmpty
          ? const Center(
              child: Text('NO Medicine'),
            )
          : SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) {
                    String quan = itemPro.maxQuantity(quantity, items[index]);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: ListTile(
                          onTap: () {
                            // patPro.selectPatient(patient[index]);
                            cartPro.addtocart(items[index], int.parse(quan));
                            Navigator.of(context).pop();
                          },
                          title: Text(
                            items[index].name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          trailing: Text(
                            items[index].salePrice.toString(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            items[index].code,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    );
                  }),
            )
    ]);
  }

  Widget SearchItems(ItemProvider itemPro) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: itemPro.searchingItems.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: GestureDetector(
              onTap: () {
                itemPro.updateSelectSearch(itemPro.searchingItems[index]);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  // border: Border.all(color: Colors.green),
                  borderRadius: BorderRadius.circular(4),

                  color: (itemPro.searchingItems[index] == itemPro.selectSearch)
                      ? Colors.green
                      : Colors.white,
                ),

                //   color: Colors.green,
                //alignment: Alignment.center,
                child: Center(
                    child: Text(
                  itemPro.searchingItems[index],
                  style: TextStyle(
                      color: (itemPro.searchingItems[index] ==
                              itemPro.selectSearch)
                          ? Colors.white
                          : Colors.black),
                )),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget searchItems({required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.green),
            borderRadius: BorderRadius.circular(4)),
        //alignment: Alignment.center,
        child: Center(child: Text(text)),
      ),
    );
  }
}
