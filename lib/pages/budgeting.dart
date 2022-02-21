import 'package:amz_finance/models/budget.dart';
import 'package:amz_finance/services/auth.dart';
import 'package:amz_finance/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Budgeting extends StatefulWidget {
  const Budgeting({Key? key}) : super(key: key);

  @override
  _BudgetingState createState() => _BudgetingState();
}

class _BudgetingState extends State<Budgeting> {
  DatabaseService db = DatabaseService();

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
              'Budgeting',
              style: TextStyle(
                fontSize: 26,
                color: Colors.black,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Manage budget on each expense categories',
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
      body: StreamProvider<List<Budget>>.value(
          value: db.streamBudgets(AuthService().userId),
          initialData: [],
          builder: (context, child) {
            List<Budget> budgets = Provider.of<List<Budget>>(context);

            return Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  budgets.isEmpty
                      ? Expanded(
                          child: Center(
                            child: Text(
                              'You currently have no budget allocated. Click on the button below to allocate a new budget.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 10);
                      },
                      itemCount: budgets.length + 1,
                      itemBuilder: (context, index) {
                        if (index == budgets.length) {
                          return IconButton(
                              padding: EdgeInsets.all(0.0),
                              onPressed: () async {
                                dynamic result = await showDialog(
                                    context: context,
                                    builder: (context) => addBudget());

                                if (result != null) {
                                  Budget budget = Budget(
                                      name: result['name'],
                                      allocation:
                                          double.parse(result['amount']));

                                  await db.addBudget(
                                      budget, AuthService().userId);
                                }
                              },
                              icon: Icon(
                                Icons.add_circle_outline,
                                size: 50,
                              ));
                        } else {
                          Budget budget = budgets[index];
                          return InkWell(
                            onTap: () async {
                              dynamic result = await showDialog(
                                  context: context,
                                  builder: (context) => addBudget(
                                      name: budget.name!,
                                      amount: budget.allocation!.toString()));

                              if (result != null) {
                                budgets[index] = Budget(
                                    name: result['name'],
                                    allocation: double.parse(result['amount']));
                                await db.updateBudget(
                                    budgets, AuthService().userId);
                              }
                            },
                            child: Container(
                              height: 40,
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: Colors.black87,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      budgets[index].name!,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'RM${budget.allocation!.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  addBudget({String name = '', String amount = ''}) {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    TextEditingController _nameController = TextEditingController(text: name);
    TextEditingController _amountController =
        TextEditingController(text: amount);

    return Form(
      key: _formKey,
      child: AlertDialog(
        title: Text('Add Budget'),
        content: Container(
          height: 200,
          child: Column(
            children: [
              Text('Budget Name*'),
              TextFormField(
                controller: _nameController,
                validator: (value) =>
                    value!.isEmpty ? 'Name can\'t be empty' : null,
              ),
              SizedBox(height: 15),
              Text('Allocated Amount (RM)*'),
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Budget amount can\'t be empty' : null,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel')),
          TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.pop(context, {
                    'name': _nameController.text,
                    'amount': _amountController.text,
                  });
                }
              },
              child: Text('Done')),
        ],
      ),
    );
  }
}
