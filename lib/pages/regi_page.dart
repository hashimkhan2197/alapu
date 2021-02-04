import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:alapu/widgets/btn_widget.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'login_page.dart';
import 'menu_page.dart';

class RegPage extends StatefulWidget {
  @override
  _RegPageState createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {
  List<String> countryList = [
    'Afghanistan',
    'Albania',
    'Algeria',
    'Andorra',
    'Angola',
    'Antigua and Barbuda',
    'Argentina',
    'Armenia',
    'Australia',
    'Austria',
    'Austrian Empire',
    'Azerbaijan',
    'Baden',
    'Bahamas',
    'Bahrain',
    'Bangladesh',
    'Barbados',
    'Bavaria',
    'Belarus',
    'Belgium',
    'Belice',
    'Bolivia',
    'Bosnia and Herzegovina',
    'Botswana',
    'Brasil',
    'Brunei',
    'Brunswick and Lüneburg',
    'Bulgaria',
    'Puerto Rico',
    'Burma',
    'Burundi',
    'Cabo Verde',
    'Cambodia',
    'Cameroon',
    'Canada',
    'Cayman Islands',
    'Central American Federation',
    'Chad',
    'Chile',
    'China',
    'Colombia',
    'Comoros',
    'Costa Rica',
    'Cote d’Ivoire',
    'Croatia',
    'Cuba',
    'Cyprus',
    'Czechia',
    'Czechoslovakia',
    'Congo',
    'Denmark',
    'Djibouti',
    'Duchy of Parma',
    'Germany',
    'Ecuador',
    'Egypt',
    'Equatorial Guinea',
    'Eritrea',
    'Estonia',
    'Eswatini',
    'Ethiopia',
    'Fiji',
    'Finland',
    'France',
    'Gabon',
    'Gambia',
    'Georgia',
    'Germany',
    'Ghana',
    'Greece',
    'Grenada',
    'Guatemala',
    'Guinea',
    'Guyana',
    'Haiti',
    'Hanover',
    'Hanseatic Republics',
    'Hawaii',
    'Hesse',
    'Honduras',
    'Hungary',
    'Iceland',
    'India',
    'Indonesia',
    'Iran',
    'Iraq',
    'Ireland',
    'Israel',
    'Italy',
    'Jamaica',
    'Japan',
    'Jordan',
    'Kazakhstan',
    'Kenya',
    'Kingdom of Serbia',
    'Kiribati',
    'Kosovo',
    'Kuwait',
    'Kyrgyzstan',
    'Laos',
    'Latvia',
    'Lebanon',
    'Lesotho',
    'Liberia',
    'Libya',
    'Liechtenstein',
    'Lithuania',
    'Luxembourg',
    'Madagascar',
    'Malawi',
    'Malaysia',
    'Maldives',
    'Mali',
    'Malta',
    'Marshall Islands',
    'Mauritania',
    'Mauritius',
    'Mexico',
    'Micronesia',
    'Moldova',
    'Monaco',
    'Mongolia',
    'Montenegro',
    'Morocco',
    'Mozambique',
    'Namibia',
    'Nauru',
    'Nepal',
    'Netherlands',
    'New Zealand',
    'Nicaragua',
    'Niger',
    'Nigeria',
    'Norway',
    'Oman',
    'Pakistan',
    'Palau',
    'Panama',
    'Papua New Guinea',
    'Paraguay',
    'Perú',
    'Philippines',
    'Poland',
    'Portugal',
    'Qatar',
    'Romania',
    'República Dominica',
    'Russia',
    'Rwanda',
    'Samoa',
    'Salvador',
    'San Marino',
    'Saudi Arabia',
    'Senegal',
    'Serbia',
    'Seychelles',
    'Sierra Leone',
    'Singapore',
    'Slovakia',
    'Slovenia',
    'Solomon Islands',
    'Somalia',
    'South Africa',
    'South Sudan',
    'South Korea',
    'Spain',
    'Sri Lanka',
    'Sudan',
    'Suriname',
    'Sweden',
    'Switzerland',
    'Syria',
    'Tajikistan',
    'Tanzania',
    'Thailand',
    'Timor-Leste',
    'Togo',
    'Tonga',
    'Trinidad y Tobago',
    'Tunisia',
    'Turkey',
    'Turkmenistan',
    'Tuvalu',
    'Uganda',
    'Ukraine',
    'UAE',
    'United Kingdom',
    'Uruguay',
    'Uzbekistan',
    'Vanuatu',
    'Venezuela',
    'Vietnam',
    'Yemen',
    'Zambia',
    'Zimbabwe'
  ];

  List<String> andina = ['Bolivia', 'Colombia', 'Ecuador', 'Perú', 'Venezuela'];
  List<String> caribe = [
    'Belice',
    'Cuba',
    'Trinidad y Tobago',
    'Suriname',
    'Salvador',
    'República Dominicana',
    'Puerto Rico',
    'Panama',
    'Nicaragua',
    'Jamaica',
    'Honduras',
    'Haiti',
    'Guyana',
    'Guatemala',
    'Costa Rica',
  ];
  List<String> sur = [
    'Argentina',
    'Uruguay',
    'Paraguay',
    'Chile',
  ];
  List<String> norte = ['Mexico'];
  List<String> occidental = [
    'Brasil',
  ];

  List<DropdownMenuItem<String>> _dropdownMenuItems;
  String _selectedCountry;
  String _selectedRegion = "";

  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems();
    _selectedCountry = 'Bolivia';
    _selectedRegion = 'Región Andina';
    super.initState();
  }

