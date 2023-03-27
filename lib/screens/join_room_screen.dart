import 'package:flutter/material.dart';
import 'package:tiktaktoe/resources/socket_methods.dart';

import '../Responsive/responsive.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_textfield.dart';

class JoinRoomScreen extends StatefulWidget {
  static String routeName = '/join-room';
  const JoinRoomScreen({super.key});

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _gameIdController = TextEditingController();

  final SocketMethods _socketMethods = SocketMethods();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _gameIdController.dispose();
    _gameIdController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _socketMethods.joinRoomSuccessListener(context);
    _socketMethods.errorOccuredListener(context);
    _socketMethods.updatePlayerStateListiner(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Responsive(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(
                shadows: [Shadow(blurRadius: 40, color: Colors.blue)],
                text: 'Join Room',
                fontSize: 70,
              ),
              SizedBox(
                height: size.height * 0.08,
              ),
              CustomTextField(
                controller: _nameController,
                hintext: 'Enter your Nickname',
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: _gameIdController,
                hintext: 'Enter game Id',
              ),
              SizedBox(
                height: size.height * 0.045,
              ),
              CustomButton(
                ontap: () => _socketMethods.joinRoom(
                    _nameController.text.trim(), _gameIdController.text.trim()),
                text: 'Join',
              )
            ],
          ),
        ),
      ),
    );
  }
}
