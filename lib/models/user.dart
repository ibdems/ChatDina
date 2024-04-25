import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
class User{
  int id;
  String firstName;
  String lastName;
  String email;
  String image;

 
  User({required this.email,required this.id,required this.firstName,required this.lastName,required this.image,});

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      email: json['email'],
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      image: json['avatar']
    );
  }
}

Future<void> getUsers({int page =1, required PagingController<int, User> pagingController}) async {
  List<User> users = [];

  //Future<http.Response> response = await http.get(Uri.parse(""));

  http.Response response =
      await http.get(Uri.parse("https://reqres.in/api/users?page=$page&per_page=4"));

  if (response.statusCode == 200) {
    dynamic data = jsonDecode(response.body);
    List newdata =data['data'];

    newdata.forEach((element){
        users.add(User.fromJson(element));
    });
  
    if(users.length <4){
      pagingController.appendLastPage(users);
    }else{
      final nextPageKey = page + 1;
        pagingController.appendPage(users, nextPageKey);
    }
  }
 
}