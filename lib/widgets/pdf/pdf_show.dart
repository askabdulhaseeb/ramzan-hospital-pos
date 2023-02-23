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

    pdf.addPage(Page(
      pageFormat: PdfPageFormat.roll80,
      // ignore: always_specify_types
      build: (Context context) => buildPdf(slipPro, itemPro),
    ));
    return PdfApi.saveDocument(
        name: 'Ramzan Hospital', pdf: pdf, context: context);
  }

  static Widget buildPdf(SlipProvider slipPro, ItemProvider itemPro) {
    return Column(children: <Widget>[
      SizedBox(
        height: 30 * PdfPageFormat.mm,
        width: PdfPageFormat.roll80.width,
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
        width: PdfPageFormat.roll80.width,
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
                  medicines(25 * PdfPageFormat.mm, medicineName!),
                  medicines(15 * PdfPageFormat.mm, netTotal.toString()),
                  medicines(10 * PdfPageFormat.mm, discount.toString()),
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
      width: PdfPageFormat.roll80.width - 10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                child: Text('Total Item : ${slipPro.slip.test.length}'),
              ),
              SizedBox(
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
      width: PdfPageFormat.roll80.width,
      child: Column(children: <Widget>[
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
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: PdfPageFormat.roll80.width - 10,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Inv no: ${slipPro.slip.slipID.substring(0, 5)}'),
                  Text('   M/S:  counter sale'),
                ]),
          ),
          SizedBox(
            width: PdfPageFormat.roll80.width - 10,
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
