import 'dart:ffi';

import 'package:chatapp/database.dart';
import 'package:chatapp/entity/user_entity.dart';
import 'package:chatapp/models/user.dart';
import 'package:chatapp/screens/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:getwidget/getwidget.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class Home extends StatefulWidget {
   Home({super.key, required this.database});
  AppDataBase database;

  

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;



List <User> users = [];
int pageCourante = 10;
PagingController<int, User> pagingController =PagingController(firstPageKey: 1);

var _formKey = new GlobalKey<FormBuilderState>();

List message = [ ];
double fontSize = 10;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    pagingController.addPageRequestListener((pageKey){
      getUsersList(page: pageKey);
    });
    //if(mounted)
    //getMessageList();

    //  message = [
    //     {
    //     'user':users[0],
    //       'message':'Hello friends',
    //       'heure':'12H 30',
    //       'statuts':1
    //     },
    //     {
    //       'user':users[1],
    //       'message':'Hello friends',
    //       'heure':'12H 30',
    //       'statuts': 2
    //     },
        // {
        //   'user':users[2],
        //   'message':'Hello friends',
        //   'heure':'12H 30',
        //   'statuts': 2
        // {
        //   'user':users[3],
        //   'message':'Hello friends',
        //   'heure':'12H 30',
        //   'statuts':1
        // },
        // {
        //   'user':users[4],
        //   'message':'Hello friends',
        //   'heure':'12H 30',
        //   'statuts':4
        // },
    //];

  }
  // void getUsersList(){
  //   getUsers().then((value){
  //     setState(() {
  //       users= value;
  //     });
  //   });
  // }

  void getUsersList({int page =1}){
    getUsers(page: page, pagingController: pagingController);
  }
  // void getMessageList(){
  //   setState(() {
  //     if(pagingController.itemList !=null){
  //       pagingController.itemList!.forEach((user) {
  //     message.add({
  //       'user' : user,
  //       'message':"Bonjour",
  //       'heure': "12H 30",
  //       'statuts': 1
  //     });
  //   });
  //     }
  //   });

  // }

  void updateUser({required Utilisateur user}){

    Get.bottomSheet(
            Container( 
            height: MediaQuery.of(context).size.height/2,
            decoration: BoxDecoration( 
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column( 
                children: [
                  ListTile( 
                    leading: CircleAvatar( 
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage("assets/images/google.png"),
                    ),
                    title: Text("Mise à joiur d'un utilisateur"),
                    subtitle: Text("Formulaire d'enregistrement"),
                  ),
                  FormBuilder(
                    key: _formKey,
                    child: Column( 
                      children: [ 
                        Padding(
                          padding:EdgeInsets.all(10),
                          child: FormBuilderTextField( 
                            name: "nom",
                            initialValue: user.nom,
                            decoration: InputDecoration( 
                              labelText: "nom de famille",
                              border: OutlineInputBorder( 
                                borderRadius: BorderRadius.circular(10)
                              )
                            ),
                          ), 
                        ),
                        Padding(
                          padding:EdgeInsets.all(10),
                          child: FormBuilderTextField( 
                            name: "prenom",
                            initialValue: user.prenom,
                            decoration: InputDecoration( 
                              labelText: "prenom",
                              border: OutlineInputBorder( 
                                borderRadius: BorderRadius.circular(10)
                              )
                            ),
                          ), 
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: GFButton( 
                            text:"Sauvegarder",
                             color: Colors.green,
                             size: GFSize.LARGE,
                             fullWidthButton: true,
                             type: GFButtonType.outline,
                             shape: GFButtonShape.pills,
                            onPressed: () async {  
                              if(_formKey.currentState!.saveAndValidate()){
                                int id = await widget.database.utilisateurDao.updateUtilisateur(
                                  Utilisateur(
                                    id: user.id,
                                    nom: _formKey.currentState!.value['nom'], 
                                    prenom: _formKey.currentState!.value['prenom'],
                                    telephone: "6365343"
                                    )
                                );

                                setState(() {
                                  
                                });
                                Get.back();
                                Get.snackbar("Succes","Success");
                              }
                            },
                          ),
                        )
                      ],
                    )
                  )
                ],
              ),
            ),
          
          
          )
          );

  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      backgroundColor: HexColor("#181818"),
      floatingActionButton: FloatingActionButton( 
        child: Icon(Icons.add),
        backgroundColor: GFColors.WARNING,
        onPressed: () {
          Get.bottomSheet(
            Container( 
            height: MediaQuery.of(context).size.height/2,
            decoration: BoxDecoration( 
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column( 
                children: [
                  ListTile( 
                    leading: CircleAvatar( 
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage("assets/images/google.png"),
                    ),
                    title: Text("Ajout d'un utilisateur"),
                    subtitle: Text("Formulaire d'enregistrement"),
                  ),
                  FormBuilder(
                    key: _formKey,
                    child: Column( 
                      children: [ 
                        Padding(
                          padding:EdgeInsets.all(10),
                          child: FormBuilderTextField( 
                            name: "nom",
                            decoration: InputDecoration( 
                              labelText: "nom de famille",
                              border: OutlineInputBorder( 
                                borderRadius: BorderRadius.circular(10)
                              )
                            ),
                          ), 
                        ),
                        Padding(
                          padding:EdgeInsets.all(10),
                          child: FormBuilderTextField( 
                            name: "prenom",
                            decoration: InputDecoration( 
                              labelText: "prenom",
                              border: OutlineInputBorder( 
                                borderRadius: BorderRadius.circular(10)
                              )
                            ),
                          ), 
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: GFButton( 
                            text:"Sauvegarder",
                             color: Colors.green,
                             size: GFSize.LARGE,
                             fullWidthButton: true,
                             type: GFButtonType.outline,
                             shape: GFButtonShape.pills,
                            onPressed: () {  
                              if(_formKey.currentState!.saveAndValidate()){
                                widget.database.utilisateurDao.insertUtilisateur(
                                  Utilisateur(
                                    nom: _formKey.currentState!.value['nom'], 
                                    prenom: _formKey.currentState!.value['prenom'],
                                    telephone: "6365343"
                                    )
                                );

                                setState(() {
                                  
                                });
                                Get.snackbar("Succes","Success");
                              }
                            },
                          ),
                        )
                      ],
                    )
                  )
                ],
              ),
            ),
          
          
          )
          );
        },
      ),
      appBar: AppBar( 
        title: Text("Chat App", style: TextStyle(color: Colors.white,),),
        
        actions: [
          Padding(
            padding: EdgeInsets.all(5),
            child: Container( 
              decoration: BoxDecoration(
                color: HexColor("#301c70"),
                borderRadius: BorderRadius.all(Radius.circular(40))
              ),
              height: 45,
              width: 45,
              child: Center(
                child: Icon(Icons.add),
                ),
            ),
          )
        ],
       centerTitle: true,
        elevation: 0,
        backgroundColor: HexColor("#181818"),
        leading: Padding(
          padding: EdgeInsets.all(10),
          child: CircleAvatar(
            backgroundImage: AssetImage("assets/images/img2.jpg"),
            ),
          ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Container(
            //   height: 180,
            //   child: ListView(
            //     scrollDirection: Axis.horizontal,
            // children: List.generate(users.length, (index) {
            //   return createAvatar(users: users[index]);
            // }),
            //   ),

            // ),
            Container(
              height: 180,
              child: PagedListView( 
                scrollDirection: Axis.horizontal,
                pagingController: pagingController,
                builderDelegate: PagedChildBuilderDelegate<User>(
                  itemBuilder: (context,item,index) {
                    return createAvatar(users: item);
                  }
                  ),
              ),
            ),
             Padding(
              padding: EdgeInsets.all(10),
              child: Text( 
                "Messages",
                style: TextStyle( 
                  color: Colors.white,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  
                ),
              ),
              ),

              FutureBuilder(
                future: widget.database.utilisateurDao.findAllUsers(), 
                builder: (context, data){
                  if(data.connectionState == ConnectionState.active){
                    return CircularProgressIndicator();
                  }
                  if (!data.hasError && data.hasData) {
                    List<Utilisateur> users =data.data as List<Utilisateur>;

                    return ListView( 
                        shrinkWrap: true,
                        children: users.map((user) {
                         
                          return Dismissible(
                          key: Key(user.id.toString()), 
                          child: createUserUi(users: user),
                          background:Row(
                            children: [ 
                               Container( 
                                  color: Colors.red,
                                  child: Row( 
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     children: [
                                          Container(
                                            color: Colors.red,
                                            height: double.infinity,
                                            width: MediaQuery.of(context).size.height/5,
                                            child: Icon(Icons.delete),
                                          ),
                                          Container(
                                            color: Colors.green,
                                            height: double.infinity,
                                            width: MediaQuery.of(context).size.height/5,
                                            child: Icon(Icons.archive)
                                          )
                            ],
                                  ),
                               )
                                 ],  
                            ),
                          
                          
                           
                          onDismissed: (direction) async {

                            users.remove(user);
                            await widget.database.utilisateurDao.deleteUtilisateur(user);

                            setState(() { });

                          },
                          // confirmDismiss: (direction) {
                          //   return true;
                          // },
                        );
                        }).toList(),
                    );
                  }

                  return SizedBox();
                }
                ),


              ListView( 
                shrinkWrap: true,
                children: List.generate(message.length, (index) {
                return GestureDetector(
                  child: createMessage(message: message[index]),
                  onTap: (){
                    //Changer de page dans l'application
                    Get.to(() => Message(message: message[index]));

                    //Changer la page sans retour possible
                    //Get.off(() => Message());
                    //Get.offAll(() => Message());
                  },
                );
                  
                }),
                  )
            ],
        ),
        ),
    );
  }


