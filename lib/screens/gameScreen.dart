import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiktaktoe/resources/socket_methods.dart';

import '../provider/room_data_provider.dart';
import '../views/scoabard.dart';
import '../views/tictactoebord.dart';
import '../views/waiting_lobbby.dart';

class GameScreen extends StatefulWidget {
  static String routeName = '/game';
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final SocketMethods _socketMethods = SocketMethods();

@override
void initState() {
  super.initState();
  _socketMethods.updateRoomListiner(context);
  _socketMethods.updatePlayerStateListiner(context);
  _socketMethods.pointIncreaseListener(context);
  _socketMethods.endGameListener(context);
  
}

  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider =  Provider.of<RoomDataProvider>(context);
    return Scaffold(
      body: roomDataProvider.roomData['isJoin'] ? WaitingLobby() :
       SafeArea(child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children:  [
       const Scorboard(),
       const TicTacToeBoard(),
       Text('${roomDataProvider.roomData['turn']['nickName']}\'s turn')


        ],
       )),
    );
  }
}