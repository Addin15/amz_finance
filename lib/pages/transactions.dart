import 'package:amz_finance/models/bank.dart';
import 'package:flutter/material.dart';
import 'categorizing.dart';

class Transactions extends StatelessWidget {
  const Transactions(this.bank, {Key? key}) : super(key: key);

  final Bank? bank;

  @override
  Widget build(BuildContext context) {
    final expenses = ['- RM16.00', '- RM17.00', '- RM19.00', '- RM15.00'];
    final description = ['Dutch Lady', 'Plastic Cups', 'Fine Sugar', 'Straws'];
    final date = ['2/1/2022', '13/1/2022', '15/1/2022', '20/2/2022'];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Transactions',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color.fromRGBO(229, 229, 229, 1),
      ),
      body: Column(
        children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'Current\nBalance',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Text(
                      'RM${bank!.balance!.toStringAsFixed(2)}',
                      style: TextStyle(color: Colors.white, fontSize: 36),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '7018435621 Business Account',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )
                  ],
                ),
              ],
            ),
            padding: EdgeInsets.fromLTRB(10, 15, 10, 8),
            decoration: BoxDecoration(
                color: Color.fromRGBO(48, 48, 48, 1),
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            height: 115,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            decoration: BoxDecoration(
              color: Color.fromRGBO(223, 223, 223, 1),
            ),
            height: 115,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(255, 255, 255, 1)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/money.png',
                            scale: 5,
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Transfer',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(255, 255, 255, 1)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/scan.png',
                            scale: 5,
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'QR Pay',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(255, 255, 255, 1)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/duitnow.png',
                              width: 50,
                              scale: 5,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'DuitNow',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        )
                      ],
                    )),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            decoration: BoxDecoration(
              color: Color.fromRGBO(74, 74, 74, 1),
            ),
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Transactions',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Categorizing(),
                ),
              );
            },
            child: Container(
                height: 200,
                child: ListView.builder(
                  itemCount: expenses.length,
                  itemBuilder: (context, index) {
                    return Container(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(223, 223, 223, 1)),
                          padding: EdgeInsets.fromLTRB(5, 5, 7, 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 140,
                                    child: Text(description[index],
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 24,
                                        )),
                                  ),
                                  SizedBox(width: 90),
                                  Text(
                                    expenses[index],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              Row(
                                children: [Text(date[index])],
                              )
                            ],
                          ),
                        ));
                  },
                )),
          )
        ],
      ),
    );
  }
}
