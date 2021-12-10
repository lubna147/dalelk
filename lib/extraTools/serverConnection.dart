import 'dart:convert';

import 'package:dalelk/UserFiles/newAdvertise.dart';
import 'package:dalelk/UserFiles/userClass.dart';
import 'package:dalelk/advertise/advertiseClass.dart';
import 'package:dalelk/extraTools/pharmacesClass.dart';
import 'package:dalelk/jobs/jobClass.dart';
import 'package:dalelk/medical/medicalItemClass.dart';
import 'package:dalelk/medical/medicalTypesClass.dart';
import 'package:dalelk/mony/monyClass.dart';
import 'package:http/http.dart' as http;

class server {
  String url = 'https://dalelalbab.xyz/api';
  late String subUrl;
  late List temp;
  List<advertiseClass> list = [];
  List<medicalTypesClass> medTypeList = [];
  List<medicalItemClass> medList = [];
  Map<String, String> headers = {"Content-type": "application/json"};
  Map<String, String> headersFile = {
    "Content-type": "multipart/form-data",
    "Accept": "application/json"
  };
  Future<List<advertiseClass>> getMoreAdvertise(int id) async {
    list.clear();
    subUrl = url + '/getLastBId/$id';
    final response = await http.get(Uri.parse(subUrl));
    var responseData = json.decode(response.body);
    print(response.body);
    temp = responseData['data'];
    print(temp);
    temp.forEach((element) {
      list.add(new advertiseClass(
          element['id'],
          element['name'],
          element['title'],
          element['palce'],
          element['contact_num'],
          element['price'],
          element['image_path'],
          element['description'],
          element['monyType']));
    });
    return list;
  }

  Future<bool> addNewAdvertise(Map<String, String> body, filename) async {
    subUrl = url + '/store';
    print(body);
    print(filename);
    var request = http.MultipartRequest('POST', Uri.parse(subUrl));
    request.fields.addAll(body);

    request.headers.addAll(headersFile);
    request.files
        .add(await http.MultipartFile.fromPath('image_path', filename));
    var res = await request.send();
    if (res.statusCode == 200 || res.statusCode == 201)
      return true;
    else
      return false;
    print(res.statusCode);
    print(res.reasonPhrase);
    print(res.request);
    res.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }

  Future<bool> updateAdvertise(
      Map<String, String> body, filename, int id) async {
    subUrl = url + '/updateAdvertise/$id?_method=PUT';
    //  print(body);
    print(filename);
    print("editAd");
    print('eeeeeeeeeeeeddddddddddddddddddddiiiiiiiiiiiiiiitttttttttttteeeeee');
    var request = http.MultipartRequest('Post', Uri.parse(subUrl));
    request.fields.addAll(body);

    request.headers.addAll(headersFile);
    if (filename == 'file.txt')
      ;
    else {
      request.files
          .add(await http.MultipartFile.fromPath('image_path', filename));
    }
    var res = await request.send();
    if (res.statusCode == 200 || res.statusCode == 201)
      return true;
    else
      return false;
    //   print(res.statusCode);
    //   print(res.reasonPhrase);
    print(res.request);
    res.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }

  Future<List<advertiseClass>> getAllAdvertises() async {
    list.clear();
    subUrl = url + '/getLastAdvertises';
    final response = await http.get(Uri.parse(subUrl));
    var responseData = json.decode(response.body);
    print(response.body);
    temp = responseData['data'];
    print(temp);
    temp.forEach((element) {
      list.add(new advertiseClass(
          element['id'],
          element['name'],
          element['title'],
          element['palce'],
          element['contact_num'],
          element['price'],
          element['image_path'],
          element['description'],
          element['monyType']));
    });
    return list;
  }

  Future<List<advertiseClass>> getAdvertisebyType(int type) async {
    list.clear();
    subUrl = url + '/getSpicificByClass/$type';
    final response = await http.get(Uri.parse(subUrl));
    var responseData = json.decode(response.body);
    print(response.body);
    temp = responseData['data'];
    print(temp);
    temp.forEach((element) {
      list.add(new advertiseClass(
          element['id'],
          element['name'],
          element['title'],
          element['palce'],
          element['contact_num'],
          element['price'],
          element['image_path'],
          element['description'],
          element['monyType']));
    });
    return list;
  }

