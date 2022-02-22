import 'package:amz_finance/models/bank.dart';
import 'package:amz_finance/models/expense.dart';
import 'package:amz_finance/services/auth.dart';
import 'package:amz_finance/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'categorize_expense.dart';

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
              'Transactions',
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
      body: StreamProvider<List<Expense>>.value(
          value: DatabaseService()
              .streamExpensesByBank(AuthService().userId, bank!.accountNumber!),
          initialData: const [],
          catchError: (_, __) => [],
          builder: (context, child) {
            List<Expense> expenses = Provider.of<List<Expense>>(context);

            return Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Current\nBalance',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 24),
                            ),
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
                            '${bank!.accountNumber} ${bank!.accountType} Account',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          )
                        ],
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(48, 48, 48, 1),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  height: 120,
                ),
                Container(
                  //alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 10),
                  height: 130,
                  color: Color.fromRGBO(223, 223, 223, 1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TransactionMethod(
                        asset: 'assets/images/money.png',
                        label: 'Instant Transfer',
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => addTransaction(context));
                        },
                      ),
                      TransactionMethod(
                        asset: 'assets/images/scan.png',
                        label: 'QR Pay',
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => addTransaction(context));
                        },
                      ),
                      TransactionMethod(
                        asset: 'assets/images/duitnow.png',
                        label: 'DuitNow',
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => addTransaction(context));
                        },
                      ),
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
                  height: 60,
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
                //SizedBox(height: 15),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      if (index == expenses.length) {
                        return SizedBox.shrink();
                      }
                      return Divider(
                        color: Colors.grey,
                        thickness: 2,
                        height: 2,
                      );
                    },
                    itemCount: expenses.length,
                    itemBuilder: (context, index) {
                      Expense expense = expenses[index];

                      return InkWell(
                        onTap: () => Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => Categorizing(expense))),
                        child: Container(
                          height: 60,
                          color: Colors.grey.shade400,
                          padding:
                              EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      expense.description!,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 3),
                                    Text(DateFormat('dd-MM-yyyy')
                                        .format(expense.timestamp!.toDate())),
                                  ],
                                ),
                              ),
                              Text(
                                '- RM${expense.amount!.toStringAsFixed(2)}',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            );
          }),
    );
  }

  Widget addTransaction(BuildContext context) {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    TextEditingController _descriptionController = TextEditingController();
    TextEditingController _amountController = TextEditingController();

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(
        'Add Transaction',
        style: TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      content: Form(
        key: _formKey,
        child: Container(
          height: 170,
          child: Column(
            children: [
              Divider(
                height: 2,
                thickness: 2,
              ),
              SizedBox(height: 5),
              Text('Amount'),
              SizedBox(height: 5),
              TextFormField(
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                controller: _amountController,
                validator: (value) =>
                    value!.isEmpty ? 'Amount can\'t be empty' : null,
              ),
              SizedBox(height: 10),
              Text('Description'),
              SizedBox(height: 5),
              TextFormField(
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                controller: _descriptionController,
                validator: (value) =>
                    value!.isEmpty ? 'Description can\'t be empty' : null,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context), child: Text('Cancel')),
        TextButton(
            onPressed: () async {
              Expense expense = Expense(
                account: bank!.accountNumber,
                amount: double.parse(_amountController.text),
                category: '',
                timestamp: Timestamp.now(),
                description: _descriptionController.text,
              );

              await DatabaseService()
                  .addTransaction(AuthService().userId, expense);
              Navigator.pop(context);
            },
            child: Text('Done')),
      ],
    );
  }
}

class TransactionMethod extends StatelessWidget {
  const TransactionMethod({
    Key? key,
    this.asset,
    this.label,
    this.onTap,
  }) : super(key: key);

  final String? asset;
  final String? label;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Image.asset(
              asset!,
              width: 50,
              scale: 5,
            ),
          ),
        ),
        SizedBox(height: 5),
        Text(label!, style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
