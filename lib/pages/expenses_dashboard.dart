import 'package:amz_finance/models/category_expense.dart';
import 'package:amz_finance/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ExpensesDashboard extends StatefulWidget {
  const ExpensesDashboard({Key? key}) : super(key: key);

  @override
  _ExpensesDashboardState createState() => _ExpensesDashboardState();
}

class _ExpensesDashboardState extends State<ExpensesDashboard> {
  List<String> filter = [
    'weekly',
    'monthly',
  ];
  String _selectedFilter = '';
  List<Expense> expenses = [
    Expense(category: 'Food', amount: 200),
    Expense(category: 'Transport', amount: 150),
    Expense(category: 'Bill', amount: 300),
    Expense(category: 'Food', amount: 50),
  ];

  List<CategoryExpense> expenseCategory = [
    CategoryExpense(category: 'Food', budget: 300),
    CategoryExpense(category: 'Bill', budget: 500),
    CategoryExpense(category: 'Transport', budget: 100),
  ];

  getCategoryExpenses() {
    for (var item in expenseCategory) {
      item.spent = 0.0;
      for (var expense in expenses) {
        if (item.category == expense.category) {
          print('Spent: ${item.spent}');
          item.spent = item.spent! + expense.amount!;
          item.budget = item.budget! - expense.amount!;
        }
      }
    }
  }

  @override
  void initState() {
    _selectedFilter = filter.first;
    getCategoryExpenses();
    super.initState();
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
              'Expenses',
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
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField(
              value: _selectedFilter,
              items: [
                ...filter.map((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text(getFilterText(e)),
                  );
                }).toList()
              ],
              onChanged: (value) {
                setState(() {
                  _selectedFilter = value.toString();
                });
              },
            ),
            SizedBox(height: 10),
            SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              legend: Legend(isVisible: true, position: LegendPosition.bottom),
              series: <ChartSeries<CategoryExpense, String>>[
                StackedColumnSeries(
                    dataSource: expenseCategory,
                    xValueMapper: (CategoryExpense expense, _) =>
                        expense.category,
                    yValueMapper: (CategoryExpense expense, _) => expense.spent,
                    name: 'Expenses',
                    dataLabelSettings: DataLabelSettings(isVisible: true)),
                StackedColumnSeries(
                    dataSource: expenseCategory,
                    xValueMapper: (CategoryExpense expense, _) =>
                        expense.category,
                    yValueMapper: (CategoryExpense expense, _) =>
                        expense.budget,
                    name: 'Budgets',
                    dataLabelSettings: DataLabelSettings(isVisible: true))
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Overview',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(height: 10),
                itemCount: expenseCategory.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {},
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
                              expenseCategory[index].category!,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getFilterText(String e) {
    if (e == 'weekly') {
      return 'Last 7 days';
    } else {
      return 'Monthly';
    }
  }
}
