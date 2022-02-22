import 'package:amz_finance/models/category_expense.dart';
import 'package:amz_finance/models/expense.dart';
import 'package:amz_finance/services/auth.dart';
import 'package:amz_finance/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

class ExpenseByCategory extends StatefulWidget {
  const ExpenseByCategory(this.categoryExpense, {Key? key}) : super(key: key);

  final CategoryExpense categoryExpense;

  @override
  State<ExpenseByCategory> createState() => _ExpenseByCategoryState();
}

class _ExpenseByCategoryState extends State<ExpenseByCategory> {
  @override
  Widget build(BuildContext context) {
    List<_ChartData> data = [
      _ChartData('Spent', widget.categoryExpense.spent!),
      _ChartData('Budget',
          widget.categoryExpense.budget! - widget.categoryExpense.spent!),
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        toolbarHeight: 100,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new_sharp,
            size: 40,
            color: Colors.black54,
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.categoryExpense.category!,
              style: TextStyle(
                fontSize: 26,
                color: Colors.black,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Manage your financials',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder(
          future: DatabaseService().getExpenses(
              AuthService().userId, widget.categoryExpense.category!),
          builder: (context, AsyncSnapshot<List<Expense>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SpinKitThreeInOut(
                color: Colors.purple,
              );
            } else {
              List<Expense>? expenses = snapshot.data;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Allocated Amount',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          'RM${widget.categoryExpense.budget!.toStringAsFixed(2)}',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.black87,
                    ),
                    child: Text(
                      'Spent Items',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) =>
                          Divider(thickness: 3),
                      itemCount: expenses!.length,
                      itemBuilder: (context, index) {
                        Expense expense = expenses[index];

                        return Container(
                          height: 65,
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(expense.description!,
                                        style: TextStyle(fontSize: 20)),
                                    SizedBox(height: 3),
                                    Text(
                                        DateFormat('dd-MM-yyyy').format(
                                            expense.timestamp!.toDate()),
                                        style: TextStyle(fontSize: 14)),
                                  ],
                                ),
                              ),
                              Text('- RM${expense.amount!.toStringAsFixed(2)}',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red)),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    height: 60,
                    alignment: Alignment.center,
                    color: Colors.black87,
                    child: Text(
                      'Total spent: RM${getTotalSpent(expenses).toStringAsFixed(2)}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              );
            }
          }),
    );
  }

  double getTotalSpent(List<Expense> expenses) {
    double totalamount = 0;
    for (var expense in expenses) {
      totalamount += expense.amount!;
    }
    return totalamount;
  }
}

class _ChartData {
  String uses;
  double amount;

  _ChartData(this.uses, this.amount);
}
