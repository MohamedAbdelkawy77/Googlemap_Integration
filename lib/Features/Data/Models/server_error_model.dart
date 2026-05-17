class ServerErrorModel {
  final int codeerror;
  final String message;

  ServerErrorModel({required this.codeerror, required this.message});
  factory ServerErrorModel.fromJson({required Map<String, dynamic> data}) {
    return ServerErrorModel(codeerror: data["code"], message: data["message"]);
  }
}
