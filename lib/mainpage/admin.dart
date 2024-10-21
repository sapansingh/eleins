import 'dart:convert';
import 'dart:io';
import 'package:eleins/apiurl.dart';
import 'package:eleins/modelpage/healthstatus.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:toastification/toastification.dart';

class ImageUploadForm extends StatefulWidget {
  @override
  _ImageUploadFormState createState() => _ImageUploadFormState();
}

class _ImageUploadFormState extends State<ImageUploadForm> {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
   DateTime? _selectedDate;
  String? _selectedGender;
  File? _imageFile;
   String host=api().apiserve;

  List<Health_Status> state=[];
  
  List<Health_Status> city=[];
  
  List<Health_Status> rolls=[];
    List<Health_Status> partynames=[];
      List<Health_Status> constituencyidr=[];

    
void _getroll() async{
 
        final responseroll = await http.get(
    Uri.parse('$host/api/roll.php')
        );

  if(responseroll.statusCode==200){

    rolls=List.from(jsonDecode(responseroll.body)).map((e)=>Health_Status.fromJson(e)).toList();

setState(() {
  
print(responseroll.statusCode);
});

  }
}


void _getstate() async{
 
        final responsecity = await http.get(
    Uri.parse('$host/api/state.php')
        );

  if(responsecity.statusCode==200){

    state=List.from(jsonDecode(responsecity.body)).map((e)=>Health_Status.fromJson(e)).toList();

setState(() {
  
  print(state);
});

  }
}
void _getparty() async{
 
        final responseparty = await http.get(
    Uri.parse('$host/api/partyname.php')
        );

  if(responseparty.statusCode==200){

    partynames=List.from(jsonDecode(responseparty.body)).map((e)=>Health_Status.fromJson(e)).toList();

setState(() {
  

});

  }
}


void _getconstir(String state) async{

        final responsecity = await http.post(
    Uri.parse('$host/api/consti.php'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'statid':state,
      
    }),
  );

  if(responsecity.statusCode==200){

    constituencyidr=List.from(jsonDecode(responsecity.body)).map((e)=>Health_Status.fromJson(e)).toList();

         
          print("const loaded");
setState(() {
  

});

  }
}

