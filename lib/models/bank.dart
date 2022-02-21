class Bank {
  String? bank;
  String? accountNumber;
  double? balance;

  Bank({this.bank, this.accountNumber, this.balance});

  Bank.fromSnapshot(String accNumber, Map<String, dynamic> snapshot)
      : bank = snapshot['bank'],
        accountNumber = accNumber,
        balance = snapshot['balance'].toDouble();
}
