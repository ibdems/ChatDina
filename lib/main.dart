import 'package:chatapp/entity/user_entity.dart';
import 'package:chatapp/screens/home.dart';
import 'package:chatapp/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/route_manager.dart';
import 'database.dart' ;

Future <void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  final database = await $FloorAppDataBase.databaseBuilder('app.db').build();

 await database.utilisateurDao.insertUtilisateur(new Utilisateur(nom: "Diall", prenom: 'Dina', telephone: '666666666'));


  runApp(
    MyApp(
      database :database
    ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.database});

    AppDataBase database;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: Get.key,
      title: 'ODC APP',
      theme: ThemeData(),
      home: Home(database: database),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
        FormBuilderLocalizations.delegate,
       ]
      
    );
  }
}


