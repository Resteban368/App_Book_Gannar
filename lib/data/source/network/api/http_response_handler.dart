// ignore_for_file: avoid_print, unnecessary_null_comparison

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';

import '../../../../config/theme/app_theme.dart';
import 'package:flutter/material.dart';

import '../exceptions/unauthorize_exception.dart';

class HttpResponseHandler {
  final BuildContext context;

  HttpResponseHandler(this.context);

  Future handleHttpResponse(Future<Response> httpCall) async {
    var response = await httpCall;
    print('HandleHttpResponse:: ${response.statusCode}');
    switch (response.statusCode) {
      case 200:
        return response;
      case 201:
        return response;
      case 422:
        _handle422(response);
        return response;
      case 440:
        throw UnauthorizedException(response.body);
      case 500:
        return response;
      default:
        var message = jsonDecode(response.body)["message"];
        _showErrorSnackBar([message]);
    }
  }

  _handle422(Response response) {
    // var message = jsonDecode(response.body)["message"];
    Map<String, dynamic> errors = jsonDecode(response.body)["errors"];
    var errorList = <String>[];

    var t = errors.values.map((e) => e as List<dynamic>);
    for (var element in t) {
      for (var e in element) {
        errorList.add(e as String);
      }
    }
    _showErrorSnackBar(errorList);
  }

  void _showErrorSnackBar(List<String> errorList) {
    final snackBar = SnackBar(
      showCloseIcon: true,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: errorList.map((error) => Text(error)).toList(),
      ),
      backgroundColor: MyColors.primary,
      behavior: SnackBarBehavior.floating,
    );

    if (context != null) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
