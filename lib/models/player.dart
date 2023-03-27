// ignore_for_file: public_member_api_docs, sort_constructors_first

class Player {
  final String nickName;
  final String socketID;
  final double points;
  final String playerType;
  Player({
    required this.nickName,
    required this.socketID,
    required this.points,
    required this.playerType,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nickName': nickName,
      'socketID': socketID,
      'points': points,
      'playerType': playerType,
    };
  }

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      nickName: map['nickName'] as String,
      socketID: map['socketID'] as String,
      points: map['points'] as double,
      playerType: map['playerType'] as String,
    );
  }

  

  Player copyWith({
    String? nickName,
    String? socketID,
    double? points,
    String? playerType,
  }) {
    return Player(
      nickName: nickName ?? this.nickName,
      socketID: socketID ?? this.socketID,
      points: points ?? this.points,
      playerType: playerType ?? this.playerType,
    );
  }
}
