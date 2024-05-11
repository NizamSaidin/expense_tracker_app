import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

enum APIResponse {
  success,
  badRequest,
  authenticationFailure,
}

enum Method { get, post, put, delete, patch }

class BaseAPI {
  BaseAPI({httpClient}) {
    this.httpClient = httpClient ?? http.Client();
  }

  late http.Client httpClient;

  /// The Headers
  Map<String, String> get headers => {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.acceptHeader: "application/json",
      };

  String transformParams(Map<String, dynamic>? params) {
    return Uri(queryParameters: params).query;
  }

  Future<Map<String, dynamic>> request({
    required String url,
    required Method method,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? body,
  }) async {
    http.Response? response;

    Map<String, dynamic> queryParameters = {};
    if ((queryParams ?? {}).isNotEmpty) {
      queryParams!.forEach((key, value) {
        queryParameters[key] = value.toString();
      });
    }
    String queryString = Uri(queryParameters: queryParameters).query;
    Uri uri = queryString.isNotEmpty ? Uri.parse('$url?$queryString') : Uri.parse(url);

    try {
      switch (method) {
        case Method.get:
          response = await httpClient.get(uri, headers: headers);
          break;
        case Method.post:
          response = await httpClient.post(uri, headers: headers, body: json.encode(body));
          break;
        case Method.put:
          response = await httpClient.put(uri, headers: headers, body: json.encode(body));
          break;
        case Method.delete:
          response = await httpClient.delete(uri, headers: headers, body: json.encode(body));
          break;
        case Method.patch:
          response = await httpClient.patch(uri, headers: headers, body: json.encode(body));
          break;
      }

      return parseResponse(response);
    } catch (e) {
      debugPrint(e.toString());
    }

    return parseResponse(null);
  }

  Future<Map<String, dynamic>> parseResponse(http.Response? response) async {
    Map<String, dynamic> jsonData = {'status': APIResponse.badRequest, 'result': {}};

    if (response == null) {
      return jsonData;
    }

    if (response.body.isNotEmpty) {
      jsonData['result'] = json.decode(response.body);
    }

    switch (response.statusCode) {
      case 200:
      case 201:
        jsonData['status'] = APIResponse.success;
      case 401:
        jsonData['status'] = APIResponse.authenticationFailure;
      case 400:
      case 404:
      case 422:
        jsonData['status'] = APIResponse.badRequest;
      default:
        jsonData['status'] = APIResponse.authenticationFailure;
    }

    return jsonData;
  }
}
