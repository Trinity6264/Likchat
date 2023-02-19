import 'package:flutter/material.dart';

// error banner
void showBanner(BuildContext _) {
  ScaffoldMessenger.of(_).showMaterialBanner(
    const MaterialBanner(
      backgroundColor: Colors.purpleAccent,
      content: Text(
        'Please  can\'t send an empty message',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      actions: [
        Icon(
          Icons.error_outline,
          color: Colors.white,
        )
      ],
    ),
  );
  Future.delayed(
    const Duration(seconds: 5),
    () {
      ScaffoldMessenger.of(_).clearMaterialBanners();
    },
  );
}

// no internet connection banner
void showInternetBanner(BuildContext _, String mes) {
  ScaffoldMessenger.of(_).showMaterialBanner(
    MaterialBanner(
      backgroundColor: Colors.red,
      content: Text(
        mes,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      actions: const [
        Icon(
          Icons.wifi_off,
          color: Colors.white,
        )
      ],
    ),
  );
}

// no internet connection banner
void closeInternetBanner(BuildContext _) {
  ScaffoldMessenger.of(_).clearMaterialBanners();
}
