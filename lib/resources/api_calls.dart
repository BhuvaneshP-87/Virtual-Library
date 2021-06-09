import 'dart:async';
import 'package:http/http.dart' show Client;
import 'dart:convert';


class ApiCalls {
  Client client = Client();
  var _apiKey = 'AIzaSyAq9QwhgkuaUsQmk3fQT-RUbgttmQWl_4k';

  Future getCategory({final category, final startIndex}) async {
    try {
      final response = await client.get(
          "https://www.googleapis.com/books/v1/volumes?q=$category+incategory:$category&maxResults=40&startIndex=$startIndex&key=$_apiKey");
      if (response.statusCode == 200) {
        // Task was successful, parse the data from server as JSON
        return json.decode(response.body);
      } else {
        // Task failed, throw an error.
        throw Exception('Failed to fetch data');
      }
    }
    //Unexpected error occurs
    catch (error) {
      print(error);
    }
  }

  Future getBook({final title, final startIndex}) async {
    try {
      final response = await client.get(
          "https://www.googleapis.com/books/v1/volumes?q=$title+intitle:$title&maxResults=40&startIndex=$startIndex&orderBy=newest&key=$_apiKey");
      if (response.statusCode == 200) {
        // Task was successful, parse the data from server as JSON
        return json.decode(response.body);
      } else {
        // Task failed, throw an error.
        throw Exception('Failed to fetch data');
      }
    }
    //Unexpected error occurs
    catch (error) {
      print(error);
    }
  }

  Future getBookISBN({String isbn}) async {
    try {
      final response = await client.get(
          "https://www.googleapis.com/books/v1/volumes?q=$isbn+isbn:$isbn&maxResults=40&key=$_apiKey");
      if (response.statusCode == 200) {
        // Task was successful, parse the data from server as JSON
        return json.decode(response.body);
      } else {
        // Task failed, throw an error.
        throw Exception('Failed to fetch data');
      }
    }
    //Unexpected error occurs
    catch (error) {
      print(error);
    }
  }

  Future getBookDetails({final id}) async {
    try {
      final response = await client.get(
          "https://www.googleapis.com/books/v1/volumes/$id");
      if (response.statusCode == 200) {
        // Task was successful, parse the data from server as JSON
        return json.decode(response.body);
      } else {
        // Task failed, throw an error.
        throw Exception('Failed to fetch data');
      }
    }
    //Unexpected error occurs
    catch (error) {
      print(error);
    }
  }
}