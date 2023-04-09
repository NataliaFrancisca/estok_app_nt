import 'dart:convert' as convert;
import 'dart:io';

import 'package:estok_app_natalia_francisca/entities/user.dart';
import 'package:estok_app_natalia_francisca/repository/local/user_repository.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

class UploadApi{
  static final UploadApi instance = UploadApi._();
  UploadApi._();

  Future<String> upload(File file) async{
    try{
      String url = 'http://54.90.203.92/images/upload';
      User user = await UserRepository.instance.getUsuario();
      String authorization = 'Bearer ${user.token}';

      print(authorization);

      List<int> imageBytes = file.readAsBytesSync();
      String imageBase64 = convert.base64Encode(imageBytes);
      String fileName = path.basename(file.path);

      var parameters = {
        'file_name': fileName,
        'mime_type': 'image/jpeg',
        'base64': imageBase64
      };

      var encode = convert.json.encode(parameters);

      var response = await http.post(url,
        headers: {
          'Content-type': 'application/json',
          'Authorization': authorization
        },
        body: encode
      ).timeout(Duration(seconds: 120),
        onTimeout: (){
          print("LOG[UploadApi.uploadFile] - onTimeout");
          throw SocketException('Não foi possível se comunicar com o servidor');
        }
      );

      if(response.statusCode == 200){
        var responseData = convert.json.decode(convert.utf8.decode(response.bodyBytes));
        String urlImage = responseData['data']['url_image'];
        return urlImage;
      }else{
        return null;
      }

    } on Exception catch (error){
      return null;
    }
  }
}