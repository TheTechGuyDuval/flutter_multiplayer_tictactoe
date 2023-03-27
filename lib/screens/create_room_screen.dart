import 'package:flutter/material.dart';

import '../Responsive/responsive.dart';
import '../resources/socket_methods.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_textfield.dart';

class CreateRoomScreen extends StatefulWidget {
  static String routeName = '/create-room';
  const CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {

  final TextEditingController _nameController = TextEditingController();
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _socketMethods.createRoomSuccessListener(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();
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
                shadows: [
                  Shadow(
                    blurRadius: 40,
                    color: Colors.blue
                  )
                ],
                text: 'Create Room',
                fontSize: 70,
      
              ),
              SizedBox(
                height: size.height*0.08,
              ),
              CustomTextField(
                controller: _nameController,
                hintext: 'Enter your Nickname',
              
              ),
                SizedBox(
                height: size.height*0.045,
              ),
             CustomButton(
              ontap: () => _socketMethods.createRoom(_nameController.text.trim()),
              text: 'Create',
             )
            ],
          ),
        ),
      ),
    );
  }
}