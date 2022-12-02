// import 'dart:io';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart';

// import '../providers/slip_provider.dart';
// import 'pdf_api.dart';

// class PdfInvoiceApi {
//   // ignore: always_specify_types
//   static Future<File> generate(SlipProvider slipPro, context) async {
//     final Document pdf = Document();

//     pdf.addPage(MultiPage(
//       pageFormat: PdfPageFormat.roll57,
//       // ignore: always_specify_types
//       build: (Context context) => [
//         buildPdf(slipPro),
//       ],
//     ));

//     return PdfApi.saveDocument(
//         name: 'Ramzan Hospital', pdf: pdf, context: context);
//   }

//   static Widget buildPdf(SlipProvider slipPro) {
//     return Column(children: <Widget>[
//       SizedBox(
//         height: 5 * PdfPageFormat.cm,
//         child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               buildHeader(slipPro),
//               patientData(slipPro),
//             ]),
//       ),
//       Divider(),
//       SizedBox(
//         height: 16 * PdfPageFormat.cm,
//         child: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[forTest(slipPro), Divider(), forDoctor()]),
//       ),
//       Divider(),
//       SizedBox(
//         height: 3 * PdfPageFormat.cm,
//         child: Column(children: <Widget>[
//           Row(children: <Widget>[
//             Text('Date ', style: TextStyle(fontWeight: FontWeight.bold)),
//             Text(TimeDateFunctions.currentTime().toString()),
//             Expanded(child: Container()),
//             Column(children: <Widget>[
//               SizedBox(height: 25),
//               Text(
//                 'Doctor Signature',
//               ),
//             ]),
//           ]),
//           RichText(
//             text: TextSpan(
//               text: 'Contect ',
//               style: const TextStyle(fontSize: 10),
//               children: <TextSpan>[
//                 TextSpan(
//                   text: '+92 345 102 1122',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
//                 ),
//               ],
//             ),
//           ),
//           RichText(
//             text: TextSpan(
//               text: 'Developed By ',
//               style: const TextStyle(fontSize: 10),
//               children: <TextSpan>[
//                 TextSpan(
//                   text: 'Dev Markaz',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
//                 ),
//               ],
//             ),
//           ),
//         ]),
//       ),
//     ]);
//   }

//   static Widget buildHeader(SlipProvider slipPro) {
//     return Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: <Widget>[
//           Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Text('Ramzan Hospital  ',
//                     style:
//                         TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//                 Text('Hospital Consulting Form ',
//                     style:
//                         TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                 Text(
//                   'Prescription slip ',
//                   style: const TextStyle(
//                     fontSize: 10,
//                   ),
//                 )
//               ]),
//           Container(
//             height: 50,
//             width: 50,
//             child: BarcodeWidget(
//               barcode: Barcode.qrCode(),
//               data: slipPro.patient!.patientID,
//             ),
//           ),
//         ]);
//   }

//   static Widget patientData(SlipProvider slipPro) {
//     return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: <Widget>[
//           Text(
//             ' ${slipPro.patient!.name.toString()}    ${TimeDateFunctions.totalAge(slipPro.patient?.dob ?? 0).toString()}',
//             style: TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Row(children: <Widget>[
//                   Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Text('Contact: '),
//                         Text('Address: '),
//                         Text('Gender: '),
//                       ]),
//                   SizedBox(width: 10),
//                   Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Text(slipPro.patient!.phoneNumber.toString()),
//                         Text(slipPro.patient!.address),
//                         Text(slipPro.patient!.gender),
//                       ]),
//                 ]),
//                 Row(children: <Widget>[
//                   Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Text('Date Time : '),
//                         Text('Consultant: '),
//                         Text('Department: '),
//                       ]),
//                   SizedBox(width: 10),
//                   Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Text(TimeDateFunctions.timeInDigits(
//                                 slipPro.patient?.timestamp ?? 0)
//                             .toString()),
//                         Text(slipPro.doctor!.name),
//                         Text(slipPro.department!.name),
//                       ]),
//                 ]),
//               ]),
//         ]);
//   }

//   static Widget forTest(SlipProvider slipPro) {
//     return SizedBox(
//       width: 7 * PdfPageFormat.cm,
//       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
//           Widget>[
//         Text('Tests',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//             )),
//         SizedBox(height: 20),
//         Column(
//             // ignore: always_specify_types
//             children: List.generate(slipPro.selectedTest.length, (int index) {
//           final String title = slipPro.selectedTest[index].test.name;

//           return buildText(title: title);
//         })),
//         SizedBox(height: 20),
//         Text('Investigation :', style: TextStyle(fontWeight: FontWeight.bold)),
//       ]),
//     );
//   }

//   static buildText({
//     required String title,
//     TextStyle? titleStyle,
//   }) {
//     return Container(
//       child: Row(
//         children: <Widget>[
//           Expanded(child: Text(title)),
//         ],
//       ),
//     );
//   }

//   static Widget forDoctor() {
//     return SizedBox(
//       width: 13 * PdfPageFormat.cm,
//       child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: <Widget>[
//             SizedBox(
//               height: 3 * PdfPageFormat.cm,
//               child: Text('Presenting Complaints:',
//                   style: const TextStyle(decoration: TextDecoration.underline)),
//             ),
//             SizedBox(
//               height: 3 * PdfPageFormat.cm,
//               child: Text('History:',
//                   style: const TextStyle(decoration: TextDecoration.underline)),
//             ),
//             SizedBox(
//               height: 3 * PdfPageFormat.cm,
//               child: Text('Examination:',
//                   style: const TextStyle(decoration: TextDecoration.underline)),
//             ),
//             SizedBox(
//               height: 1.5 * PdfPageFormat.cm,
//               child: Text('Provisional Dignosis:',
//                   style: const TextStyle(decoration: TextDecoration.underline)),
//             ),
//             Text('Treatment:',
//                 style: const TextStyle(decoration: TextDecoration.underline)),
//           ]),
//     );
//   }
// }
