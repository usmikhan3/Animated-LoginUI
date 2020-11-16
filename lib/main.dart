import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Nunito"
      ),
      
      home: Scaffold(
          resizeToAvoidBottomInset: false,
        body: Container(
          child: LoginPage(),
        ) 
      )
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  int _pageState = 0;

  var _backgroundColor = Colors.white;
  var _headingColor = Color(0xFF40284A);

  double _loginYOffset = 0;
  double _loginXOffset = 0;
  double _registerYOffset = 0;

   double windowWidth = 0;
   double windowHeight = 0;
   double _loginWidth = 0;
   double _loginHeight = 0;
   double _registerHeight = 0;
   double _loginOpacity = 1;
   double _headingTop = 100;

   bool _keyboardVisible = false;


   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        setState(() {
          _keyboardVisible = visible;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    windowHeight = MediaQuery.of(context).size.height;
    windowWidth = MediaQuery.of(context).size.width;

    _loginHeight = windowHeight - 280;
    _registerHeight = windowHeight - 280;


    switch(_pageState){
      case 0:
        _backgroundColor = Colors.white;
        _headingColor = Color(0xFF40284A);
        _loginYOffset = windowHeight;
        _registerYOffset = windowHeight;
        _loginXOffset = 0;
        _loginWidth =  windowWidth;
        _loginHeight = _keyboardVisible ? windowHeight : windowHeight - 280;
         _loginOpacity = 1;
        _headingTop = 100;

        break;

      case 1:
          _backgroundColor = Color(0xFFD34C59);
          _headingColor = Colors.white;

          _loginYOffset = _keyboardVisible ? 40 : 280;
          _registerYOffset = windowHeight;
          _loginXOffset = 0;
          _loginWidth =  windowWidth;
          _loginHeight = _keyboardVisible ? windowHeight : windowHeight - 280;
           _loginOpacity = 1;
          _headingTop = 90;

        break;

      case 2:
        _backgroundColor = Color(0xFFD34C59);
        _headingColor = Colors.white;
        _loginYOffset = _keyboardVisible ? 30 : 240;
        _registerYOffset =  _keyboardVisible ? 55 : 280;
        _loginXOffset = 20;
        _loginWidth =  windowWidth - 40;
        _loginHeight = _keyboardVisible ? windowHeight : windowHeight - 250;
        _registerHeight = _keyboardVisible ? windowHeight : windowHeight - 280;
         _loginOpacity = 0.7;
        _headingTop = 80;

        break;
    }


    return Stack(
      children: [

        //FOR SPLASH SCREEN
        AnimatedContainer(
          curve: Curves.fastLinearToSlowEaseIn,
          duration: Duration(milliseconds: 2000),
          color: _backgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //FOR HEADING TEXT
              GestureDetector(
                onTap:(){
                  setState(() {
                    _pageState = 0;
                  });
                },
                child: Container(
                  child: Column(
                    children: [
                      AnimatedContainer(
                        duration: Duration(milliseconds: 2000),
                        curve: Curves.fastLinearToSlowEaseIn,
                        margin:  EdgeInsets.only(top: _headingTop),
                          child: Text("Learn Free",
                          style: TextStyle(
                            color: _headingColor,
                            fontSize: 28
                          ),
                          )
                      ),
                      Container(
                        margin: EdgeInsets.all(32),
                        padding: EdgeInsets.symmetric(horizontal: 20),

                        child: Text("We make learning easy. Join Tvac Studio to learn flutter for free on YouTube.",
                        style: TextStyle(fontSize: 16.0, color: _headingColor),
                          textAlign: TextAlign.center,

                        ),
                      )
                    ],
                  ),
                ),
              ),

              //FOR IMAGE
              Container(
                padding: EdgeInsets.symmetric(horizontal:32 ),
                child: Center(
                    child:
                    Image.asset("assets/images/splash_bg.png")
                ),
              ),

              //FOR BUTTON
              GestureDetector(
                onTap: (){
                  setState(() {
                    if(_pageState !=0){
                      _pageState = 0;
                    }else{
                      _pageState = 1;
                    }
                  });
                },
                child: Container(
                  child: Container(
                    margin: EdgeInsets.all(32.0),
                    padding: EdgeInsets.all(20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFF40284A),
                      borderRadius: BorderRadius.circular(50.0)
                    ),
                    child: Center(
                        child: Text("Get Started",
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                        )
                    ),
                  )
                ),
              ),
            ],
          ),
        ),

        //FOR LOGIN SCREEN
        AnimatedContainer(
          padding: EdgeInsets.all(32),
          width: _loginWidth,
          height: _loginHeight,
          duration: Duration(milliseconds: 2000),
          curve: Curves.fastLinearToSlowEaseIn,
          transform: Matrix4.translationValues(_loginXOffset, _loginYOffset, 1),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(_loginOpacity),
            borderRadius: BorderRadius.only(topRight: Radius.circular(20) , topLeft: Radius.circular(25))
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Text("Login To Continue",
                      style: TextStyle(
                          fontSize: 25,
                          color:  Color(0xFF40284A)
                      ),
                    ),
                  ),
                  InputWithIcon(
                    icon: Icons.email,
                    hint: "Enter Email...",
                  ),
                  SizedBox(height: 20,),
                  InputWithIcon(
                    icon: Icons.vpn_key,
                    hint: "Enter Password...",
                  ),


                ],
              ),
              Column(
                children: [
                  PrimaryButton(
                    btnText: "Login",
                  ),
                  SizedBox(height: 20.0,),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        _pageState = 2;
                      });
                    },
                    child: OutlineBtn(
                      btnText: "Create an Account",
                    ),
                  )
                ],
              ),
            ],
          ),
        ),

        //FOR REGISTER SCREEN
        AnimatedContainer(
          height: _registerHeight,
          padding: EdgeInsets.all(32),
          duration: Duration(milliseconds: 2000),
          curve: Curves.fastLinearToSlowEaseIn,
          transform: Matrix4.translationValues(0, _registerYOffset, 1),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topRight: Radius.circular(20) , topLeft: Radius.circular(25))
          ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Text("Create An Account",
                        style: TextStyle(
                          fontSize: 25,
                          color:  Color(0xFF40284A)
                        ),

                      ),
                    ),
                    InputWithIcon(
                      icon: Icons.email,
                      hint: "Enter Email...",
                    ),
                    SizedBox(height: 20,),
                    InputWithIcon(
                      icon: Icons.vpn_key,
                      hint: "Enter Password...",
                    ),

                  ],
                ),
                Column(
                  children: [
                  PrimaryButton(
                  btnText: "Register",
                ),
                    SizedBox(height: 20.0,),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          _pageState =1;
                        });
                      },
                      child: OutlineBtn(
                        btnText: "Back to Login",
                      ),
                    )
          ]
        ),
              ],
            ),
        )
      ],
    );
  }
}



