
import 'dart:convert';

import 'package:flutter/material.dart';



class SurveyForm extends StatefulWidget {
  @override
  _SurveyFormState createState() => _SurveyFormState();
}

class _SurveyFormState extends State<SurveyForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
     DateTime? _selectedDate;
  
 TextEditingController _voterIdController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _fatherNameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
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
  TextEditingController _satisFiedWithGovWorkController = TextEditingController();
  TextEditingController _anyIssueController = TextEditingController();
  TextEditingController _demandsForUpcommingGovController = TextEditingController();
  TextEditingController _partyFavorController = TextEditingController();
  TextEditingController _choiceOfPollingController = TextEditingController();
  TextEditingController _isHeKeyInfluencerController = TextEditingController();
  TextEditingController _isYourNeighborshiftedsomewhereController = TextEditingController();
  TextEditingController _stateNameController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  TextEditingController _latController = TextEditingController();
  TextEditingController _longController = TextEditingController();
  TextEditingController _insbyController = TextEditingController();
  TextEditingController _insdateController = TextEditingController();
  TextEditingController _modifybyController = TextEditingController();
  TextEditingController _modifydateController = TextEditingController();
  TextEditingController _maritalStatusController = TextEditingController();
  TextEditingController _voterPostController = TextEditingController();
  TextEditingController _wantKaryakartaController = TextEditingController();
  TextEditingController _casteController = TextEditingController();
  TextEditingController _subCasteController = TextEditingController();
  TextEditingController _stateIdController = TextEditingController();
  TextEditingController _cityIdController = TextEditingController();
  TextEditingController _consitituencynoController = TextEditingController();
  TextEditingController _remarkController = TextEditingController();
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
          child: ListView(
            children: [
              Text(
                'Voter Information',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.0),
              _buildTextFormField('Voter ID', TextInputType.text),
              _buildTextFormField('Name', TextInputType.text),
              _buildTextFormField('Fathers Name', TextInputType.text),
              _buildTextFormField('Age', TextInputType.number),
            _buildDropdownFormField('Gender', ['Male', 'Female', 'Other']),
               _buildDateFormField('Date of Birth'),
              _buildTextFormField('Address', TextInputType.multiline),
              _buildTextFormField('Qualification', TextInputType.text),
              _buildDropdownFormField('Is Living Alone', ['Yes', 'No']),
              _buildTextFormField('Number of Family Members', TextInputType.number),
              _buildTextFormField('WhatsApp Number', TextInputType.phone),
              _buildTextFormField('Other Mobile Number', TextInputType.phone),
              _buildTextFormField('Email', TextInputType.emailAddress),
              _buildTextFormField('Native Address', TextInputType.multiline),
              _buildTextFormField('Category', TextInputType.text),
              _buildTextFormField('Occupation/Activity', TextInputType.text),
              _buildTextFormField('Health Status', TextInputType.text),
              _buildTextFormField('Disabilities', TextInputType.text),
              _buildTextFormField('Type of Stay', TextInputType.text),
              _buildTextFormField('Visit to Home', TextInputType.text),
              _buildTextFormField('Blood Group', TextInputType.text),
              _buildDropdownFormField('Satisfied with Govt. Work', ['Yes', 'No']),
              _buildTextFormField('Any Issue', TextInputType.text),
              _buildTextFormField('Demands for Upcoming Govt.', TextInputType.text),
              _buildTextFormField('Party Favor', TextInputType.text),
              _buildTextFormField('Choice of Polling', TextInputType.text),
              _buildDropdownFormField('Is Key Influencer', ['Yes', 'No']),
              _buildDropdownFormField('Neighbor Shifted Somewhere', ['Yes', 'No']),
              _buildTextFormField('State Name', TextInputType.text),
              _buildTextFormField('Number', TextInputType.text),
              _buildTextFormField('Latitude_Longitude', TextInputType.number),
              
          
              _buildDropdownFormField('Marital Status', ['Mareied', 'Not Mareied']),
              _buildTextFormField('Voter Post', TextInputType.text),
              _buildTextFormField('Want Karyakarta', TextInputType.text),
              _buildTextFormField('Caste', TextInputType.text),
              _buildTextFormField('Sub Caste', TextInputType.text),
              _buildTextFormField('State ID', TextInputType.number),
              _buildTextFormField('City ID', TextInputType.number),
              _buildTextFormField('Constituency No', TextInputType.text),
              _buildTextFormField('Remark', TextInputType.text),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState != null && _formKey.currentState!.validate()) {
                    // Form is valid, submit data
                    _submitForm();
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(String labelText, TextInputType keyboardType) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
        ),
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

  Widget _buildDropdownFormField(String? labelText, List<String> options) {
    String? _selectedGender;
  _selectedGender=options.first;
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
      print(_selectedGender);

          });
        },
        items: options.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value.toString(),
            child: Text(value),            
          );
        }).toList(),
        validator: (value) {
          if (value == null) {
            return 'Please select $labelText';
          }
          return value;
        },
      ),
    );
  }

  Widget _buildDateFormField(String labelText) {
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
                  ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
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
        'VoterId': _voterIdController.text,
        'Name': _nameController.text,
        'FatherName': _fatherNameController.text,
        'Age': _ageController.text,
        'Gender': _genderController.text,
        'Dob': _dobController.text,
        'Address': _addressController.text,
        'Qualification': _qualificationController.text,
        'IsLivingAlone': _isLivingAloneController.text,
        'NoOfFamilyMembers': _noOfFamilyMembersController.text,
        'WhatsappNo': _whatsappNoController.text,
        'OtherMobNo': _otherMobNoController.text,
        'Email': _emailController.text,
        'NativeAddress': _nativeAddressController.text,
        'category': _categoryController.text,
        'OccupationActivity': _occupationActivityController.text,
        'HealthSatatus': _healthSatatusController.text,
        'Disabilities': _disabilitiesController.text,
        'TypeOfStay': _typeOfStayController.text,
        'VisitToHome': _visitToHomeController.text,
        'BloodGroup': _bloodGroupController.text,
        'SatisFiedWithGovWork': _satisFiedWithGovWorkController.text,
        'AnyIssue': _anyIssueController.text,
        'DemandsForUpcommingGov': _demandsForUpcommingGovController.text,
        'PartyFavor': _partyFavorController.text,
        'ChoiceOfPolling': _choiceOfPollingController.text,
        'IsHeKeyInfluencer': _isHeKeyInfluencerController.text,
        'IsYourNeighborshiftedsomewhere': _isYourNeighborshiftedsomewhereController.text,
        'StateName': _stateNameController.text,
        'Number': _numberController.text,
        'Lat': _latController.text,
        'Long': _longController.text,
        'insby': _insbyController.text,
        'insdate': _insdateController.text,
        'modifyby': _modifybyController.text,
        'modifydate': _modifydateController.text,
        'MaritalStatus': _maritalStatusController.text,
        'VoterPost': _voterPostController.text,
        'WantKaryakarta': _wantKaryakartaController.text,
        'caste': _casteController.text,
        'SubCaste': _subCasteController.text,
        'stateid': _stateIdController.text,
        'cityid': _cityIdController.text,
        'consitituencyno': _consitituencynoController.text,
        'remark': _remarkController.text,
      };

      // Convert payload to JSON format
      var jsonPayload = jsonEncode(payload);

      // Send POST request
      var response = await http.post(
        Uri.parse('YOUR_API_ENDPOINT'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonPayload,
      );

      // Check response status
      if (response.statusCode == 200) {
        print('Form submitted successfully');
        // Handle successful response
      } else {
        print('Failed to submit form: ${response.statusCode}');
        // Handle error response
      }
    }
  }
}
