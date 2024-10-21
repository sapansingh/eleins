
class responsestatuslogin{


bool? status;
String? userid;
String? stateid;
String? cityid;
String? consitituencyno;
bool? contactinfo;
String? roll;
String? pic;


responsestatuslogin({required this.status,this.userid,required this.stateid,required this.cityid,required this.consitituencyno,this.contactinfo,this.roll,this.pic});

factory responsestatuslogin.fromJson(Map<String,dynamic> JSON){
  return responsestatuslogin(status: JSON['status'],userid: JSON['userid'], stateid: JSON['stateid'], cityid:JSON['cityid'], consitituencyno: JSON['consitituencyno'],contactinfo: JSON['contactinfo'],roll: JSON['roll'],pic: JSON['pic']);
}

Map<String, dynamic> toJson() {
    return {
      'status': status,
      'userid':userid,
      'stateid': stateid,
      'cityid':cityid,
      'consitituencyno':consitituencyno,
       'contactinfo':contactinfo,
       'roll':roll,
       'pic':pic
       
    };
  }

}