Widget createUserUi({required Utilisateur users}){

   return Padding(
    padding: EdgeInsets.only(
      bottom: 5,
      left: 8,
      right: 8
    ),
    child: ListTile(
      textColor: Colors.white,
      title: Text(
       "${users.prenom} ${users.nom}",
        style: TextStyle(
          fontWeight: FontWeight.bold
          ),
        ),
        subtitle: Text( 
         users.telephone
        ),
        leading: GestureDetector( 
            child: CircleAvatar( 
           radius: 30,
           backgroundImage: AssetImage("assets/images/img3.jpg"),
          ),
          onTap: (){
              setState(() {
                
                if (fontSize<20 ){
                  fontSize =fontSize+1;
                }
                else{
                  fontSize=fontSize -1;
                }
                
              });
          },
        ),
           
        trailing: IconButton( 
          icon: Icon(Icons.edit),
          color: Colors.white,
          onPressed: () {
            updateUser(user: users);
          },
        )
        
      ),
  );

  
    
}

  
Widget createAvatar({required User users}){

  return Padding(
    padding: EdgeInsets.all(10),
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.all(5),
          child: Stack(
            children: [
              CircleAvatar(
                radius: 35,
                backgroundImage: NetworkImage(users.image),
              ),

              true ? Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  height: 22,
                  width: 22,
                  decoration: BoxDecoration( 
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                )
                ):const SizedBox(),
                true ? Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration( 
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(20) ) 
                  ),
                ),
                  
                ):const SizedBox(),
            ],
            ),
          ),
          Text(
             users.lastName,
             style: TextStyle(
              color: Colors.white,
              fontSize: 10
             ),
             
          )
         
      ],
    ),
  
  );
}

