// 登录接口api
import 'package:flutter_hmshop/constants/index.dart';
import 'package:flutter_hmshop/utils/DioRequset.dart';
import 'package:flutter_hmshop/viewmodels/user.dart';

Future<UserInfo> loginAPI (Map<String, dynamic> data) async {
  return UserInfo.fromJSON(
    await dioRequest.post(HttpConstants.LOGIN, data: data)
  );
}

Future<UserInfo> getUserInfoAPI () async {
  return UserInfo.fromJSON(
    await dioRequest.get(HttpConstants.USER_PROFILE)
  );
}