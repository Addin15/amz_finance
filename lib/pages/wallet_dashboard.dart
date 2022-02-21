import 'package:amz_finance/pages/view_wallet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WalletDashboard extends StatelessWidget {
  const WalletDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              onPressed: () {},
              icon: Icon(
                Icons.menu,
                size: 40,
                color: Colors.black54,
              )),
          SizedBox(width: 20),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Expanded(
          child: ListView.separated(
            physics: ScrollPhysics(),
            separatorBuilder: (context, index) {
              return index == 4 ? SizedBox.shrink() : SizedBox(height: 15);
            },
            itemCount: 4,
            itemBuilder: (context, index) {
              if (index == 3) {
                return IconButton(
                    onPressed: () {},
                    padding: EdgeInsets.all(0.0),
                    iconSize: 50,
                    alignment: Alignment.center,
                    icon: Icon(
                      Icons.add_circle_outline,
                      size: 50,
                    ));
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    ' CIMB',
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 10),
                  InkWell(
                    onTap: () => Navigator.push(context,
                        CupertinoPageRoute(builder: (context) => ViewWallet())),
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
                              '1226 7128 8128 0192',
                              style: TextStyle(fontSize: 22),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
