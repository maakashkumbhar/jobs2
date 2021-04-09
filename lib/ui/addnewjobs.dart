import 'package:flutter/material.dart';
import 'package:jobs_app2/net/flutterfire.dart';

class AddNewJob extends StatefulWidget {
  @override
  _AddNewJobState createState() => _AddNewJobState();
}

class _AddNewJobState extends State<AddNewJob> {
  String jobtypevalue;
  List jobtypelist = ["Part Time", "Full Time"];

  TextEditingController _hrnameController = TextEditingController();
  TextEditingController _hrcontactController = TextEditingController();
  TextEditingController _jobdetailsController = TextEditingController();
  TextEditingController _vacancyController = TextEditingController();
  TextEditingController _salarytController = TextEditingController();
  TextEditingController _joblocationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Job'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              TextFormField(
                controller: _hrnameController,
                decoration: InputDecoration(
                    labelText: "HR_Name",
                    labelStyle: TextStyle(color: Colors.black)),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _hrcontactController,
                decoration: InputDecoration(
                    labelText: "HR_Contact",
                    labelStyle: TextStyle(color: Colors.black)),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _jobdetailsController,
                decoration: InputDecoration(
                    labelText: "JobDetails",
                    labelStyle: TextStyle(color: Colors.black)),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _vacancyController,
                decoration: InputDecoration(
                    labelText: "Vacancy",
                    labelStyle: TextStyle(color: Colors.black)),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _salarytController,
                decoration: InputDecoration(
                    labelText: "Salary",
                    labelStyle: TextStyle(color: Colors.black)),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _joblocationController,
                decoration: InputDecoration(
                    labelText: "Job Location",
                    labelStyle: TextStyle(color: Colors.black)),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton(
                    hint: Text('Select Job type:'),
                    icon: Icon(Icons.arrow_drop_down),
                    dropdownColor: Colors.grey,
                    isExpanded: true,
                    iconSize: 36,
                    value: jobtypevalue,
                    onChanged: (newvalue) {
                      setState(() {
                        jobtypevalue = newvalue;
                      });
                    },
                    items: jobtypelist.map((valueitem) {
                      return DropdownMenuItem(
                        value: valueitem,
                        child: Text(valueitem),
                      );
                    }).toList()),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.4,
                height: 45,
                child: MaterialButton(
                  onPressed: () async {
                    await addJob(
                        _hrnameController.text,
                        _hrcontactController.text,
                        _jobdetailsController.text,
                        _vacancyController.text,
                        _salarytController.text,
                        _joblocationController.text,
                        jobtypevalue);
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  color: Colors.blue,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
