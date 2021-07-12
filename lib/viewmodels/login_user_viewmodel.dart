// import 'dart:convert';

// import 'package:Batch_256/components/custom_snackbar.dart';
// import 'package:Batch_256/models/login_model.dart';
// import 'package:Batch_256/models/response_unsuccsess.dart';
// import 'package:Batch_256/utilities/networking/networking_response.dart';
// import 'package:Batch_256/utilities/repositories/api_repository.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class LoginUserViewModel {
//   LoginUserViewModel();

//   Future<LoginModel> postDataToAPI(
//       BuildContext context, String email, String password) async {
//     NetworkingResponse response =
//         await APIRepository().loginUser(email, password);
//     if (response is NetworkingSuccess) {
//       if (response.statusCode == 200) {
//         LoginModel model = loginModelFromJson(response.body);
//         return model;
//       } else if (response.statusCode == 400) {
//         var error = jsonDecode(response.body);
//         print('Status code : ${response.statusCode}');
//         print('Message : ${response.body}');
//         ScaffoldMessenger.of(context)
//             .showSnackBar(customSnackBar(error['error']));
//         return null;
//       } else {
//         print('Status code : ${response.statusCode}');
//         print('Message : ${response.body}');
//         ResponseUnsuccess responseUnsuccess =
//             responseUnsuccessFromJson(response.body);
//         String message = responseUnsuccess.message + '[${response.statusCode}]';

//         ScaffoldMessenger.of(context).showSnackBar(customSnackBar(message));
//         return null;
//       }
//     } else if (response is NetworkingException) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(customSnackBar(response.message));
//       return null;
//     }
//   }
// }
