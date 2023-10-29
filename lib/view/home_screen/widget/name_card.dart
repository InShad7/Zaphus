import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zaphus/controller/provider/contoller.dart';
import 'package:zaphus/view/utils/color.dart';

class TopNameCard extends StatelessWidget {
  const TopNameCard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ControllerProvider>(context);
    provider.loadUserData();
    return Container(
      margin: const EdgeInsets.all(15),
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: 'Hi ',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: black,
                  ),
                ),
                TextSpan(
                  text: provider.nameController.text,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.normal,
                    color: black,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.emoji_events_outlined,
                size: 30,
                color: red,
              ),
              Text(
                provider.rewards.toString() ,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  color: black,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
