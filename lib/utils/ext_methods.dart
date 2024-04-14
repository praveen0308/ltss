import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:tuple/tuple.dart';

extension ListExtentions<T> on List<T> {
  String listToString() => join(',').toString();
}

extension CustomValidationBuilder on ValidationBuilder {
  password() => add((value) {
        if (value == 'password') {
          return 'Password should not "password"';
        }
        return null;
      });
}

extension FileExtensions on File {
  String getFileSizeString({int decimals = 0}) {
    const suffixes = ["b", "kb", "mb", "gb", "tb"];
    var i = (log(lengthSync()) / log(1024)).floor();
    return ((lengthSync() / pow(1024, i)).toStringAsFixed(decimals)) +
        suffixes[i];
  }

  String getFileName() {
    return path.split('/').last;
  }
}

extension UIExtentions on State {
  void showSnackBar(BuildContext context, String? message,
      {SnackBarAction? action}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message ?? ""),
      action: action,
    ));
  }
}

extension LeadingExtension on String {
  String take(int i) {
    return substring(0, i);
  }
  String takeLast(int i) {
    return substring(length-i, length);
  }

}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

extension NullSafeBlock<T> on T? {
  void let(Function(T it) runnable) {
    final instance = this;
    if (instance != null) {
      runnable(instance);
    }
  }
}

List<String> splitStringByParentheses(String input) {
  List<String> result = [];
  RegExp regExp = RegExp(r'\(([^)]*)\)');

  // Use the allMatches method to find all occurrences of the regular expression
  Iterable<Match> matches = regExp.allMatches(input);

  // Iterate through matches and add the content inside the parentheses to the result list
  for (Match match in matches) {
    result.add(match.group(1)!);
  }

  return result;
}

List<Tuple2<String,String>> splitIntoTuples(String input) {
  var splitStrs = splitStringByParentheses(input);
  var records = List<Tuple2<String,String>>.empty(growable: true);
  for(var str in splitStrs){
    var keyVal = str.split(",");
    records.add(Tuple2(keyVal[0],keyVal[1]));

  }
  return records;
}

extension ListExtensions<T> on List<T>?{
  List<T> orEmpty()=> this??List<T>.empty();
}