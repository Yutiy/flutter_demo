class ResultData<T> {
  T data;
  int code;
  bool status;
  String message;

  ResultData({this.data, this.code, this.message});

  ResultData.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['errCode'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['errCode'] = this.code;
    data['data'] = this.data;
    return data;
  }
}
