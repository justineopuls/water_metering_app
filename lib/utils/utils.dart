import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:collection';
import 'package:table_calendar/table_calendar.dart';
import 'package:exif/exif.dart';
import 'package:geocoding/geocoding.dart';

pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();

  XFile? _file = await _imagePicker.pickImage(source: source);

  if (_file != null) {
    return await _file.readAsBytes();
  }
  print('No image selected.');
  return null;
}

showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}

// Home Page Calendar Utils
class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = Map.fromIterable(List.generate(50, (index) => index),
    key: (item) => DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5),
    value: (item) => List.generate(
        item % 4 + 1, (index) => Event('Event $item | ${index + 1}')))
  ..addAll({
    kToday: [
      Event('Today\'s Event 1'),
      Event('Today\'s Event 2'),
    ],
  });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

Future<String> getExifLocation(Uint8List? file) async {
  final data = await readExifFromBytes(file!);

  if (data.isEmpty) {
    print("No EXIF information found");
    return '';
  }

  if (data.containsKey('JPEGThumbnail')) {
    print('File has JPEG thumbnail');
    data.remove('JPEGThumbnail');
  }
  if (data.containsKey('TIFFThumbnail')) {
    print('File has TIFF thumbnail');
    data.remove('TIFFThumbnail');
  }

  for (final entry in data.entries) {
    print("${entry.key}: ${entry.value}");
  }
  final latitudeValue = data['GPS GPSLatitude']
      ?.values
      .toList()
      .map<double>(
          (item) => (item.numerator.toDouble() / item.denominator.toDouble()))
      .toList();

  final latitudeSignal = data['GPS GPSLatitudeRef']?.printable;

  final longitudeValue = data['GPS GPSLongitude']
      ?.values
      .toList()
      .map<double>(
          (item) => (item.numerator.toDouble() / item.denominator.toDouble()))
      .toList();
  final longitudeSignal = data['GPS GPSLongitudeRef']?.printable;

  double latitude =
      latitudeValue![0] + (latitudeValue[1] / 60) + (latitudeValue[2] / 3600);

  double longitude = longitudeValue![0] +
      (longitudeValue[1] / 60) +
      (longitudeValue[2] / 3600);

  if (latitudeSignal == 'S') latitude = -latitude;
  if (longitudeSignal == 'W') longitude = -longitude;

  print(latitude);
  print(longitude);

  List<Placemark> placemarks =
      await placemarkFromCoordinates(latitude, longitude);
  print(placemarks);
  Placemark place = placemarks[0];
  print('${place.locality}, ${place.subAdministrativeArea}, ${place.country}');
  String photoLocation =
      '${place.locality}, ${place.subAdministrativeArea}, ${place.country}';
  return photoLocation;
}

Future<String> getExifDateTime(Uint8List? file) async {
  final data = await readExifFromBytes(file!);

  if (data.isEmpty) {
    print("No EXIF information found");
    return '';
  }

  if (data.containsKey('JPEGThumbnail')) {
    print('File has JPEG thumbnail');
    data.remove('JPEGThumbnail');
  }
  if (data.containsKey('TIFFThumbnail')) {
    print('File has TIFF thumbnail');
    data.remove('TIFFThumbnail');
  }

  for (final entry in data.entries) {
    print("${entry.key}: ${entry.value}");
  }

  // var dateTime = data['Image DateTime'].toString().split(' ');
  // print(dateTime[0]);
  // print(dateTime[1]);
  // DateTime dateTimeParse = DateTime.parse(data['Image DateTime'].toString());
  // print(dateTimeParse);
  var date = data['Image DateTime'].toString();
  String regex =
      r'[^\p{Alphabetic}\p{Mark}\p{Decimal_Number}\p{Connector_Punctuation}\p{Join_Control}\s]+';
  date = date.replaceAll(RegExp(regex, unicode: true), '');
  String dateWithT = date.substring(0, 8) + 'T' + date.substring(9);
  DateTime dateTime = DateTime.parse(dateWithT);
  print(dateTime);
  return (dateTime.toString());
}
