class ResultData<T> {
  T data;
  int code;
  String message;

  ResultData(this.code, this.message, {this.data});
}
