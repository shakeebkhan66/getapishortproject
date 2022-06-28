
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/PostsModel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}


//   List <PostsModel>  postList = [];
// Future<List<PostsModel>> getPostApi() async{
//   final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
//   var data = jsonDecode(response.body.toString());
//   if (response.statusCode == 200){
//     for(Map i in data){
//       postList.add(PostsModel.fromJson(i));
//     }
//     return postList;
//   }else{
//     return postList;
//   }
// }
var data;

Future<void> getPostApi() async{
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
  data = jsonDecode(response.body);
  if (response.statusCode == 200){
    print("Successfully Get Data");
  }else{
    print("Failed");
  }
  return data;
}




class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text("Rest Api Get Data"),
    //   ),
    //   body: Column(
    //     children: [
    //       Expanded(
    //         child: FutureBuilder(
    //           future: getPostApi(),
    //           builder: (context, snapshot){
    //             if(!snapshot.hasData){
    //               return Text("Loading");
    //             }else{
    //               return ListView.builder(
    //               itemCount: postList.length,
    //               itemBuilder: (context, index){
    //                return Card(
    //                  child: Padding(
    //                    padding: const EdgeInsets.all(8.0),
    //                    child: Column(
    //                      mainAxisAlignment: MainAxisAlignment.start,
    //                      crossAxisAlignment: CrossAxisAlignment.start,
    //                      children: [
    //                        Text("Title", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),),
    //                        Text(postList[index].title.toString()),
    //                        Text("Description", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),),
    //                        Text(postList[index].body.toString())
    //                      ],
    //                    ),
    //                  ),
    //                );
    //             });
    //             }
    //           }
    //         ),
    //       )
    //     ],
    //   ),
    // );



    return Scaffold(
      appBar: AppBar(
        title: Text("Rest Api Get Data"),
      ),
      body:Column(
        children: [
          FutureBuilder(
              future: getPostApi(),
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Text("Loading");
                }else{
                  return Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index){
                        return Column(
                          children: [
                            Text("Title", style: TextStyle(fontWeight: FontWeight.bold),),
                            Text(data[index]['title'].toString()),
                            Text("Body", style: TextStyle(fontWeight: FontWeight.bold),),
                            Text(data[index]['body'].toString())
                          ],
                        );
                        ;
                      },
                    ),
                  );
                }
              }
          ),
          // Expanded(
          //   child: FutureBuilder(
          //     future: getPostApi(),
          //     builder: (context, snapshot){
          //       if(!snapshot.hasData){
          //         return Text("Loading");
          //       }else{
          //         return ListView.builder(
          //         itemCount: data.length,
          //         itemBuilder: (context, index){
          //          return Card(
          //            child: Padding(
          //              padding: const EdgeInsets.all(8.0),
          //              child: Column(
          //                mainAxisAlignment: MainAxisAlignment.start,
          //                crossAxisAlignment: CrossAxisAlignment.start,
          //                children: [
          //                  Text("Title", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),),
          //                  Text(data[index].title.toString())
          //                ],
          //              ),
          //            ),
          //          );
          //       });
          //       }
          //     }
          //   ),
          // )
        ],
      )
    );
  }
}
