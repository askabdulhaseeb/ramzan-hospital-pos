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
    return SizedBox(
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
    return SizedBox(
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
    return SizedBox(
      height: 90,
      width: 342,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Text('Total Item :15'),
              Spacer(),
              Text('Total: '),
              SizedBox(
                width: 40,
                child: Text(
                  '500',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: const [
            Text('Discount: '),
            SizedBox(
              width: 40,
              child: Text(
                '300',
              ),
            ),
          ]),
          const SizedBox(
            height: 10,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: const [
            Text('Total: '),
            SizedBox(
              width: 40,
              child: Text(
                '200',
              ),
            ),
          ]),
        ],
      ),
    );
  }

  Widget lowerWidget() {
    return SizedBox(
      height: 90,
      width: 342,
      child: Column(
        children: const <Widget>[
          Text(
            'Return policy',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            'Return policy Return policy Return policy Return policy Return policy Return policy',
          ),
        ],
      ),
    );
  }
}
