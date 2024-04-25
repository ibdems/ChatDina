import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/route_manager.dart';
import 'package:getwidget/getwidget.dart';
import 'package:dio/dio.dart' as dio;
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  void login({required Map data}) async{
    
    var dioClient = new dio.Dio();

    ProgressDialog dialog = ProgressDialog(context: context);

    dialog.show( 
      max: 100,
      msg: "Patienter ..."
    );

    try {
      dio.Response response = await dioClient.post(
        "https://reqres.in/api/login",
        data: data
        );
        dialog.close();

    } catch (e) {
      Get.snackbar(
        "erreur",
        "email ou mot de passe invalide",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        icon: Icon(Icons.error)
        );

        dialog.close();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration( 
        image: DecorationImage( 
          fit: BoxFit.cover,
          image: AssetImage("assets/images/log9.jpg")
        )
      ),
      child: Scaffold( 
        backgroundColor: Colors.black.withOpacity(0.4),
        body: Padding( 
          padding: EdgeInsets.all(10),
          child: Column( 
            mainAxisAlignment: MainAxisAlignment.center,
            children: [ 
              Text( 
                "WELCOME",
                style: TextStyle( 
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold

                ),
              ),
               
              FormBuilder(
                key: _formKey,
                child: Column( 
                  children: [ 
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FormBuilderTextField(
                        name: 'email',
                        decoration: InputDecoration( 
                          //errorText: "email invaide",
                          border: OutlineInputBorder( 
                            borderRadius: BorderRadius.circular(15)
                          ),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.4),
                          labelStyle: TextStyle( 
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                          ),
                          label: Text("Email"),
                          hintText: "Saisissez votre email",
                          hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
                          //prefixIcon:Icon(Icons.email),
                          suffixIcon: Icon(Icons.email),
                          icon: Icon(Icons.email),
                          iconColor: Color.fromARGB(255, 183, 184, 200),
                          suffixIconColor: Color.fromARGB(255, 14, 22, 137)
                        ),
                      ),
                    ),
                    SizedBox( 
                      height: 10,
                    ),
                    FormBuilderTextField(
                      validator: FormBuilderValidators.compose([ 
                        FormBuilderValidators.required(),
                        FormBuilderValidators.min(4),
                      ]),
                      name: 'password',
                      decoration: InputDecoration( 
                        border: OutlineInputBorder( 
                          borderRadius: BorderRadius.circular(15)
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.4),
                        labelStyle: TextStyle( 
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                          
                        ),
                        label: Text("Mot de pass") ,
                        hintText: "Saisissez votre mot de passe",
                        hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
                        //prefixIcon:Icon(Icons.lock),
                        suffixIcon: Icon(Icons.lock),
                        icon: Icon(Icons.lock),
                        iconColor: Colors.white,
                      ),
                    ),
                    Padding(
                      padding:EdgeInsets.all(5),
                      child: 
                      SizedBox( 
                        width: 150,
                        child: GFButton( 
                        shape: GFButtonShape.pills,
                        fullWidthButton: true,
                        textColor: Colors.white,
                        size: GFSize.LARGE,
                        color: GFColors.SUCCESS,
                        text: "Connexion",
                        onPressed: (){
                          if(_formKey.currentState!.saveAndValidate()){
                            //print(_formKey.currentState!.value);
                            login(data: _formKey.currentState!.value);
                          }else{
                            print('erreur');
                          }
                        },
                      ),  
                      ),
                    
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child:Text( 
                        "__Or__",
                        style: TextStyle( 
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                        ),
                      ) ,
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: GFButton( 
                        shape: GFButtonShape.pills,
                        type: GFButtonType.outline,
                        fullWidthButton: true,
                        textColor: Colors.white,
                        size: GFSize.LARGE,
                        color:GFColors.SUCCESS,
                        child: Padding( 
                          padding: EdgeInsets.all(5),
                          child: Row( 
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [ 
                              Text( 
                                "Connectez-vous avec ",
                                style: TextStyle( 
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              Image.asset(
                                "assets/images/google.png"
                              )
                            ],
                          ),
                        ),
                        onPressed: (){
                          
                        },
                      ),
                    )
                  ],
                )
                )

            ],
          ),
        ),
      ),
    );
  }
}