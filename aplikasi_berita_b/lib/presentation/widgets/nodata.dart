import 'package:aplikasi_berita_b/common/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

class NoData extends StatelessWidget {
  final String message;
  NoData({required this.message});
  @override
  Widget build(BuildContext context) {
    return _buildNoData(context, message);
  }

  Widget _buildNoData(BuildContext context, String message) {
    return Container(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Lottie.asset(
        'assets/nodata.json',
        width: 200,
        height: 200,
        fit: BoxFit.fill,
        repeat: false,
        reverse: false,
        animate: false,
      ),
      SizedBox(height: 8),
      Text(message, style: primaryTextStyle)
    ]));
  }
}