class InputWithIcon extends StatefulWidget {
  final IconData icon;
  final String hint;
  InputWithIcon({this.icon, this.hint});
  @override
  _InputWithIconState createState() => _InputWithIconState();
}

class _InputWithIconState extends State<InputWithIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
              color: Color(0xFFBC7C7C7),
              width: 2
          ),
          borderRadius: BorderRadius.circular(50)
      ),
      child: Row(
        children: <Widget>[
          Container(
              width: 60,
              child: Icon(
                widget.icon,
                size: 20,
                color: Color(0xFFBB9B9B9),
              )
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 20),
                  border: InputBorder.none,
                  hintText: widget.hint
              ),
            ),
          )
        ],
      ),
    );
  }
}



class PrimaryButton extends StatefulWidget {

  final String btnText;
  PrimaryButton({this.btnText});

  @override
  _PrimaryButtonState createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF40284A),
        borderRadius: BorderRadius.circular(50.0)
      ),
      padding: EdgeInsets.all(20.0),
      child: Center(
       child: Text(widget.btnText,
       style: TextStyle(
         color: Colors.white,
         fontSize: 16
       ),)
      ),
    );
  }
}



class OutlineBtn extends StatefulWidget {

  final String btnText;
  OutlineBtn({this.btnText});

  @override
  _OutlineBtnState createState() => _OutlineBtnState();
}

class _OutlineBtnState extends State<OutlineBtn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xFF40284A),
          width: 2
        ),

          borderRadius: BorderRadius.circular(50.0)
      ),
      padding: EdgeInsets.all(20.0),
      child: Center(
          child: Text(widget.btnText,
            style: TextStyle(
                color: Color(0xFF40284A),
                fontSize: 16
            ),)
      ),
    );
  }
}




