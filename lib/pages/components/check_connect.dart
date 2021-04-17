import 'package:flutter/material.dart';
import 'package:mybooks/pages/components/toast.dart';
import 'package:connectivity/connectivity.dart';

Future<bool> checkConnect(BuildContext context) async {
  ConnectivityResult result = await Connectivity().checkConnectivity();
  if (result == ConnectivityResult.none) {
    showToast(context, '没有联网呀？', type: ToastType.ERROR);
    return false;
  }
  return true;
}
