
class Health_Status{

String? id;
String? hstatus;



Health_Status({required this.id,required this.hstatus});


factory Health_Status.fromJson(Map<dynamic,dynamic> json){
return Health_Status(
  id:json['id'],
  hstatus: json['HealthSatatus']
);


}



}