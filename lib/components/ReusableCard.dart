import 'package:flutter/material.dart';
import 'package:finance_mobile/common/constants/text_constants.dart';

class ReusableContainer extends StatelessWidget {

  final IconData icon;
  final String textLabel;
  final EdgeInsetsGeometry? margin;

  ReusableContainer({required this.icon, required this.textLabel, required this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      padding: EdgeInsets.all(5.0),
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        border: Border.all(color: Colors.white, width: 2.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          SizedBox(
            width: 10.0,
          ),
          Text(
            textLabel,
            style: kTextLabel,
          ),
        ],
      ),
    );
  }
}

// Container ReusableCard() {
//   return Container(
//     padding: EdgeInsets.all(5),
//     margin: EdgeInsets.all(10),
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.all(
//         Radius.circular(15),
//       ),
//       border: Border.all(color: Colors.white, width: 2.0),
//     ),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Icon(
//           Icons.email,
//           color: Colors.white,
//         ),
//         SizedBox(
//           width: 10,
//         ),
//         Text(
//           'Acesse com Email',
//           style: kTextLabel,
//         ),
//       ],
//     ),
//   );
// }
