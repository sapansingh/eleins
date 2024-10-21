class responsestatus{


bool? status;
String? message;


responsestatus({required this.status,required this.message});

factory responsestatus.fromJson(Map<String,dynamic> JSON){
  return responsestatus(status: JSON['status'],message: JSON['message']);
}

Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
    };
  }

}