/*
void _getcity(String cty) async{

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


@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getstate();
   _getroll();
   _getparty();
  }

 
  List<Health_Status> hstatus=[];
TextEditingController _Userid=TextEditingController();
TextEditingController _Username=TextEditingController();
TextEditingController _password=TextEditingController();
TextEditingController _mobileno=TextEditingController();
//TextEditingController _mailid=TextEditingController();
//TextEditingController _adharid=TextEditingController();
TextEditingController _userroll=TextEditingController();
TextEditingController _partyid=TextEditingController();
//TextEditingController _isactive=TextEditingController();
TextEditingController _consitunid=TextEditingController();
TextEditingController _state=TextEditingController();
//TextEditingController _city=TextEditingController();

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    });
  }

  Future<void> _uploadImage(File imageFile) async {
    var request = http.MultipartRequest('POST', Uri.parse('$host/upload.php'));
    request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));

    // Add other form data
    request.fields['userId'] = _Userid.text;
    request.fields['username'] = _Username.text;
    request.fields['userPassword'] = _password.text;
    request.fields['mobileNumber'] = _mobileno.text;
  //  request.fields['mailId'] = _mailid.text;
   // request.fields['adharchard'] = _adharid.text;
    request.fields['partyname'] = _partyid.text;
    // request.fields['isactive'] = _isactive.text;
     request.fields['consitunid'] = _consitunid.text;
      request.fields['state'] = _state.text;
    //   request.fields['city'] = _city.text;
       request.fields['uroll'] = _userroll.text;
    var response = await request.send();

    if (response.statusCode == 200) {
       var responseBody = await response.stream.bytesToString();
      // Upload successful
     

        Map<String,dynamic> newm=jsonDecode(responseBody);

 
    if(newm['status']){
  toastification.show(
  context: context,
   type: ToastificationType.success,
  style: ToastificationStyle.fillColored,
  title: Text('User Creation completed!'),
  autoCloseDuration: const Duration(seconds: 3),

 
);
   // ignore: use_build_context_synchronously
   Navigator.pop(context);
    
    }else{

          toastification.show(
  context: context,
   type: ToastificationType.error,
  style: ToastificationStyle.fillColored,
  title: Text('User cant Create please use uniq userid!'),
  autoCloseDuration: const Duration(seconds: 3),
);
   
      
    }

    } else {
      // Upload failed
      print('Failed to upload image. Status code: ${response.statusCode}');
                toastification.show(
  context: context,
   type: ToastificationType.error,
  style: ToastificationStyle.fillColored,
  title: Text('User cant Create please use uniq userid! or username'),
  autoCloseDuration: const Duration(seconds: 3),
);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create User'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
            
              SizedBox(height: 20),
          
                     
              Form(key:_formKey , child: Column(children: [
                   _buildTextFormField("Username", TextInputType.text, _Userid),
                  //  _buildTextFormField("Username", TextInputType.text, _Username),
                    _buildTextFormField("Userpassword", TextInputType.text, _password),
                    _buildTextFormField("Mobile Number", TextInputType.text, _mobileno),
                //    _buildTextFormField("Mail Id", TextInputType.text, _mailid),
                 //  _buildTextFormField("Adharcard No", TextInputType.text, _adharid),
                     _buildDropdownFormFields("Party Name",partynames,_partyid),
                   _buildDropdownFormFields("User Roll",rolls,_userroll),
                //     _buildDropdownFormField("id active",['select','Y','N'],_isactive),
           _buildDropdownFormFields("State",state,_state),
        //    _buildDropdownFormFields("District",city,_city),
               _buildDropdownFormFields("consitiuncy",constituencyidr,_consitunid),
               SizedBox(height: 20),
                GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return SafeArea(
                        child: Column(
                         
                          children: <Widget>[
                            ListTile(
                              leading: Icon(Icons.photo_library),
                              title: Text('Choose from gallery'),
                              onTap: () {
                                _pickImage(ImageSource.gallery);
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.camera_alt),
                              title: Text('Take a picture'),
                              onTap: () {
                                _pickImage(ImageSource.camera);
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: _imageFile == null
                    ? Container(
                        height: 100,
                        color: Colors.grey[300],
                        child: Center(
                          child: Icon(
                            Icons.add_a_photo,
                            size: 30,
                            color: Colors.grey[600],
                          ),
                        ),
                      )
                    : Image.file(
                        _imageFile!,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
              ),
          
          
          SizedBox(height: 20),
              
              ElevatedButton(
                onPressed: () {
              
                       if (_formKey.currentState != null &&
                          _formKey.currentState!.validate()) {
                        // Form is valid, submit data
                            if (_imageFile != null) {
                  _uploadImage(_imageFile!);
                  } else {
                    // Handle case when no image is selected
                    print('No image selected');
                  }
                      }
                },
                
                child: Text('Create User'),
              ),


              ],)),

            ],
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
          if(labelText=="mailId"){
          if (value!.isEmpty) {
            return 'Please enter $labelText';
          }

          return null;
          }
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
        validator: (value) {
          if(labelText=="mailId"){
          if (value!.isEmpty) {
            return 'Please enter $labelText';
          }
          return null;
          }
        },
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
        validator: (value) {
          if (value == 'select' || value =="") {
            return 'please select  $labelText';
          }
        },
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
            
              setState(() {
             //  _getcity(contr.text.toString());

     _getconstir(_state.text.toString());
     print("const id");
              });

       
         //   _getcity(contr.text.toString());
             }
      //              if(labelText=="District"){
    //       
      //        }
                
           
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

}
