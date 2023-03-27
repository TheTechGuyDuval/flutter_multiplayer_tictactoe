import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:tiktaktoe/provider/room_data_provider.dart';
import 'package:tiktaktoe/resources/game_method.dart';
import 'package:tiktaktoe/resources/socket_client.dart';
import 'package:tiktaktoe/utils/utils.dart';

import '../screens/gameScreen.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket!;

  Socket get socketClient => _socketClient;
//emits
  void createRoom(String nickName) {
    if (nickName.isNotEmpty) {
      _socketClient.emit('createRoom', {
        'nickName': nickName,
      });
    }
  }

  void joinRoom(String nickName, String roomId) {
    if (nickName.isNotEmpty && roomId.isNotEmpty) {
      _socketClient.emit('joinRoom', {
        'nickName': nickName,
        'roomId': roomId,
      });
    }
  }

  void tapGrid(int index, String roomId, List<String> displayElements) {
    if (displayElements[index] == '') {
      _socketClient.emit('tap', {
        'index': index,
        'roomId': roomId,
      });
    }
  }

//Listiners
  void createRoomSuccessListener(BuildContext context) {
    _socketClient.on('createRoomSuccess', (room) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(room);
      Navigator.pushNamed(context, GameScreen.routeName);
    });
  }

  void joinRoomSuccessListener(BuildContext context) {
    _socketClient.on('joinRoomSuccess', (room) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(room);
      Navigator.pushNamed(context, GameScreen.routeName);
    });
  }

  void errorOccuredListener(BuildContext context) {
    _socketClient.on('errorOccured', (data) {
      showSnackBar(context, data);
    });
  }

  void updatePlayerStateListiner(BuildContext context) {
    _socketClient.on('updatePlayers', (playerData) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updatePlayer1(playerData[0]);
      Provider.of<RoomDataProvider>(context, listen: false)
          .updatePlayer2(playerData[1]);
    });
  }

  void updateRoomListiner(BuildContext context) {
    _socketClient.on('updateRoom', (data) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(data);
    });
  }

  void tappedListener(BuildContext context) {
    _socketClient.on('tapped', (data) {
      RoomDataProvider roomDataProvider =
          Provider.of<RoomDataProvider>(context, listen: false);
      roomDataProvider.updateDisplayElements(data['index'], data['choice']);
      roomDataProvider.updateRoomData(data['room']);
      //check for winner
      GameMethods().checkWinner(context, _socketClient);
    });
  }

  void pointIncreaseListener(BuildContext context) {
    _socketClient.on('increasePoint', (playerData) {
      RoomDataProvider roomDataProvider =
          Provider.of<RoomDataProvider>(context, listen: false);
      if (playerData['socketID'] == roomDataProvider.Player1.socketID) {
        roomDataProvider.updatePlayer1(playerData);
      } else {
        roomDataProvider.updatePlayer2(playerData);
      }
    });
  }


   void endGameListener(BuildContext context) {
    _socketClient.on('enGame', (playerData) {
      RoomDataProvider roomDataProvider =
          Provider.of<RoomDataProvider>(context, listen: false);
     showGameDialog(context, '${playerData['nickName']} won the game!');
     Navigator.popUntil(context, (route) => false);
    });
  }

  
}
