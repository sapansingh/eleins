import 'dart:convert';
import 'package:eleins/apiurl.dart';
import 'package:eleins/modelpage/healthstatus.dart';
import 'package:eleins/modelpage/response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';
import 'package:http/http.dart' as http;

class SurveyForm extends StatefulWidget {
  @override
  _SurveyFormState createState() => _SurveyFormState();
}

class _SurveyFormState extends State<SurveyForm> {

 String _latitude = '';
  String _longitude = '';
  String host=api().apiserve;
  List<Health_Status> hstatus=[];
   List<Health_Status> category=[];
      List<Health_Status> qualification=[];
     List<Health_Status> diability=[];
      List<Health_Status> issuect=[];
       List<Health_Status> occueps=[];
    List<Health_Status> paertyfv=[];
    List<Health_Status> demandfor=[];
      List<Health_Status> choicepollin=[];
       List<Health_Status> maritalsta=[];
     List<Health_Status> voterpos=[];
        List<Health_Status> state=[];
         List<Health_Status> city=[];
         List<Health_Status> booth=[];
         
        String? userid;
          String? stateid;
            String? cityid;
              String? consitituencyno;




@override
void initState() {
  
  super.initState();
  _gethstatus();
  getdata();
_requestLocationPermission();

}


  void _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      setState(() {
        _latitude = position.latitude.toString();
        _longitude = position.longitude.toString();


        print(_latitude);
        print(_longitude);
      });
    } catch (e) {
      print('Failed to get location: $e');
    }
  }

void _getbooth(String consitituencyno) async{

        final responsecity = await http.post(
    Uri.parse('$host/api/boothno.php'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'constituencyid':consitituencyno,
    }),
  );

  if(responsecity.statusCode==200){

    booth= List.from(jsonDecode(responsecity.body)).map((e)=>Health_Status.fromJson(e)).toList();

setState(() {
  

});

  }
}
  void getdata() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid=prefs.getString("userid");
   stateid=prefs.getString("stateid");
  cityid=prefs.getString("cityid");
  consitituencyno=prefs.getString("consitituencyno");
  _getbooth(consitituencyno!);

  setState(() {
    
  });
  }


  _gethstatus() async{
    
    var responder=await http.get(Uri.parse("$host/api/healthstatus.php"));
    if(responder.statusCode==200){
      hstatus= List.from(jsonDecode(responder.body)).map((e)=>Health_Status.fromJson(e)).toList();
      setState(() {
        
      });   
    }





  var responders=await http.get(Uri.parse("$host/api/category.php"));

    if(responders.statusCode==200){
       category= List.from(jsonDecode(responders.body)).map((e)=>Health_Status.fromJson(e)).toList();
   
   setState(() {

   });
    }

      var repcate=await http.get(Uri.parse("$host/api/qualification.php"));

    if(repcate.statusCode==200){
       qualification= List.from(jsonDecode(repcate.body)).map((e)=>Health_Status.fromJson(e)).toList();
   

    }

      var repdisablity=await http.get(Uri.parse("$host/api/disablity.php"));

    if(repdisablity.statusCode==200){
       diability= List.from(jsonDecode(repdisablity.body)).map((e)=>Health_Status.fromJson(e)).toList();
     
    

    }

      var repissue=await http.get(Uri.parse("$host/api/issue.php"));

    if(repissue.statusCode==200){
       issuect= List.from(jsonDecode(repissue.body)).map((e)=>Health_Status.fromJson(e)).toList();
       
    }

      var repoccu=await http.get(Uri.parse("$host/api/occuep.php"));

    if(repoccu.statusCode==200){
       occueps= List.from(jsonDecode(repoccu.body)).map((e)=>Health_Status.fromJson(e)).toList();
       
    }

      var reppartyfav=await http.get(Uri.parse("$host/api/partyfav.php"));

    if(repoccu.statusCode==200){
       paertyfv= List.from(jsonDecode(reppartyfav.body)).map((e)=>Health_Status.fromJson(e)).toList();
     
    
 

  
    }


    var repdmfore=await http.get(Uri.parse("$host/api/demandfor.php"));

    if(repdmfore.statusCode==200){
       demandfor= List.from(jsonDecode(repdmfore.body)).map((e)=>Health_Status.fromJson(e)).toList();
     
    
  


  
    }

  var repchoicepollin=await http.get(Uri.parse("$host/api/choicepolling.php"));

    if(repdmfore.statusCode==200){
       choicepollin = List.from(jsonDecode(repchoicepollin.body)).map((e)=>Health_Status.fromJson(e)).toList();

    }

  var repmaritalsta=await http.get(Uri.parse("$host/api/maritalsta.php"));

    if(repdmfore.statusCode==200){
       maritalsta= List.from(jsonDecode(repmaritalsta.body)).map((e)=>Health_Status.fromJson(e)).toList();
     
    
 

  
    }

 var repVoterPost=await http.get(Uri.parse("$host/api/voterpost.php"));

    if(repdmfore.statusCode==200){
       voterpos= List.from(jsonDecode(repVoterPost.body)).map((e)=>Health_Status.fromJson(e)).toList();
     
    
    }


    


 var repstate=await http.get(Uri.parse("$host/api/state.php"));

    if(repstate.statusCode==200){
    state= List.from(jsonDecode(repstate.body)).map((e)=>Health_Status.fromJson(e)).toList();
     
   
    }



    }
    
