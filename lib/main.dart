// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lists/pages/homepage.dart';
import 'package:lists/providers/children_provider.dart';
import 'package:lists/providers/folder_provider.dart';
import 'package:lists/providers/item_provider.dart';
import 'package:lists/providers/parent_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FolderProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ParentProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ItemProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TarotHandProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Homepage(),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:tab_container/tab_container.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const ExamplePage(),
//     );
//   }
// }

// class ExamplePage extends StatefulWidget {
//   const ExamplePage({super.key});

//   @override
//   _ExamplePageState createState() => _ExamplePageState();
// }

// class _ExamplePageState extends State<ExamplePage>
//     with SingleTickerProviderStateMixin {
//   late final TabController _controller;
//   late TextTheme textTheme;

//   @override
//   void initState() {
//     super.initState();
//     _controller = TabController(vsync: this, length: 3);
//   }

//   @override
//   void didChangeDependencies() {
//     textTheme = Theme.of(context).textTheme;
//     super.didChangeDependencies();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Example'),
//       ),
//       body: SingleChildScrollView(
//         child: SizedBox(
//           child: Column(
//             children: [
//               SizedBox(
//                 width: 400,
//                 child: AspectRatio(
//                   aspectRatio: 10 / 8,
//                   child: TabContainer(
//                     borderRadius: BorderRadius.circular(20),
//                     tabEdge: TabEdge.top,
//                     curve: Curves.easeIn,
//                     transitionBuilder: (child, animation) {
//                       animation = CurvedAnimation(
//                           curve: Curves.easeIn, parent: animation);
//                       return SlideTransition(
//                         position: Tween(
//                           begin: const Offset(0.2, 0.0),
//                           end: const Offset(0.0, 0.0),
//                         ).animate(animation),
//                         child: FadeTransition(
//                           opacity: animation,
//                           child: child,
//                         ),
//                       );
//                     },
//                     colors: const <Color>[
//                       Color(0xfffa86be),
//                       Color(0xffa275e3),
//                       Color(0xff9aebed),
//                     ],
//                     selectedTextStyle:
//                         textTheme.bodyMedium?.copyWith(fontSize: 15.0),
//                     unselectedTextStyle:
//                         textTheme.bodyMedium?.copyWith(fontSize: 13.0),
//                     tabs: [Text("Past"), Text("Present"), Text("Future")],
//                     children: _getChildren1(),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   List<Widget> _getChildren1() {
//     List<CreditCardData> cards = kCreditCards
//         .map(
//           (e) => CreditCardData.fromJson(e),
//         )
//         .toList();

//     return cards.map((e) => CreditCard(data: e)).toList();
//   }
// }

// class CreditCard extends StatelessWidget {
//   final Color? color;
//   final CreditCardData data;

//   const CreditCard({
//     super.key,
//     this.color,
//     required this.data,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(20.0),
//       decoration: BoxDecoration(
//         color: color,
//         borderRadius: BorderRadius.circular(14.0),
//       ),
//       child: Column(
//         children: [
//           Expanded(
//             flex: 2,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   data.bank,
//                 ),
//                 const Icon(
//                   Icons.person,
//                   size: 36,
//                 ),
//               ],
//             ),
//           ),
//           const Spacer(flex: 2),
//           Expanded(
//             flex: 5,
//             child: Row(
//               children: [
//                 Text(
//                   data.number,
//                   style: const TextStyle(
//                     fontSize: 22.0,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             flex: 2,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text('Exp.'),
//                 const SizedBox(width: 4),
//                 Text(
//                   data.expiration,
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             flex: 2,
//             child: Row(
//               children: [
//                 Text(
//                   data.name,
//                   style: const TextStyle(
//                     fontSize: 16.0,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CreditCardData {
//   int index;
//   bool locked;
//   final String bank;
//   final String name;
//   final String number;
//   final String expiration;
//   final String cvc;

//   CreditCardData({
//     this.index = 0,
//     this.locked = false,
//     required this.bank,
//     required this.name,
//     required this.number,
//     required this.expiration,
//     required this.cvc,
//   });

//   factory CreditCardData.fromJson(Map<String, dynamic> json) => CreditCardData(
//         index: json['index'],
//         bank: json['bank'],
//         name: json['name'],
//         number: json['number'],
//         expiration: json['expiration'],
//         cvc: json['cvc'],
//       );
// }

// const List<Map<String, dynamic>> kCreditCards = [
//   {
//     'index': 0,
//     'bank': 'Aerarium',
//     'name': 'John Doe',
//     'number': '5234 4321 1234 4321',
//     'expiration': '11/25',
//     'cvc': '123',
//   },
//   {
//     'index': 1,
//     'bank': 'Aerarium',
//     'name': 'John Doe',
//     'number': '4234 4321 1234 4321',
//     'expiration': '07/24',
//     'cvc': '321',
//   },
//   {
//     'index': 2,
//     'bank': 'Aerarium',
//     'name': 'John Doe',
//     'number': '5234 4321 1234 4321',
//     'expiration': '09/23',
//     'cvc': '456',
//   },
// ];
