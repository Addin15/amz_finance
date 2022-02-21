import 'package:flutter/material.dart';

class Categorizing extends StatelessWidget {
  createAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Successfully Categorised'),
            content: Image.asset(
              'assets/images/correct.png',
              height: 40,
              width: 40,
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final expenses = ['- RM16.00', '- RM17.00', '- RM19.00', '- RM15.00'];
    final description = ['Dutch Lady', 'Plastic Cups', 'Fine Sugar', 'Straws'];
    final date = ['2/1/2022', '13/1/2022', '15/1/2022', '20/2/2022'];
    final budgets = ['Raw Materials', 'Branding', 'Utensils', 'Tools'];
    return MaterialApp(
      title: 'AMZ Finance ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text(
              'Categorise',
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Color.fromRGBO(229, 229, 229, 1),
          ),
          body: Column(
            children: [
              Row(
                children: [
                  Container(
                      padding: EdgeInsets.fromLTRB(8, 20, 8, 0),
                      child: Text(
                        description[1],
                        style: TextStyle(fontSize: 24),
                      )),
                  SizedBox(width: 75),
                  Container(
                      padding: EdgeInsets.fromLTRB(8, 20, 8, 0),
                      child: Text(
                        expenses[1],
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              ),
              Row(
                children: [
                  Container(
                      padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
                      child: Text(
                        date[1],
                      ))
                ],
              ),
              Row(
                children: [
                  Container(
                      child: Text(
                        'Available Categories',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      padding: EdgeInsets.fromLTRB(8, 20, 8, 0))
                ],
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      createAlertDialog(context);
                    },
                    child: Container(
                        height: 350,
                        child: ListView.builder(
                          itemCount: expenses.length,
                          itemBuilder: (context, index) {
                            return Container(
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                child: new Container(
                                  padding: EdgeInsets.fromLTRB(5, 5, 7, 5),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 240,
                                                  child: Text(
                                                    budgets[index],
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 40,
                                                ),
                                                Image.asset(
                                                  'assets/images/arrow.png',
                                                  width: 45,
                                                  height: 45,
                                                ),
                                              ],
                                            ),
                                            padding: EdgeInsets.fromLTRB(
                                                10, 15, 10, 8),
                                            decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    48, 48, 48, 1),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0))),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ));
                          },
                        )),
                  ),
                  Text(
                    'If you wish to add a new category, go to the budget menu.',
                    style: TextStyle(fontSize: 12),
                  )
                ],
              )
            ],
          )),
    );
  }
}
