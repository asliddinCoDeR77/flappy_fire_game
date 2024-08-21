// import 'package:flutter/material.dart';
// import 'package:flutter_joystick/flutter_joystick.dart';

// class JoystickExample extends StatefulWidget {
//   const JoystickExample({super.key});

//   @override
//   State<JoystickExample> createState() => _JoystickExampleState();
// }

// class _JoystickExampleState extends State<JoystickExample> {
//   double _x = 100;
//   double _y = 100;

//   JoystickMode _joystickMode = JoystickMode.all;
//      ballSize = 20.0;
//  step = 10.0;

//   @override
//   void didChangeDependencies() {
//     _x = MediaQuery.of(context).size.width / 2 - ballSize / 2;
//     super.didChangeDependencies();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade100,
//       body: SafeArea(
//         child: Stack(
//           children: [
//             Align(
//               alignment: const Alignment(0, 0.8),
//               child: Joystick(
//                 mode: _joystickMode,
//                 listener: (details) {
//                   setState(() {
//                     _x = _x + step * details.x;
//                     _y = _y + step * details.y;
//                   });
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