  List<DropdownMenuItem<String>> buildDropdownMenuItems() {
    List<DropdownMenuItem<String>> items = List();
    for (String cntry in countryList) {
      items.add(
        DropdownMenuItem(
          value: cntry,
          child: Text(cntry),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(String selected) {
    setState(() {
      _selectedCountry = selected;
      if (andina.contains(selected)) {
        _selectedRegion = 'Región Andina';
      } else if (caribe.contains(selected)) {
        _selectedRegion = 'Región Centro Caribe';
      } else if (sur.contains(selected)) {
        _selectedRegion = 'Región Cono Sur';
      } else if (norte.contains(selected)) {
        _selectedRegion = 'Región Norte';
      } else if (occidental.contains(selected)) {
        _selectedRegion = 'Región Sur Occidental';
      } else {
        _selectedRegion = 'Región Otros';
      }
    });
  }

  var _formKey = GlobalKey<FormState>();

  ///Text Editing Controllers
  TextEditingController nombreController = TextEditingController();
  TextEditingController apellidoController = TextEditingController();
  TextEditingController lugarController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    nombreController.dispose();
    apellidoController.dispose();
    lugarController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  ///image picker
  File _image;
  String _imageUrl = "";
  bool signupLoading = false;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = image;
      });

      final FirebaseStorage _storgae =
          FirebaseStorage(storageBucket: 'gs://alap-d3940.appspot.com/');
      StorageUploadTask uploadTask;
      String filePath = '${DateTime.now()}.png';
      uploadTask = _storgae.ref().child(filePath).putFile(image);
      uploadTask.onComplete.then((_) async {
        print(1);
        String url1 = await uploadTask.lastSnapshot.ref.getDownloadURL();
        print(url1);
        _imageUrl = url1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.grey[50],
            iconTheme: IconThemeData(color: Colors.black),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(bottom: 20),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),

                  ///alap Logo
                  Container(
                    height: 130,
                    child: Image(image: AssetImage('assets/alap_logo.png')),
                  ),
                  SizedBox(
                    height: 30,
                  ),

                  //Sign up heading
                  Container(
                    child: Center(
                      child: Text(
                        'Registrate Ahora',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.blue[500],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  //pick image
                  InkWell(
                    child: CircleAvatar(
                      backgroundImage:
                          _image != null ? FileImage(_image) : null,
                      child: _image == null
                          ? Icon(
                              Icons.camera_alt,
                              size: 50,
                            )
                          : null,
                      maxRadius: 70,
                      backgroundColor: HexColor("#F2F2F5"),
                    ),
                    onTap: getImage,
                  ),

                  //sign up textfields
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          _textInput(
                              hint: "Nombre",
                              icon: Icons.person,
                              controller: nombreController),
                          _textInput(
                              controller: apellidoController,
                              hint: "Apellido",
                              icon: Icons.person_outline),
                          _textInput(
                              controller: lugarController,
                              hint: "Lugar de Trabajo",
                              icon: Icons.add_location),
                          _textInput(
                              hint: "Email",
                              icon: Icons.email,
                              controller: emailController),
                          _textInput(
                              hint: "Phone Number",
                              icon: Icons.call,
                              controller: phoneController),
                          _passwordInput(
                              hint: 'Password',
                              icon: Icons.lock,
                              controller: passwordController),
//                        _textInput(hint: "Nacionalidad", icon: Icons.flag),
                          SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 60,
                            margin: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                                color: HexColor("#F2F2F5"),
                                // color:Colors.g
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, 0.1),
                                      offset: Offset(6, 2),
                                      blurRadius: 6.0,
                                      spreadRadius: 3.0),
                                  BoxShadow(
                                      color: Color.fromRGBO(255, 255, 255, 0.9),
                                      offset: Offset(-6, -2),
                                      blurRadius: 6.0,
                                      spreadRadius: 3.0)
                                ]),
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                            child: DropdownButton(
                              value: _selectedCountry,
                              items: _dropdownMenuItems,
                              onChanged: onChangeDropdownItem,
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          _textoutput(
                              hint: _selectedRegion, icon: Icons.location_city),
                          SizedBox(
                            height: 30,
                          ),

                          // Sign up button
                          signupLoading
                              ? CircularProgressIndicator()
                              : ButtonWidget(
                                  btnText: "Completo",
                                  onClick: () async {
                                    //Condition to see if profile image is uploaded
                                    if (_imageUrl != "" &&
                                        _formKey.currentState.validate()) {
                                      signUp();
                                    } else {
                                      _imageUrl == ''
                                          ? showDialog(
                                              context: context,
                                              child: AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(18.0),
                                                    side: BorderSide(
                                                      color: Colors.red[400],
                                                    )),
                                                title: Text("Wait..."),
                                                content:
                                                    Text("Image Not Uploaded"),
                                                actions: <Widget>[
                                                  FlatButton(
                                                    child: Text(
                                                      "OK",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.red[400]),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                  )
                                                ],
                                              ))
                                          : null;
                                    }
                                  },
                                ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: Image.asset(
            "assets/up.png",
            width: 100,
          ),
        ),
      ],
    );
  }

  ///Container for text input field
  Widget _textInput({controller, hint, icon,keytype}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 60,
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
            color: HexColor("#F2F2F5"),
            // color:Colors.g
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.1),
                  offset: Offset(6, 2),
                  blurRadius: 6.0,
                  spreadRadius: 3.0),
              BoxShadow(
                  color: Color.fromRGBO(255, 255, 255, 0.9),
                  offset: Offset(-6, -2),
                  blurRadius: 6.0,
                  spreadRadius: 3.0)
            ]),
        padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
        child: TextFormField(
          validator: (value) {
            if (value.isEmpty) {
              return "This field must not be empty.";
            }
            return null;
          },
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            prefixIcon: Icon(icon),
          ),
        ),
      ),
    );
  }

  Widget _textoutput({hint, icon}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          height: 60,
          margin: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
              color: HexColor("#F2F2F5"),
              // color:Colors.g
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.1),
                    offset: Offset(6, 2),
                    blurRadius: 6.0,
                    spreadRadius: 3.0),
                BoxShadow(
                    color: Color.fromRGBO(255, 255, 255, 0.9),
                    offset: Offset(-6, -2),
                    blurRadius: 6.0,
                    spreadRadius: 3.0)
              ]),
          padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
          child: ListTile(
            leading: Icon(icon),
            title: Text(hint),
          )
          ),
    );
  }
  Widget _passwordInput({controller, hint, icon}) {
    return Container(
      height: 60,
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          color: HexColor("#F2F2F5"),
          // color:Colors.g
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                offset: Offset(6, 2),
                blurRadius: 6.0,
                spreadRadius: 3.0),
            BoxShadow(
                color: Color.fromRGBO(255, 255, 255, 0.9),
                offset: Offset(-6, -2),
                blurRadius: 6.0,
                spreadRadius: 3.0)
          ]),
      padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
      child: TextFormField(
        obscureText: true,
        controller: controller,
        validator: (value) {
          if (value.isEmpty) {
            return "This field must not be empty.";
          }
          return null;
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }

  ///Firebase creating user with email & password and error handling
  Future<void> signUp() async {
    setState(() {
      signupLoading = true;
    });
    try {
      final AuthResult user =
          (await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      ));

      if (user != null) {
        String userUid = user.user.uid;

        await addUsertoFirebase(userUid);

        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) {
          return Menu();
        }), (route) => false);
        setState(() {
          signupLoading = false;
        });

        // setState(() {
        //   _success = true;
        //   _userEmail = user.email;
        // }

      }
    } catch (signUpError) {
      setState(() {
        signupLoading = false;
      });

      //Error handling
      if (signUpError is PlatformException) {
        if (signUpError.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
          showDialog(
              context: context,
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(
                      color: Colors.red[400],
                    )),
                title: Text("Email already in use"),
                actions: <Widget>[
                  FlatButton(
                    child: Text(
                      "OK",
                      style: TextStyle(color: Colors.red[400]),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ));
        }

        if (signUpError.code == 'ERROR_WEAK_PASSWORD') {
          showDialog(
              context: context,
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(
                      color: Colors.red[400],
                    )),
                title: Text("Weak Password"),
                actions: <Widget>[
                  FlatButton(
                    child: Text(
                      "OK",
                      style: TextStyle(color: Colors.red[400]),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ));
        }

        if (signUpError.code == 'ERROR_INVALID_EMAIL') {
          showDialog(
              context: context,
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(
                      color: Colors.red[400],
                    )),
                title: Text("Invalid Email"),
                actions: <Widget>[
                  FlatButton(
                    child: Text(
                      "OK",
                      style: TextStyle(color: Colors.red[400]),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ));
        }
      }
    }
  }

  ///function to add user data to a firebase collection
  Future<void> addUsertoFirebase(String userUid) async {
    await Firestore.instance.collection("users").document(userUid).setData({
      'activated': false,
      'userImage': _imageUrl,
      'nombre': nombreController.text,
      'apellido': apellidoController.text,
      'lugar': lugarController.text,
      'email': emailController.text,
      'phone': phoneController.text,
      'nationality': _selectedCountry,
      'region': _selectedRegion,
      'password': passwordController.text,
      'membershipCertificate': '',
      'uce':'',
      'memberSince':'',
      'identityDoc':'',
      'tituloDoc':'',
      'laboralDoc':''
    });
  }
}
