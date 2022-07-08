import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:water_metering_app/utils/colors.dart';
import 'package:photo_view/photo_view.dart';

class ReadingCard extends StatelessWidget {
  final snapshot;
  const ReadingCard({Key? key, required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: mobileBackgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ReadingListView(
        thumbnail: snapshot['photoUrl'] == ''
            ? Container(
                decoration: const BoxDecoration(color: Colors.pink),
              )
            : SizedBox(
                child: Image.network(snapshot['photoUrl']),
              ),
        meterNumber: snapshot['meterNumber'],
        datePublished: DateFormat.yMMMd().format(
          snapshot['datePublished'].toDate(),
        ),
        photoLocation: snapshot['photoLocation'],
        processedImageURL: snapshot['processedImageURL'],
        dateProcessed: snapshot['dateProcessed'],
      ),
    );
  }
}

class _ReadingDetails extends StatelessWidget {
  const _ReadingDetails({
    Key? key,
    //required this.displayName,
    required this.meterNumber,
    required this.datePublished,
    required this.photoLocation,
    required this.processedImageURL,
    required this.dateProcessed,
  }) : super(key: key);

  //final String displayName;
  final String meterNumber;
  final String datePublished;
  final String photoLocation;
  final String processedImageURL;
  final String dateProcessed;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          dense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          title: const Text(
            "Meter Number",
            style: TextStyle(fontSize: 12.5),
          ),
          subtitle: Text(
            meterNumber,
            style: const TextStyle(fontSize: 11),
          ),
          // leading: const Icon(Icons.chevron_right, size: 30),
        ),
        ListTile(
          dense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          title: const Text(
            "Date",
            style: TextStyle(fontSize: 12.5),
          ),
          subtitle: Text(
            datePublished,
            style: const TextStyle(fontSize: 11),
          ),
          // leading: const Icon(Icons.chevron_right, size: 30),
        ),
        ListTile(
          dense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          title: const Text(
            "Location",
            style: TextStyle(fontSize: 12.5),
          ),
          subtitle: Text(
            photoLocation,
            style: TextStyle(fontSize: 11),
          ),
          // leading: Icon(Icons.chevron_right, size: 30),
        ),
        Container(
          margin: const EdgeInsets.symmetric(
            vertical: 20.0,
            horizontal: 20.0,
          ),
          height: 200,
          child: ClipRect(
            child: PhotoView(
              imageProvider: processedImageURL == ''
                  ? const NetworkImage(
                      "https://ih1.redbubble.net/image.940931904.5683/flat,750x1000,075,f.jpg")
                  : NetworkImage(processedImageURL),
              maxScale: PhotoViewComputedScale.covered * 2.0,
              minScale: PhotoViewComputedScale.contained * 0.8,
              initialScale: PhotoViewComputedScale.covered,
            ),
          ),
        ),
        ListTile(
          dense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          title: const Text(
            "Date Proecessed",
            style: TextStyle(fontSize: 12.5),
          ),
          subtitle: Text(
            dateProcessed,
            style: TextStyle(fontSize: 11),
          ),
          // leading: Icon(Icons.chevron_right, size: 30),
        ),
      ],
    );
  }
}

class ReadingListView extends StatelessWidget {
  const ReadingListView({
    Key? key,
    required this.thumbnail,
    required this.meterNumber,
    required this.datePublished,
    required this.photoLocation,
    required this.processedImageURL,
    required this.dateProcessed,
  }) : super(key: key);

  final Widget thumbnail;
  final String meterNumber;
  final String datePublished;
  final String photoLocation;
  final String processedImageURL;
  final String dateProcessed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromRGBO(217, 225, 223, 0.8),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color.fromRGBO(215, 230, 227, 1)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: SizedBox(
              height: 200,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: thumbnail,
                  ),
                  SizedBox(
                    width: 175,
                    child: _ReadingDetails(
                      meterNumber: meterNumber,
                      datePublished: datePublished,
                      photoLocation: photoLocation,
                      processedImageURL: processedImageURL,
                      dateProcessed: dateProcessed,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
