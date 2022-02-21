import 'package:flutter/material.dart';

class ViewWallet extends StatelessWidget {
  const ViewWallet({Key? key}) : super(key: key);

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
              'CIMB',
              style: TextStyle(
                fontSize: 26,
                color: Colors.black,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Click on a card to manage financials',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.menu,
                size: 40,
                color: Colors.black54,
              )),
          SizedBox(width: 20),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: Colors.red,
              elevation: 10.0,
              child: Container(
                height: 180,
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 25,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 50),
                    Container(
                      height: 40,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.yellow,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      '1226 7128 8128 0192',
                      style: TextStyle(fontSize: 22),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Manage account',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black87),
              child: Column(
                children: [
                  Text(
                    'Current Balance',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'RM1500.00',
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ManageContainer(
                  onTap: () {},
                  label: 'Transactions',
                ),
                ManageContainer(
                  onTap: () {},
                  label: 'Budgeting',
                ),
                ManageContainer(
                  onTap: () {},
                  label: 'Expenses',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ManageContainer extends StatelessWidget {
  const ManageContainer({
    Key? key,
    required this.onTap,
    required this.label,
  }) : super(key: key);

  final Function() onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(height: 3),
          Text(
            label,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
