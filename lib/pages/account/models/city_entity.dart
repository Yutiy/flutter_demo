import 'package:azlistview/azlistview.dart';

class CityEntity with ISuspensionBean {
  String name;
  String cityCode;
  String firstCharacter;

  CityEntity({this.name, this.cityCode, this.firstCharacter});

  CityEntity.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        cityCode = json['cityCode'],
        firstCharacter = json['firstCharacter'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'cityCode': cityCode,
        'firstLetter': firstCharacter,
      };

  @override
  String getSuspensionTag() {
    return firstCharacter;
  }
}
