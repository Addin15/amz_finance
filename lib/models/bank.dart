class Bank {
  String? bank;
  String? accountNumber;
  String? accountType;
  double? balance;

  Bank({this.bank, this.accountNumber, this.accountType, this.balance});

  Bank.fromSnapshot(String accNumber, Map<String, dynamic> snapshot)
      : bank = snapshot['bank'],
        accountNumber = accNumber,
        accountType = snapshot['accountType'],
        balance = snapshot['balance'].toDouble();
}
