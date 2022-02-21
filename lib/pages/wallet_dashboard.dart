import 'package:amz_finance/constant/constant.dart';
import 'package:amz_finance/models/bank.dart';
import 'package:amz_finance/pages/budgeting.dart';
import 'package:amz_finance/pages/view_wallet.dart';
import 'package:amz_finance/services/auth.dart';
import 'package:amz_finance/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WalletDashboard extends StatelessWidget {
  const WalletDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DatabaseService db = DatabaseService();
    final GlobalKey<ScaffoldState> _key = GlobalKey();

    return Scaffold(
      key: _key,
      appBar: AppBar(
        elevation: 0.0,
        toolbarHeight: 100,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'My Wallet',
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
              onPressed: () {
                _key.currentState!.openEndDrawer();
              },
              icon: Icon(
                Icons.menu,
                size: 40,
                color: Colors.black54,
              )),
          SizedBox(width: 20),
        ],
      ),
      endDrawer: Drawer(
        child: Container(
          padding: EdgeInsets.only(top: 50, left: 30, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Name',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        TextButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green),
                          ),
                          onPressed: () {},
                          child: Text(
                            'Edit Profile',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  CircleAvatar(
                    radius: 50,
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text(
                'Financials',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              ListTile(
                onTap: () => Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => Budgeting())),
                contentPadding: EdgeInsets.only(left: 10),
                title: Text(
                  'Manage budget',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                ),
                trailing: Icon(Icons.arrow_forward_ios_outlined),
              ),
              ListTile(
                onTap: () {},
                contentPadding: EdgeInsets.only(left: 10),
                title: Text(
                  'Overall expenses',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                ),
                trailing: Icon(Icons.arrow_forward_ios_outlined),
              ),
            ],
          ),
        ),
      ),
      body: StreamProvider<List<Bank>>.value(
          value: db.streamAccounts(AuthService().userId),
          initialData: const [],
          catchError: (_, __) => [],
          builder: (context, child) {
            List<Bank> banks = Provider.of<List<Bank>>(context);

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: ListView.separated(
                physics: ScrollPhysics(),
                separatorBuilder: (context, index) {
                  return index == banks.length
                      ? SizedBox.shrink()
                      : SizedBox(height: 15);
                },
                itemCount: banks.length + 1,
                itemBuilder: (context, index) {
                  if (index == banks.length) {
                    return IconButton(
                        onPressed: () {},
                        padding: EdgeInsets.all(0.0),
                        iconSize: 50,
                        alignment: Alignment.center,
                        icon: Icon(
                          Icons.add_circle_outline,
                          size: 50,
                        ));
                  } else {
                    Bank bank = banks[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          Constants.getBankName(bank.bank!),
                          style: TextStyle(fontSize: 24),
                        ),
                        SizedBox(height: 10),
                        InkWell(
                          onTap: () => Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => ViewWallet(bank))),
                          child: Card(
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
                                    bank.accountNumber!,
                                    style: TextStyle(fontSize: 22),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            );
          }),
    );
  }
}
