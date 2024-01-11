import 'package:absumarket/utils/myutils.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SellerService {
  void followOnFb(BuildContext context) async {
    var uri =
        Uri.parse("https://www.facebook.com/profile.php?id=61554972494548");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      errorSnack(context, 'Something Went Wrong', 'Error occurred');
    }
  }

  void followOnWhatsapp(BuildContext context) async {
     var uri =
        Uri.parse("https://whatsapp.com/channel/0029VaJIJ9O9RZASZSWrjj3d");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      errorSnack(context, 'Something Went Wrong', 'Error occurred');
    }
  }


  void followOnX(BuildContext context) async {
     var uri =
        Uri.parse("https://x.com/absumarket?t=km25OTY1rldrf7pmjMlHTw&s=09");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      errorSnack(context, 'Something Went Wrong', 'Error occurred');
    }
  }
  void followOnInstagrams(BuildContext context) async {}
  /*
import 'package:cloud_firestore/cloud_firestore.dart';

class SellerModel {
  // ... other properties

  SellerModel({
    // ... other constructor parameters
    required this.buyLicencesDate,
  });

  // ... other methods

  int calculateDaysSinceRegistration() {
    // Get the current Timestamp
    Timestamp currentDate = Timestamp.now();

    // Calculate the difference in milliseconds
    int differenceInMilliseconds =
        currentDate.millisecondsSinceEpoch - buyLicencesDate.millisecondsSinceEpoch;

    // Convert milliseconds to days
    int differenceInDays = (differenceInMilliseconds / (24 * 60 * 60 * 1000)).round();

    return differenceInDays;
  }

  bool isPaymentDue() {
    // Check if the difference is greater than 30 days
    return calculateDaysSinceRegistration() > 30;
  }
}

  */
}