/*
void _getcity(String cty) async{
 city=[];
        final responsecity = await http.post(
    Uri.parse('$host/api/city.php'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'statid':cty,
    }),
  );

  if(responsecity.statusCode==200){

    city=List.from(jsonDecode(responsecity.body)).map((e)=>Health_Status.fromJson(e)).toList();

setState(() {
  

});

  }
}
*/


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime? _selectedDate;
  String? _selectedGender;

  TextEditingController _voterIdController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _fatherNameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _gendController = TextEditingController();

  TextEditingController _dobController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _qualificationController = TextEditingController();
  TextEditingController _isLivingAloneController = TextEditingController();
   TextEditingController _noOfFamilyMembersController = TextEditingController();
  TextEditingController _whatsappNoController = TextEditingController();
  TextEditingController _otherMobNoController = TextEditingController();
  
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nativeAddressController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _occupationActivityController = TextEditingController();
  TextEditingController _healthSatatusController = TextEditingController();
  TextEditingController _disabilitiesController = TextEditingController();
  TextEditingController _typeOfStayController = TextEditingController();
  TextEditingController _visitToHomeController = TextEditingController();
  TextEditingController _bloodGroupController = TextEditingController();
  TextEditingController _satisFiedWithGovWorkController =
      TextEditingController();
  TextEditingController _anyIssueController = TextEditingController();
  TextEditingController _demandsForUpcommingGovController =
      TextEditingController();
  TextEditingController _partyFavorController = TextEditingController();
  TextEditingController _choiceOfPollingController = TextEditingController();
  TextEditingController _isHeKeyInfluencerController = TextEditingController();
  TextEditingController _isYourNeighborshiftedsomewhereController =
      TextEditingController();
  
  TextEditingController _numberController = TextEditingController();
  TextEditingController _latController = TextEditingController();
  
 

  TextEditingController _maritalStatusController = TextEditingController();
  TextEditingController _voterPostController = TextEditingController();
  TextEditingController _wantKaryakartaController = TextEditingController();
  TextEditingController _casteController = TextEditingController();
  TextEditingController _subCasteController = TextEditingController();


  TextEditingController _boothnoController = TextEditingController();
  TextEditingController _remarkController = TextEditingController();
 void _requestLocationPermission() async {
  var status = await Permission.location.request();
  if (status.isGranted) {
    // Permission granted, proceed with accessing location
    _getCurrentLocation();
  } else if (status.isDenied) {
    // Permission denied, show a dialog explaining why the app needs location
    _showPermissionDeniedDialog();
  } else if (status.isPermanentlyDenied) {
    // Permission permanently denied, show a dialog directing the user to app settings
    _showPermissionPermanentlyDeniedDialog();
  }
}
void _showPermissionDeniedDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Location Permission Required"),
        content: Text("Please grant location permission to use this feature."),
        actions: <Widget>[
          ElevatedButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void _showPermissionPermanentlyDeniedDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Location Permission Required"),
        content: Text("Location permission is permanently denied. Please go to app settings to enable location."),
        actions: <Widget>[
          ElevatedButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Survey Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child:Column(
                children: [
                  Text(
                    'Voter Information',
                    style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20.0),
                  _buildTextFormFields(
                      'Voter_ID/वोटर_आईडी', TextInputType.text, _voterIdController),
                  _buildTextFormField('Name/नाम', TextInputType.text, _nameController),
                  _buildTextFormField(
                      'Fathers_Name/पिता का नाम', TextInputType.text, _fatherNameController),
                  _buildTextFormField('Age/आयु', TextInputType.number, _ageController),
                  _buildDropdownFormField('Gender/लिंग',
                      ['select', 'Male', 'Female', 'Other'], _gendController),
                  _buildDateFormField('Date_of_Birth/जन्म की तारीख', _dobController),
              
                //  _buildDropdownFormFields('State/राज्य', state,_stateIdController),
               //   _buildDropdownFormFields('City/शहर', city,_cityIdController),
              
              
                  _buildTextFormField(
                      'Address/पता', TextInputType.multiline, _addressController),
                  _buildDropdownFormFields(
                      'Qualification/योग्यता',
                    qualification,
                      _qualificationController),
                  _buildDropdownFormField('Is_Living_Alone/अकेले रह रहा है',
                      ['select', 'Yes', 'No'], _isLivingAloneController),
                   _buildTextFormFields('Number_of_Family_Members/परिवार_सदस्यों_की_संख्या',
                      TextInputType.number, _noOfFamilyMembersController),
                  _buildTextFormField('WhatsApp_Number', TextInputType.phone,
                      _whatsappNoController),
                 _buildTextFormField('Other_Mobile_Number', TextInputType.phone,
                      _otherMobNoController),
                  _buildTextFormFields(
                      'Email/ईमेल', TextInputType.emailAddress, _emailController),
                  _buildTextFormFields('Native_Address/मूल_पता', TextInputType.multiline,
                      _nativeAddressController),
              
                  _buildDropdownFormFields(
                      'Category/वर्ग', category, _categoryController),
                  _buildDropdownFormFields('Occupation_Activity/व्यवसाय_गतिविधि',occueps,
                      _occupationActivityController),
                  _buildDropdownFormFields('Health_Statu/स्वास्थ्य की स्थितिs', hstatus,
                      _healthSatatusController),
                  _buildDropdownFormFields(
                      'Disabilities/विकलांग', diability, _disabilitiesController),
                  _buildDropdownFormField(
                      'Type_of_Stay/ठहरने_का_प्रकार', ['select','PERMANENT','TEMPORARY'], _typeOfStayController),
              
                  _buildDropdownFormField('Visit_to_Home/घर पर जाएँ', ['select','quarterly', 'monthly','yearly','never'],_visitToHomeController),
                  _buildDropdownFormField('Blood_Group/ब्लड ग्रुप', ['select','A+','B+','AB+','O+','A-','B-','AB-','O-'], _bloodGroupController),
                  _buildDropdownFormField('Satisfied_with_Govt_Work/सरकारी_काम_से_संतुष्ट', ['select','Yes', 'No'],_satisFiedWithGovWorkController),
                 _buildDropdownFormFields('Any_Issue/कोई समस्या ', issuect,_anyIssueController),
                  _buildDropdownFormFields('Demands_for_Upcoming_Govt/आगामी सरकार की मांग', demandfor,_demandsForUpcommingGovController),
                  _buildDropdownFormFields('Party_Favor/पार्टी के पक्ष',paertyfv, _partyFavorController),
                  _buildDropdownFormFields('Choice_of_Polling/मतदान का विकल्प', choicepollin,
                      _choiceOfPollingController),
                  _buildDropdownFormField('Is_Key_Influencer/प्रमुख प्रभावशाली है', ['select','Yes', 'No'],_isHeKeyInfluencerController),
                  _buildDropdownFormField(
                      'Neighbor_Shifted_Somewhere/पड़ोसी_कहीं_शिफ्ट हो गया', ['select','Yes', 'No'],_isYourNeighborshiftedsomewhereController),
                  _buildTextFormFields(
                      'Phone Number/फ़ोन नंबर', TextInputType.text, _numberController),
           //       _buildTextFormField(
           //           'Latitude_Longitude', TextInputType.number, _latController),
               
                  _buildDropdownFormFields(
                      'Marital_Statu/वैवाहिक स्थितिs', maritalsta,_maritalStatusController),
                _buildDropdownFormFields(
                      'Voter_Post/मतदाता_पोस्ट', voterpos, _voterPostController),
                    _buildDropdownFormField('Want_Karyakarta/कार्यकर्ता_चाहिए', ['select','Yes', 'No'],_wantKaryakartaController),
                  _buildDropdownFormField(
                      'Caste/जाति', ['select','Hindu', 'Muslim','Sikh','Christian','baudh '], _casteController),
                  _buildTextFormFields(
                      'Sub_Caste/उप जाति', TextInputType.text, _subCasteController), 
                  _buildTextFormField('booth no/बूथ संख्या',TextInputType.number ,_boothnoController), 
              
                  _buildTextFormField(
                      'Remark', TextInputType.text, _remarkController), 
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                
                        // Form is valid, submit data
                        _submitForm();
                     
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(String labelText, TextInputType keyboardType,
      TextEditingController control) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder()
        ),
        controller: control,
        keyboardType: keyboardType,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter $labelText';
          }
          return null;
        },
      ),
    );
  }




  Widget _buildTextFormFields(String labelText, TextInputType keyboardType,
      TextEditingController control) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder()
        ),
        controller: control,
        keyboardType: keyboardType,
    
      ),
    );
  }




  Widget _buildDropdownFormField(
      String? labelText, List<String> options, TextEditingController contr) {
    _selectedGender = options.first;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
        ),
        value: _selectedGender,
        onChanged: (String? newValue) {
          setState(() {
            _selectedGender = newValue;
            contr.text = _selectedGender.toString();
            print(contr.text);
          });
        },
        /*
        validator: (value) {
          if (value == 'select' || value =="") {
            return 'please select  $labelText';
          }
        },
        */
        items: options.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value.toString(),
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDropdownFormFields(
      String? labelText, List<Health_Status> options, TextEditingController contr) {
     Health_Status? _selectedModel;  
    return Padding(
     padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<Health_Status>(
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
        ),
        value: _selectedModel,
        onChanged: (Health_Status? newValue) {
          setState(() {
            _selectedModel = newValue;
                 contr.text =newValue!.id.toString();
             if(labelText=="State"){
     
         //   _getcity(_stateIdController.text);
             }
            print(contr.text);
          });
        },
        validator: (value) {
          if (value =="") {
            return 'please select  $labelText';
          }
        },
        items: options.map<DropdownMenuItem<Health_Status>>((Health_Status model) {
          return DropdownMenuItem<Health_Status>(
            value: model,
            child: Text(model.hstatus!.toString()),
          );
        }).toList(),
      ),
    );
  }



  Widget _buildDateFormField(
      String labelText, TextEditingController dobController) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              labelText,
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          OutlinedButton(
            onPressed: () {
              _selectDate(context);
            },
            child: Text(
              _selectedDate != null
                  ? dobController.text =
                      '${_selectedDate!.year}-${_selectedDate!.month}-${_selectedDate!.day}'
                  : 'Select Date',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Construct the JSON payload
      var payload = {
        'voter_id': _voterIdController.text,
        'Name': _nameController.text,
        'Fathers_Name': _fatherNameController.text,
        'Age': _ageController.text,
        'gender': _gendController.text,
        'dob': _dobController.text,
        'address': _addressController.text,
        'qualification': _qualificationController.text,
        'isalone': _isLivingAloneController.text,
        'nooffm':_noOfFamilyMembersController.text,
        'whatsupno':_whatsappNoController.text,
        'othernumber': _otherMobNoController.text,
        'email':_emailController.text,
        'native_address':_nativeAddressController.text,
        'category':_categoryController.text,
        'Occupation_Activity':_occupationActivityController.text,
        'Health_Status':_healthSatatusController.text,
        'Disabilities':_disabilitiesController.text,
        'Type_of_Stay':_typeOfStayController.text,
        'visit_to_home':_visitToHomeController.text,
        'Blood_Group':_bloodGroupController.text,
        'setis_withfovt':_satisFiedWithGovWorkController.text,
        'any_issue':_anyIssueController.text,
        'upcoming_govt':_demandsForUpcommingGovController.text,
        'partyfav':_partyFavorController.text,
        'choicepoll':_choiceOfPollingController.text,
        'influincer':_isHeKeyInfluencerController.text,
        'nss':_isYourNeighborshiftedsomewhereController.text,
        'phone':_numberController.text,
        'marital_status':_maritalStatusController.text,
        'cast':_casteController.text,
        'subcast':_subCasteController.text,
        'voterpost':_voterPostController.text,
        'wantkar':_wantKaryakartaController.text,
        'remark':_remarkController.text,
        'userid':userid,
        'stateid':stateid,
        'cityid':cityid,
        'consitituencyno':consitituencyno,
        'boothno':_boothnoController.text,
        'lat':_latitude,
        'long':_longitude


      };



      // Convert payload to JSON format
      var jsonPayload = jsonEncode(payload);

      print(jsonPayload);
      // Send POST request
      var response = await http.post(
        Uri.parse('$host/index.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonPayload,
      );

      // Check response status
      if (response.statusCode == 200) {

        Map<String,dynamic>  respinse=jsonDecode(response.body);
        print('Form submitted successfully');
          
    print(respinse['status']);
    if(respinse['status']){
  toastification.show(
  context: context,
   type: ToastificationType.success,
  style: ToastificationStyle.fillColored,
  title: Text('Servey completed!'),
  autoCloseDuration: const Duration(seconds: 3),

 
);
   // ignore: use_build_context_synchronously
   Navigator.pop(context);
    
    }else{

          toastification.show(
  context: context,
   type: ToastificationType.error,
  style: ToastificationStyle.fillColored,
  title: Text('Servey not completed!'),
  autoCloseDuration: const Duration(seconds: 3),
);
   
      
    }

        // Handle successful response
      } else {
          toastification.show(
  context: context,
   type: ToastificationType.error,
  style: ToastificationStyle.fillColored,
  title: Text('Servey completed!'),
  autoCloseDuration: const Duration(seconds: 3),
);
        print('Failed to submit form: ${response.statusCode}');
        // Handle error response
      }
    }
  }
}