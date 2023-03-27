import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiktaktoe/provider/room_data_provider.dart';
import 'package:tiktaktoe/screens/gameScreen.dart';
import 'package:tiktaktoe/screens/main_menu_screen.dart';
import 'package:tiktaktoe/utils/colors.dart';
import 'screens/create_room_screen.dart';
import 'screens/join_room_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider(
      create: (context) => RoomDataProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tiktak toe',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: bgColor,
        ),
        
        initialRoute: MainMenuScreen.routeName,
        routes: {
          MainMenuScreen.routeName :(context) => MainMenuScreen(),
          CreateRoomScreen.routeName :(context) => CreateRoomScreen(),
          JoinRoomScreen.routeName :(context) => JoinRoomScreen(),
          GameScreen.routeName :(context) => GameScreen(),
          
        },
      ),
    );
  }
}
