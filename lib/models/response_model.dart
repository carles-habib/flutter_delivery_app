// ignore_for_file: public_member_api_docs, sort_constructors_first
class ResponseModel {
  bool _isSccess;
  String _message;
  ResponseModel(
    this._isSccess,
    this._message,
  );

  String get message => _message;
  bool get isSuccess => _isSccess;
}
