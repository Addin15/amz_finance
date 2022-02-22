import 'package:amz_finance/constant/constant.dart';
import 'package:amz_finance/models/bank.dart';
import 'package:amz_finance/services/auth.dart';
import 'package:amz_finance/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AddBank extends StatefulWidget {
  const AddBank({Key? key}) : super(key: key);

  @override
  State<AddBank> createState() => _AddBankState();
}

class _AddBankState extends State<AddBank> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _accountNumberController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  String _selectedType = '';
  String _selectedBank = '';
  bool _isSubmitting = false;

  List<String> types = ['Personal Account', 'Business Account'];
  List<String> bank = ['maybank', 'cimb', 'bsn', 'bi'];

  @override
  void initState() {
    _selectedType = types.first;
    _selectedBank = bank.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        toolbarHeight: 100,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back,
              size: 30,
              color: Colors.black54,
            )),
        title: Text(
          'Add Bank',
          style: TextStyle(
            fontSize: 26,
            color: Colors.black,
            fontWeight: FontWeight.w800,
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () async {
                setState(() {
                  _isSubmitting = true;
                });

                if (_formKey.currentState!.validate()) {
                  Bank bank = Bank(
                      bank: _selectedBank,
                      accountNumber: _accountNumberController.text,
                      accountType: _selectedType,
                      balance: double.parse(_amountController.text));

                  bool res = await DatabaseService()
                      .addBank(bank, AuthService().userId);
                  print(res);
                } else {
                  setState(() {
                    _isSubmitting = false;
                  });
                }

                Navigator.pop(context);
              },
              icon: Icon(
                Icons.done,
                size: 30,
                color: Colors.black54,
              )),
        ],
      ),
      body: _isSubmitting
          ? Container(
              color: Colors.white.withAlpha(80),
              child: SpinKitThreeInOut(
                color: Colors.purple,
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Account Number'),
                    SizedBox(height: 5),
                    TextFormField(
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      controller: _accountNumberController,
                      validator: (value) => value!.isEmpty
                          ? 'Account number can\'t be empty'
                          : null,
                    ),
                    SizedBox(height: 20),
                    Text('Bank'),
                    SizedBox(height: 5),
                    DropdownButtonFormField(
                      value: _selectedType,
                      items: [
                        ...types.map((item) {
                          return DropdownMenuItem(
                              value: item, child: Text(item));
                        }).toList(),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedType = value.toString();
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    Text('Account Type'),
                    SizedBox(height: 5),
                    DropdownButtonFormField(
                      value: _selectedBank,
                      items: [
                        ...bank.map((item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(Constants.getBankName(item)),
                          );
                        }).toList(),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedBank = value.toString();
                        });
                      },
                    ),
                    SizedBox(height: 20),
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
                      keyboardType: TextInputType.number,
                      controller: _amountController,
                      validator: (value) =>
                          value!.isEmpty ? 'Amount can\'t be empty' : null,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
