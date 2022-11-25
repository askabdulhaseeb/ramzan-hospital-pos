import 'package:flutter/material.dart';

class CustomDataTable extends StatelessWidget {
  const CustomDataTable({super.key});

  @override
  Widget build(BuildContext context) {
    // return Row(
    //   mainAxisAlignment: MainAxisAlignment.start,
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: <Widget>[
    //     FittedBox(
    //       child: DataTable(
    //           headingTextStyle: const TextStyle(color: Colors.black38),
    //           dividerThickness: 1,
    //           headingRowColor: MaterialStateProperty.resolveWith(
    //               (Set<MaterialState> states) => const Color(0xffadbcca)),
    //           columns: const <DataColumn>[
    //             DataColumn(label: Text('sr no')),
    //             DataColumn(label: Text('Product code')),
    //             DataColumn(label: Text('Product name')),
    //             DataColumn(label: Text('Batch no')),
    //             DataColumn(label: Text('Rate')),
    //             DataColumn(label: Text('Qty')),
    //             DataColumn(label: Text('Amount')),
    //             DataColumn(label: Text('Discount')),
    //             DataColumn(label: Expanded(child: Text('Total'))),
    //             DataColumn(label: Expanded(child: Text('Delete'))),
    //           ],
    //           rows: <DataRow>[
    //             DataRow(
    //               cells: <DataCell>[
    //                 const DataCell(Text('1')),
    //                 const DataCell(Text('132')),
    //                 const DataCell(Text('panadol')),
    //                 const DataCell(Text('132')),
    //                 const DataCell(Text('70')),
    //                 const DataCell(Text('4')),
    //                 const DataCell(Text('280')),
    //                 const DataCell(Text('10')),
    //                 const DataCell(Text('270')),
    //                 DataCell(Icon(
    //                   Icons.delete,
    //                   color: Colors.red[300],
    //                 )),
    //               ],
    //             )
    //           ]),
    //     ),
    //   ],
    // );
    return Scaffold(
        body: Container(
      // ignore: always_specify_types
      child: Table(columnWidths: const {
        0: FractionColumnWidth(.1)
      }, children: <TableRow>[
        TableRow(children: [
          upperBar('Sr.no'),
          upperBar('Product code'),
          upperBar('Product name'),
          upperBar('Batch no'),
          upperBar('Rate'),
          upperBar('Qty'),
          upperBar('Amount'),
          upperBar('Discount'),
          upperBar('total'),
          upperBar('Delete'),
        ]),
      ]),
    ));
  }

  Widget upperBar(String text) {
    return Container(
      color: const Color(0xffa3c1c6),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
