import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:water_metering_app/utils/colors.dart';

class ComplaintCard extends StatelessWidget {
  final snapshot;
  const ComplaintCard({Key? key, required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: mobileBackgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ComplaintListView(
        thumbnail: snapshot['photoUrl'] == ''
            ? Container(
                decoration: const BoxDecoration(color: Colors.pink),
              )
            : SizedBox(
                child: Image.network(snapshot['photoUrl']),
              ),
        displayName: snapshot['displayName'],
        description: snapshot['description'],
        meterNumber: 'To do: Add meter number to complaints data model',
        datePublished: DateFormat.yMMMd().format(
          snapshot['datePublished'].toDate(),
        ),
      ),
    );
  }
}

class _ComplaintDescription extends StatelessWidget {
  const _ComplaintDescription({
    Key? key,
    required this.displayName,
    required this.description,
    required this.meterNumber,
    required this.datePublished,
  }) : super(key: key);

  final String displayName;
  final String description;
  final String meterNumber;
  final String datePublished;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                displayName,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
              Text(
                description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                meterNumber,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black87,
                ),
              ),
              Text(
                datePublished,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ComplaintListView extends StatelessWidget {
  const ComplaintListView({
    Key? key,
    required this.thumbnail,
    required this.displayName,
    required this.description,
    required this.meterNumber,
    required this.datePublished,
  }) : super(key: key);

  final Widget thumbnail;
  final String displayName;
  final String description;
  final String meterNumber;
  final String datePublished;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: SizedBox(
            height: 100,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 1.0,
                  child: thumbnail,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
                    child: _ComplaintDescription(
                      displayName: displayName,
                      description: description,
                      meterNumber: meterNumber,
                      datePublished: datePublished,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
