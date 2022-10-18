import 'package:flutter/material.dart';

var this_year = DateTime.now().year.toString();

class AppConfig {
  static String copyright_text = " Relax " +
      this_year; //this shows in the splash screen
  static String app_name =
      "Relax"; //this shows in the splash screen
  static String hotline_number =
      "+94 77 1 123 123"; //this is the hotline number
  static String whatsapp_number = "+94772099074"; //this is the whastapp number
  static String phone_number = "+94772099074"; //this is the whastapp number
  static String mail_id =
      "info@relax.com"; //this is the whastapp number
  static String whatsapp_message =
      "Hello, Relax.."; //this is sent as the whastsapp custom message
  static String purchase_code =
      "f87874fb-5000-4d29-a1fe-c5fdd3e8877b"; //enter your purchase code for the app from codecanyon
  //static String purchase_code = ""; //enter your purchase code for the app from codecanyon

  //configure this
  static const bool HTTPS = false;

  //configure this
  static const DOMAIN_PATH = "10.0.2.2:3000"; //localhost
  //static const DOMAIN_PATH = "demo.activeitzone.com/ecommerce_flutter_demo"; //inside a folder
  //static const DOMAIN_PATH = "something.com"; // directly inside the public folder

  //do not configure these below
  static const String API_ENDPATH = "api/";
  static const String PUBLIC_FOLDER = "public";
  static const String PROTOCOL = HTTPS ? "https://" : "http://";
  static const String RAW_BASE_URL = "${PROTOCOL}${DOMAIN_PATH}";
  static const String BASE_URL = "${RAW_BASE_URL}/${API_ENDPATH}";

  //configure this if you are using amazon s3 like services
  //give direct link to file like https://[[bucketname]].s3.ap-southeast-1.amazonaws.com/
  //otherwise do not change anythink
  static const String BASE_PATH = "${RAW_BASE_URL}/${PUBLIC_FOLDER}/";
  //static const String BASE_PATH = "https://tosoviti.s3.ap-southeast-2.amazonaws.com/";
}