  Future<List<advertiseClass>> getfavouraiteAdvertise(List<int> fav) async {
    list.clear();
    print(fav);
    fav.insert(0, 0);
    print(fav);

    subUrl = url + '/getFavouraite/$fav';
    final response = await http.get(Uri.parse(subUrl));
    var responseData = json.decode(response.body);
    print(response.body);
    temp = responseData['data'];
    print('teeeeeeeeeeeeeeeeeeemmmmmmmmmmmmmmmmmmmmmmmmppppppppppppppppppp');
    print(temp);
    temp.forEach((element) {
      list.add(new advertiseClass(
          element['id'],
          element['name'],
          element['title'],
          element['palce'],
          element['contact_num'],
          element['price'],
          element['image_path'],
          element['description'],
          element['monyType']));
    });
    return list;
  }

  Future<List<advertiseClass>> getAdvertisebyTypeSearch(
      int type, String search) async {
    list.clear();
    subUrl = url + '/getByClassSearch/$type/$search';
    final response = await http.get(Uri.parse(subUrl));
    var responseData = json.decode(response.body);
    print(response.body);
    temp = responseData['data'];
    print(temp);
    temp.forEach((element) {
      list.add(new advertiseClass(
          element['id'],
          element['name'],
          element['title'],
          element['palce'],
          element['contact_num'],
          element['price'],
          element['image_path'],
          element['description'],
          element['monyType']));
    });
    return list;
  }

  Future<List<advertiseClass>> getAdvertisebyUserSearch(
      int id, String search) async {
    list.clear();
    subUrl = url + '/getByUserSearch/$id/$search';
    final response = await http.get(Uri.parse(subUrl));
    var responseData = json.decode(response.body);
    print(response.body);
    temp = responseData['data'];
    print(temp);
    temp.forEach((element) {
      list.add(new advertiseClass(
          element['id'],
          element['name'],
          element['title'],
          element['palce'],
          element['contact_num'],
          element['price'],
          element['image_path'],
          element['description'],
          element['monyType']));
    });
    return list;
  }

  Future<List<advertiseClass>> getAdvertisebyUser(int id) async {
    list.clear();
    subUrl = url + '/getSpicificByUser/$id';
    final response = await http.get(Uri.parse(subUrl));
    var responseData = json.decode(response.body);
    print(response.body);
    temp = responseData['data'];
    print(temp);
    temp.forEach((element) {
      list.add(new advertiseClass(
          element['id'],
          element['name'],
          element['title'],
          element['palce'],
          element['contact_num'],
          element['price'],
          element['image_path'],
          element['description'],
          element['monyType']));
    });
    return list;
  }

  Future<bool> deletAdvertise(int id) async {
    subUrl = url + '/delete/$id';
    final response = await http.delete(Uri.parse(subUrl));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.request);

