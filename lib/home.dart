import 'package:eleins/apiurl.dart';
import 'package:eleins/login.dart';
import 'package:eleins/mainpage/admin.dart';
import 'package:eleins/mainpage/servy.dart';
import 'package:eleins/mainpage/totalusers.dart';
import 'package:eleins/modelpage/healthstatus.dart';
import 'package:eleins/totatlserv.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}
class Optiondata {
  late String title;
  late IconData? iconst;
  late String rout;
  late Widget routwin;
  Optiondata({required this.title, required this.iconst, required this.routwin});
}

class _homeState extends State<home> {

   String? roll;
   String? pic;
      String? userid="";
       
   List<Optiondata> newlistdata=[];
  void getdata() async{

    Future.delayed(Duration(seconds: 2));
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid=prefs.getString("userid");
   roll=prefs.getString("roll");
   pic=prefs.getString("pic");
 
 print(roll);
  print("system roll");
  setState(() {
    
  });
      if(roll=="1"){
 newlistdata = [    
     Optiondata(title: "Create User", iconst: Icons.cabin, routwin: ImageUploadForm()),
      Optiondata(title: "Total User", iconst: Icons.cabin, routwin: TotalUser()),
        Optiondata(title: "Total Servey", iconst: Icons.cabin, routwin: TotalServ()),
    Optiondata(title: "Servey", iconst: Icons.poll_outlined, routwin: SurveyForm())
    
  ];

    }else{
     newlistdata = [
    Optiondata(title: "Total Servey", iconst: Icons.cabin, routwin: TotalServ()),
    Optiondata(title: "Servey", iconst: Icons.poll_outlined, routwin: SurveyForm()),
    
  ];
    }
  }

  

   _getoptiondata(){


   }

   String? host=api().apiserve;
  List<Health_Status> hstatus=[];
    
    





@override
  void initState() {
    // TODO: implement initState
    super.initState();
   getdata();
   _getoptiondata();
  }








  @override
  Widget build(BuildContext context) {
    return Material(child: Scaffold(appBar: AppBar(title: Text("ELEINS"),),body: grider(),drawer: Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(userid!),
            accountEmail: Text(""),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage("$host/upload_images/$pic"),
            ),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: ()async{
              // Perform logout action
             // Close the drawer
  SharedPreferences prefs = await SharedPreferences.getInstance();
   prefs.remove('status')!;
  prefs.remove("stateid");
  prefs.remove("userid");
  prefs.remove("cityid");
  prefs.remove("consitituencyno");
  prefs.remove("contactinfo");
  
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
             
            },
          ),
        ],
      ),
    ),));

    
  }



/*
 void Logout()async{

  SharedPreferences prefs = await SharedPreferences.getInstance();
   prefs.remove('status')!;
  prefs.remove("stateid");
  prefs.remove("cityid");
  prefs.remove("consitituencyno");


  
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>home()));



setState(() {
});

    }


*/
    Widget grider() {
    return GridView.builder(
        itemCount: newlistdata.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 2),
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () {
                Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                  return newlistdata[index].routwin;
                }, transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                  const begin = Offset(1.3, 0.0);
                  const end = Offset.zero;
                  const curve = Curves.easeInOut;
                  var tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));
                  var offsetAnimation = animation.drive(tween);
                  return SlideTransition(
                      position: offsetAnimation, child: child);
                }));
              },
              child: Container(
                  margin: EdgeInsets.all(8),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  child: Card(
                      color: Colors.amberAccent,
                      child: Center(
                          child: Column(
                            children: [
                              Center(child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Icon(newlistdata[index].iconst,size: 70,color:Colors.blue,),
                              )),
                              SizedBox(
                                child: Text(
                                                        newlistdata[index].title,
                                                        style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w900),
                                                      ),
                              ),
                            ],
                          )))));
        });
  }
}

/*
class DrawerWidget extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(useridr!),
            accountEmail: Text('john.doe@example.com'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/people.png'),
            ),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: ()async{
              // Perform logout action
             // Close the drawer
  SharedPreferences prefs = await SharedPreferences.getInstance();
   prefs.remove('status')!;
  prefs.remove("stateid");
  prefs.remove("userid");
  prefs.remove("cityid");
  prefs.remove("consitituencyno");
  prefs.remove("contactinfo");
  
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
             
            },
          ),
        ],
      ),
    );
  }




}
   */