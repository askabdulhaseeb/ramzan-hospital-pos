import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import '../../function/time_date_function.dart';
import '../../providers/item/item_provider.dart';
import '../../providers/slip_provider.dart';

import 'pdf_api.dart';

class PdfInvoiceApi {
  // ignore: always_specify_types
  static Future<File> generate(
      SlipProvider slipPro, ItemProvider itemPro, context) async {
    final Document pdf = Document();

    pdf.addPage(MultiPage(
      // pageFormat: PdfPageFormat.roll57,
      // ignore: always_specify_types
      build: (Context context) => [
        buildPdf(slipPro, itemPro),
      ],
    ));
    return PdfApi.saveDocument(
        name: 'Ramzan Hospital', pdf: pdf, context: context);
  }

  static Widget buildPdf(SlipProvider slipPro, ItemProvider itemPro) {
    return Column(children: <Widget>[
      SizedBox(
        height: 30 * PdfPageFormat.mm,
        width: 80 * PdfPageFormat.mm,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              buildHeader(slipPro),
              patientData(slipPro),
            ]),
      ),
      Divider(),
      forTest(slipPro, itemPro),
      Divider(),
      totalBill(slipPro),
      Divider(),
      bottomWidget(),
    ]);
  }

  static Widget forTest(SlipProvider slipPro, ItemProvider itemPro) {
    return SizedBox(
        width: 80 * PdfPageFormat.mm,
        child: ListView.builder(
          itemCount: slipPro.slip.test.length,
          itemBuilder: (Context context, int index) {
            String? medicineName =
                itemPro.itemName(slipPro.slip.test[index].itemID);
            int quantity = slipPro.slip.test[index].quantity;
            double netTotal = slipPro.slip.test[index].price;
            double discount = slipPro.slip.test[index].discount;
            double toal = slipPro.slip.test[index].price -
                slipPro.slip.test[index].discount;

            return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  medicines(10 * PdfPageFormat.mm, quantity.toString()),
                  medicines(25 * PdfPageFormat.mm, medicineName!),
                  medicines(15 * PdfPageFormat.mm, netTotal.toString()),
                  medicines(15 * PdfPageFormat.mm, discount.toString()),
                  medicines(15 * PdfPageFormat.mm, toal.toString()),
                ]);
          },
        ));
  }

  static SizedBox medicines(double width, String text) {
    return SizedBox(width: width, child: Text(text));
  }

  static SizedBox totalBill(SlipProvider slipPro) {
    return SizedBox(
      height: 30 * PdfPageFormat.mm,
      width: 80 * PdfPageFormat.mm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(
                width: 40 * PdfPageFormat.mm,
                child: Text('Total Item : ${slipPro.slip.test.length}'),
              ),
              SizedBox(
                  width: 40 * PdfPageFormat.mm,
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Text(
                        'Net Total: ${slipPro.slip.totalbill + slipPro.slip.adjustment}'),
                  ])),
            ],
          ),
          Text('Discount: ${slipPro.slip.customerDiscount}'),
          Text(
              'Total: ${slipPro.slip.totalbill + slipPro.slip.adjustment - slipPro.slip.customerDiscount}'),
        ],
      ),
    );
  }

  static SizedBox bottomWidget() {
    return SizedBox(
      //height: 15 * PdfPageFormat.mm,
      width: 80 * PdfPageFormat.mm,
      child: Column(children: <Widget>[
        SizedBox(
          child: Column(
            children: <Widget>[
              Text(
                'Return policy',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Return policy Return policy ',
                style: TextStyle(fontSize: 10),
              ),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            text: 'Contect ',
            style: const TextStyle(fontSize: 10),
            children: <TextSpan>[
              TextSpan(
                text: '+92 345 102 1122',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
              ),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            text: 'Developed By ',
            style: const TextStyle(fontSize: 10),
            children: <TextSpan>[
              TextSpan(
                text: 'Dev Markaz',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  static Widget buildHeader(SlipProvider slipPro) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Ramzan Hospital',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
          Text(
            'innovaice',
          ),
        ],
      ),
    );
  }

  static Widget patientData(SlipProvider slipPro) {
    // return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
    //   Text('usman'),
    //   Text('usman'),
    // ]);
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            width: 50 * PdfPageFormat.mm,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Inv no: ${slipPro.slip.slipID.substring(0, 5)}'),
                  Text('   M/S:  counter sale'),
                ]),
          ),
          SizedBox(
            width: 30 * PdfPageFormat.mm,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                      'Date : ${TimeStamp.timeindays(slipPro.slip.timestamp ?? 0)}'),
                  Text(
                      'time: ${TimeStamp.timeInDigits(slipPro.slip.timestamp ?? 0)}'),
                ]),
          )
        ]);
  }
}