      return true;
    } else
      return false;
  }

  Future<List<medicalTypesClass>> getDoctorTypes() async {
    subUrl = url + '/getDoctorTypes';
    final response = await http.get(Uri.parse(subUrl));
    var responseData = json.decode(response.body);
    print(response.body);
    temp = responseData['data'];
    temp.forEach((element) {
      medTypeList.add(new medicalTypesClass(element['id'], element['name']));
    });

    return medTypeList;
  }

  Future<List<medicalItemClass>> getMedicalsByType(int type) async {
    List<medicalItemClass> medList = [];
    subUrl = url + '/getMedByType/$type';
    final response = await http.get(Uri.parse(subUrl));
    var responseData = json.decode(response.body);
    print(response.body);
    temp = responseData['data'];
    temp.forEach((element) {
      medList.add(new medicalItemClass(element['id'], element['name'],
          element['adress'], element['phone_num'], element['file']));
    });
    print(medList);
    return medList;
  }

  Future<List<medicalItemClass>> getMedicalsBySpectial(int type) async {
    List<medicalItemClass> medList = [];
    subUrl = url + '/getMedBySpectial/$type';
    final response = await http.get(Uri.parse(subUrl));
    var responseData = json.decode(response.body);
    print(response.body);
    temp = responseData['data'];
    temp.forEach((element) {
      medList.add(new medicalItemClass(element['id'], element['name'],
          element['adress'], element['phone_num'], element['file']));
    });
    print(medList);
    return medList;
  }

  Future<List<medicalItemClass>> getMedByTypeSearch(
      int type, String search) async {
    List<medicalItemClass> medList = [];
    subUrl = url + '/getMedByTypeSearch/$type/$search';
    final response = await http.get(Uri.parse(subUrl));
    var responseData = json.decode(response.body);
    print(response.body);
    temp = responseData['data'];
    temp.forEach((element) {
      medList.add(new medicalItemClass(element['id'], element['name'],
          element['adress'], element['phone_num'], element['file']));
    });
    print(medList);
    return medList;
  }

  Future<List<medicalItemClass>> getMedBySpectialSearch(
      int type, String search) async {
    List<medicalItemClass> medList = [];
    subUrl = url + '/getMedBySpectialSearch/$type/$search';
    final response = await http.get(Uri.parse(subUrl));
    var responseData = json.decode(response.body);
    print(response.body);
    temp = responseData['data'];
    temp.forEach((element) {
      medList.add(new medicalItemClass(element['id'], element['name'],
          element['adress'], element['phone_num'], element['file']));
    });
    print(medList);
    return medList;
  }

  Future<userClass> getUserId(String userName, String passWord) async {
    int id = 0;
    late userClass user;
    subUrl = url + '/findUser/$userName/$passWord';
    final response = await http.get(Uri.parse(subUrl));
    var responseData = json.decode(response.body);
    print(response.body);
    temp = responseData['data'];
    if (temp.isEmpty)
      user = new userClass(0, '', '', '');
    else {
      user = new userClass(temp[0]['id'], temp[0]['shopeName'],
          temp[0]['shopeNumber'], temp[0]['shopLocation']);
    }
    return user;
  }

  Future<List<pharmacesClass>> getPharmaces() async {
    List<pharmacesClass> list = [];
    String pharmaces = '';
    subUrl = url + '/getPharmaces';
    final response = await http.get(Uri.parse(subUrl));
    var responseData = json.decode(response.body);
    print(response.body);
    temp = responseData['data'];
    print(temp);
    temp.forEach((element) {
      if (element['name'] == null)
        ;
      else
        list.add(new pharmacesClass(element['name'], element['palce']));
    });
    print('pharmacessssssssssssssssssssssssssssssssssssssssssssssssss');
    print(list);
    return list;
  }

  getMony() async {
    List<monyClas> mony = [];

    mony.clear();
    int i = 0;
    subUrl = url + '/getMony';
    final response = await http.get(Uri.parse(subUrl));
    var responseData = json.decode(response.body);
    print(response.body);
    temp = responseData['data'];
    temp.forEach((element) {
      mony.add(new monyClas(element['sale'], element['buy'],
          int.parse(element['state']), element['updated_at']));
    });
    print(mony[0].time);

    return mony;
  }

  Future<bool> postjob(Map<String, String> bodyNew) async {
    subUrl = url + '/storeJob';
    final response = await http.post(Uri.parse(subUrl),
        headers: headers, body: jsonEncode(bodyNew));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('doooooooonnnnnnnnnnnnnneeeeeeeeeee');
      return true;
    } else {
      print(response.statusCode);
      print(response.body);
      print('nnnnooooooooooot');
      return false;
    }
  }

  Future<List<jobClass>> getJobs() async {
    List<jobClass> jobs = [];
    subUrl = url + '/getjobs';
    final response = await http.get(Uri.parse(subUrl));
    var responseData = json.decode(response.body);
    print(response.body);
    temp = responseData['data'];
    temp.forEach((element) {
      jobs.add(new jobClass(
          element['id'],
          element['advertiser'],
          element['title'],
          element['place'],
          element['phone'],
          element['det']));
    });
    return jobs;
  }

  Future<List<jobClass>> getJobsSearch(String job) async {
    List<jobClass> jobs = [];
    subUrl = url + '/getJobSearch/$job';
    final response = await http.get(Uri.parse(subUrl));
    var responseData = json.decode(response.body);
    print(response.body);
    temp = responseData['data'];
    temp.forEach((element) {
      jobs.add(new jobClass(
          element['id'],
          element['advertiser'],
          element['title'],
          element['place'],
          element['phone'],
          element['det']));
    });
    return jobs;
  }

  getContactNum() async {
    List<String> nums = [];
    subUrl = url + '/getContactNum';
    final response = await http.get(Uri.parse(subUrl));
    var responseData = json.decode(response.body);
    print(response.body);
    temp = responseData['data'];
    temp.forEach((element) {
      nums.add(element['phone']);
    });
    return nums;
  }

  getContactNumMony() async {
    List<String> nums = [];
    subUrl = url + '/getContactNumMony';
    final response = await http.get(Uri.parse(subUrl));
    var responseData = json.decode(response.body);
    print(response.body);
    temp = responseData['data'];
    temp.forEach((element) {
      nums.add(element['phone']);
    });
    return nums;
  }

  getImage() async {
    String img = '';
    subUrl = url + '/getImage';
    final response = await http.get(Uri.parse(subUrl));
    var responseData = json.decode(response.body);
    print(response.body);
    temp = responseData['data'];
    img = temp[0]['name'];
    return img;
  }
}
