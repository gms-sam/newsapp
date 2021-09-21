// import 'package:flutter/material.dart';

// import 'home_page.dart';
// import 'profile.dart';

// class DashBoard extends StatefulWidget {
//   const DashBoard({ Key? key }) : super(key: key);

//   @override
//   _DashBoardState createState() => _DashBoardState();
// }

// class _DashBoardState extends State<DashBoard> {

//   int _currentIndex = 0;

//    List<Widget> tabs =[
//     HomePage(),
//     Profile()
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(

//        body: tabs[_currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         type: BottomNavigationBarType.fixed,
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: "",
//             backgroundColor: Colors.blue
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: "",
//             backgroundColor: Colors.blue
//           ),
//         ],
//         onTap: (index){
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//       )
      
//     );
//   }
// }