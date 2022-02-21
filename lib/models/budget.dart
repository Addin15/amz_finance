class Budget {
  String? name;
  double? allocation;

  Budget({this.name, this.allocation});

  Budget.fromSnapshot(Map<String, dynamic> snapshot)
      : name = snapshot['name'],
        allocation = snapshot['budget'].toDouble();

  static Map<String, dynamic> toMap(Budget budget) {
    return {
      'name': budget.name,
      'budget': budget.allocation,
    };
  }
}
