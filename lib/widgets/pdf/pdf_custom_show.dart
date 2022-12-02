import 'package:flutter/material.dart';

class PdfCustomShow extends StatelessWidget {
  const PdfCustomShow({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 342,
          child: Column(
            children: [
              upperWidget(),
              customerDetail(),
              datatable(),
              total(),
              lowerWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget upperWidget() {
    return Container(
      height: 90,
      width: 342,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
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

  Widget customerDetail() {
    return Container(
      height: 70,
      width: 342,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(children: <Widget>[
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const <Widget>[
                          Text('Inv no: '),
                          Text('M/S: '),
                        ]),
                    const SizedBox(width: 10),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const <Widget>[
                          Text('5'),
                          Text('counter sale'),
                        ]),
                  ]),
                  Row(children: <Widget>[
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const <Widget>[
                          Text('Date : '),
                          Text('time: '),
                        ]),
                    const SizedBox(width: 10),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const <Widget>[
                          Text('03/9/2020'),
                          Text('6:12'),
                        ]),
                  ]),
                ]),
          ]),
    );
  }

  Widget datatable() {
    return Container(
      height: 190,
      width: 342,
      color: Colors.orange,
    );
  }

  Widget total() {
    return Container(
      height: 90,
      width: 342,
      color: Colors.black,
    );
  }

  Widget lowerWidget() {
    return Container(
      height: 90,
      width: 342,
      color: Colors.orange,
    );
  }
}
