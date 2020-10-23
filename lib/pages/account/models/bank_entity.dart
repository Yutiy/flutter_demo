import 'package:azlistview/azlistview.dart';

class BankEntity with ISuspensionBean {
  int id;
  String bankName;
  String firstLetter;

  BankEntity({this.id, this.bankName, this.firstLetter});

  BankEntity.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        bankName = json['bankName'],
        firstLetter = json['firstLetter'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'bankName': bankName,
        'firstLetter': firstLetter,
      };

  @override
  String getSuspensionTag() {
    return firstLetter;
  }
}
