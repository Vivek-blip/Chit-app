class User {
  final String uid;

  User({this.uid});
}

class UserData {
  final String name;
  final String chitno;
  final String chit_type;
  final List chit_nos;
  final String chit_validity,
      accountName,
      accountBranch,
      accountNumber,
      ifscCode,
      monthlyAmt,
      amount,
      type,
      regno;
  UserData(
      {this.name,
      this.chitno,
      this.chit_type,
      this.chit_validity,
      this.accountName,
      this.accountBranch,
      this.accountNumber,
      this.ifscCode,
      this.monthlyAmt,
      this.amount,
      this.regno,
      this.type,
      this.chit_nos});
}