Widget createMessage( {required Map message}){
  
  // return ListTile( 
  //     leading: Icon(Icons.car_crash),
  //     title: Text(
  //       "Messages"
  //       ),
  //       subtitle: Icon(Icons.car_crash),
  //       trailing: Icon(Icons.person),
  // );
  return Padding(
    padding: EdgeInsets.only(
      bottom: 5,
      left: 8,
      right: 8
    ),
    child: ListTile(
      textColor: Colors.white,
      title: Text(
        message['user'].lastName,
        style: TextStyle(
          fontWeight: FontWeight.bold
          ),
        ),
        subtitle: Text( 
          message['message']
        ),
        leading: GestureDetector( 
            child: CircleAvatar( 
           radius: 30,
           backgroundImage: NetworkImage(message['user'].image),
          ),
          onTap: (){
              setState(() {
                
                if (fontSize<20 ){
                  fontSize =fontSize+1;
                }
                else{
                  fontSize=fontSize -1;
                }
                
              });
          },
        ),
           
        trailing: Column( 
          children: [ 
            Text(
              message['heure']
            ),
            SizedBox( 
              height: 4,
            ),
            Container( 
              height: 20,
              width: 20,
              decoration: BoxDecoration( 
                color: HexColor("#301c70"),
                borderRadius: BorderRadius.all(Radius.circular(15))
              ),
              child: Center( 
                child: Text( 
                  message['statuts'].toString()
                ),
              ),
            )
          ],
        ),
        
      ),
  );
}
}

Widget createAvatarPlaceholder() {

    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(5),
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 40,
                  child: GFShimmer(
                    showGradient: true,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                      colors: [
                        Colors.black,
                        Colors.yellow,
                        Colors.green
                      ]
                    ),
                    child: SizedBox()
                  ),
                ),
                true ? Positioned(
                  child: Container(
                    height: 22,
                    width: 22,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                  )
                ):const SizedBox(),
                true ? Positioned(
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                  )
                ):const SizedBox()
              ],
            ),
          ),
          Container(
            height: 10,
            color: Colors.red,
          )
        ],
      ),
    );
  }




class HexColor extends Color {
    static int _getColorFromHex(String hexColor) {
        hexColor = hexColor.toUpperCase().replaceAll("#", "");
        if (hexColor.length == 6) {
            hexColor = "FF" + hexColor;
        }
        return int.parse(hexColor, radix: 16);
    }

    HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}