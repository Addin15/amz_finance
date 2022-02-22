import 'package:amz_finance/models/budget.dart';
import 'package:amz_finance/models/expense.dart';
import 'package:amz_finance/services/auth.dart';
import 'package:amz_finance/services/database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Categorizing extends StatefulWidget {
  const Categorizing(this.expense, {Key? key}) : super(key: key);

  final Expense expense;

  @override
  State<Categorizing> createState() => _CategorizingState();
}

class _CategorizingState extends State<Categorizing> {
  DatabaseService db = DatabaseService();

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
          children: const [
            Text(
              'Categorise',
              style: TextStyle(
                fontSize: 26,
                color: Colors.black,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Pick a category under your available expenses.',
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.expense.description!,
                        style: TextStyle(fontSize: 24),
                      ),
                      Text(
                        DateFormat('dd-MM-yyyy')
                            .format(widget.expense.timestamp!.toDate()),
                      ),
                    ],
                  ),
                ),
                Text(
                  'RM${widget.expense.amount!.toStringAsFixed(2)}',
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.red,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            StreamProvider<List<Budget>>.value(
              value: db.streamBudgets(AuthService().userId),
              initialData: const [],
              catchError: (_, __) => [],
              builder: (context, child) {
                List<Budget> budgets = Provider.of<List<Budget>>(context);

                return Expanded(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Text(
                        budgets.isEmpty
                            ? 'No available ategories'
                            : 'Available categories',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      budgets.isEmpty
                          ? SizedBox.shrink()
                          : Expanded(
                              child: ListView.separated(
                                separatorBuilder: (context, index) =>
                                    SizedBox(height: 10),
                                itemCount: budgets.length,
                                itemBuilder: (context, index) {
                                  Budget budget = budgets[index];

                                  return InkWell(
                                    onTap: () async {
                                      bool result = await db.categorizeExpense(
                                          AuthService().userId,
                                          widget.expense.id!,
                                          budget.name!);

                                      if (result) {
                                        setState(() {
                                          widget.expense.category = budget.name;
                                        });
                                      }
                                    },
                                    child: Container(
                                      height: 50,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: Colors.black87,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: Text(
                                            budget.name!,
                                            style: TextStyle(
                                              fontSize: 24,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          )),
                                          (widget.expense.category !=
                                                  budget.name)
                                              ? SizedBox.shrink()
                                              : Icon(
                                                  Icons.done,
                                                  color: Colors.white,
                                                ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                      Text(
                        'If you wish to add a new category, go to the budget menu.',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
