import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

class Message extends StatefulWidget {
  Message({super.key , required this.message});

  late Map message;

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Map msg;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    msg = widget.message;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar( 
        title: Text("Message de "),
  //Specifier son propre boutton de retour
        // leading: GestureDetector( 
        //   child: Icon(Icons.chevron_left),
        //   onTap: (){
        //     Get.back();
        //   },
        // ),

      ),

//Créer un boutton au centre de la page 
      body: Center( 
        child: ElevatedButton( 
          child: Text(msg['user']['nom']),
          onPressed: (){
// l methode permet de changer de page en supprimant toutes les pages précedentes
            //Get.offAll(() => Message());
            //print("mon message");
          },
        )
      ,
      )
    );
  }
}