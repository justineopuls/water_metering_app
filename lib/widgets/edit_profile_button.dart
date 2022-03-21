import 'package:flutter/material.dart';
import 'package:water_metering_app/routes/routes.dart';

class EditProfileButton extends StatelessWidget {
  final Function()? function;
  const EditProfileButton({Key? key,this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top:8),
      child: TextButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, Routes.updateProfile);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey,
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(5),
          ),
          alignment: Alignment.center,
          child: Text('EDIT PROFILE',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          width: 200,
          height: 27,
        ),
      ),
    );
  }
}
