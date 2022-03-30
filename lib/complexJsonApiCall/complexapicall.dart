import 'dart:convert';

import 'package:flutter/material.dart';
import 'model/UserModel.dart';
import 'package:http/http.dart' as http;

class ComplexJsonApiCallScreen extends StatefulWidget {
  const ComplexJsonApiCallScreen({Key? key}) : super(key: key);

  @override
  _ComplexJsonApiCallScreenState createState() => _ComplexJsonApiCallScreenState();
}

class _ComplexJsonApiCallScreenState extends State<ComplexJsonApiCallScreen> {

  // Creating a List of UserModel
  List<UserModel> userList = [];

  Future <List<UserModel>> getUserApi()async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      for(Map i in data){
        userList.add(UserModel.fromJson(i));
        // If you simple want to print one simple value then try this
        print(i['name']);
      }
      return userList;
    }
    else{
      return userList;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Complex Json Api Call"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getUserApi(),
              builder: (context, AsyncSnapshot<List<UserModel>> snapshot){
                if(!snapshot.hasData){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                else{
                  return ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (context, index){
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                          children: [
                            ReusableRow(
                              title: "Name",
                              value: snapshot.data![index].name.toString(),
                            ),
                            ReusableRow(
                              title: "Username",
                              value: snapshot.data![index].username.toString(),
                            ),
                            ReusableRow(
                              title: "Email",
                              value: snapshot.data![index].email.toString(),
                            ),
                            ReusableRow(
                              title: "Address",
                              value: snapshot.data![index].address!.city.toString()
                                + snapshot.data![index].company!.name.toString()
                            ),
                          ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      )
    );
  }
}


class ReusableRow extends StatelessWidget {
  String? title;
  String? value;
  ReusableRow({this.title, this.value});
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title!),
          Text(value!),
        ],
      ),
    );
  }
}
