import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'Models/PostModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  List<PostModel> PostList = [];
  Future<List<PostModel>> getPostApi()async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200)
      {
        PostList.clear();
        for(Map i in data){
          PostList.add(PostModel.fromJson(i));
        }
        return PostList;
      }

    else
      {
        return PostList;
      }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Center(child: Text('Api Starting')),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPostApi(),
              builder: (context,snapshot) {
                if(!snapshot.hasData)
                  {
                    return Text('Loading');
                  }
                else
                  {
                    return ListView.builder(
                      itemCount: PostList.length,
                      itemBuilder: (context,index){
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Title',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                  ),),
                                SizedBox(height: 5),
                                Text(PostList[index].title.toString()),
                                SizedBox(height: 10),
                                Text('Body',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),),
                                SizedBox(height: 5),
                                Text(PostList[index].body.toString()),
                                SizedBox(height: 10),
                                Text('UserID',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),),
                                Text(PostList[index].userId.toString())
                              ],
                            ),
                          ),
                        );
                      }
                    );
                  }
              },
            ),
          )
        ],
      ),
    );
  }
}
