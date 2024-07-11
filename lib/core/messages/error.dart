import 'package:flutter/material.dart';

enum ErrorMessages {
  empty(msg: '빈칸이 존재합니다.'),
  invalidEmail(msg: '이메일이 유효하지 않습니다.'),
  invalidLoginCredentials(msg: '이메일 도는 비밀번호가 일치하지 않습니다.'),
  weakPassword(msg: '비밀번호의 너무 쉽습니다.'),
  emailAlreadyInUse(msg: '이미 사용중인 이메일입니다.');

  final String msg;

  const ErrorMessages({required this.msg});

  SnackBar get snackBar => SnackBar(content: Text(msg));
}
