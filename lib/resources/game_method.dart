import 'package:socket_io_client/socket_io_client.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiktaktoe/provider/room_data_provider.dart';
import '../utils/utils.dart';

class GameMethods {
  void checkWinner(BuildContext context, Socket socketClient) {
    RoomDataProvider roomDataProvider =
        Provider.of<RoomDataProvider>(context, listen: false);
    String winner = ''; //x or o

    //row 1 winner
    if (roomDataProvider.displayElements[0] ==
            roomDataProvider.displayElements[1] &&
        roomDataProvider.displayElements[0] ==
            roomDataProvider.displayElements[2] &&
        roomDataProvider.displayElements[0] != '') {
      winner = roomDataProvider.displayElements[0];
    }

    //row 2 winner
    if (roomDataProvider.displayElements[3] ==
            roomDataProvider.displayElements[4] &&
        roomDataProvider.displayElements[3] ==
            roomDataProvider.displayElements[5] &&
        roomDataProvider.displayElements[3] != '') {
      winner = roomDataProvider.displayElements[3];
    }

    //row 3 winner
    if (roomDataProvider.displayElements[6] ==
            roomDataProvider.displayElements[7] &&
        roomDataProvider.displayElements[6] ==
            roomDataProvider.displayElements[8] &&
        roomDataProvider.displayElements[6] != '') {
      winner = roomDataProvider.displayElements[6];
    }

    //column 1 winner
    if (roomDataProvider.displayElements[0] ==
            roomDataProvider.displayElements[3] &&
        roomDataProvider.displayElements[0] ==
            roomDataProvider.displayElements[6] &&
        roomDataProvider.displayElements[0] != '') {
      winner = roomDataProvider.displayElements[0];
    }
    //column 2 winner
    if (roomDataProvider.displayElements[1] ==
            roomDataProvider.displayElements[4] &&
        roomDataProvider.displayElements[1] ==
            roomDataProvider.displayElements[7] &&
        roomDataProvider.displayElements[1] != '') {
      winner = roomDataProvider.displayElements[1];
    }

    //column 3 winner
    if (roomDataProvider.displayElements[2] ==
            roomDataProvider.displayElements[5] &&
        roomDataProvider.displayElements[2] ==
            roomDataProvider.displayElements[8] &&
        roomDataProvider.displayElements[2] != '') {
      winner = roomDataProvider.displayElements[2];
    }

    //diagonal 1 winner
    if (roomDataProvider.displayElements[0] ==
            roomDataProvider.displayElements[4] &&
        roomDataProvider.displayElements[0] ==
            roomDataProvider.displayElements[8] &&
        roomDataProvider.displayElements[8] != '') {
      winner = roomDataProvider.displayElements[8];
    }

    //diagonal 2 winner
    if (roomDataProvider.displayElements[2] ==
            roomDataProvider.displayElements[4] &&
        roomDataProvider.displayElements[2] ==
            roomDataProvider.displayElements[6] &&
        roomDataProvider.displayElements[6] != '') {
      winner = roomDataProvider.displayElements[6];
    } else if (roomDataProvider.filledBoxes == 9) {
      //display end of game
      showGameDialog(context, 'Draw');
    }

    if (winner != '') {
      if (roomDataProvider.Player1.playerType == winner) {
        //display dialog box,winner 1 wins
        showGameDialog(context, '${roomDataProvider.Player1.nickName} won');
        socketClient.emit('winner', {
          'winnerSocketId': roomDataProvider.Player1.socketID,
          'roomId': roomDataProvider.roomData['_id']
        });
      } else {
        //display dialog box,winner 2 wins
        showGameDialog(context, '${roomDataProvider.Player2.nickName} won');
        socketClient.emit('winner', {
          'winnerSocketId': roomDataProvider.Player2.socketID,
          'roomId': roomDataProvider.roomData['_id']
        });
      }
    }
  }

  void clearBoard(
    BuildContext context,
  ) {
    RoomDataProvider roomDataProvider =
        Provider.of<RoomDataProvider>(context, listen: false);
    for (int i = 0; i < roomDataProvider.displayElements.length; i++) {
      roomDataProvider.updateDisplayElements(i, '');
    }
    roomDataProvider.setFillBoxesTo0();
  }
}
