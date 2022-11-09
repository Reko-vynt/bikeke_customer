import 'package:bikeke_customer/Customer/models/user.dart';
import 'package:bikeke_customer/Customer/provider/customer_provider.dart';
import 'package:bikeke_customer/Customer/screen/mainScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final _nameCon = TextEditingController();
final _genderCon = TextEditingController();
final _emailCon = TextEditingController(text: 'astercougar@gmail.com');
final _phoneCon = TextEditingController();
final urlImg =
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQm-vCRr5cWB_z1nFGgXIEYUQiw6y-DnOx9qHQ1OKZhcmM1k-ffeA0depZeuu75nNY6GvA&usqp=CAU';

class editProfile extends StatefulWidget {
  @override
  State<editProfile> createState() => _editProfileState();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
}

class _editProfileState extends State<editProfile> {
  bool male = false;
  bool female = false;
  bool gender = false;
  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.green;
    }

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 243, 237, 231),
        appBar: PreferredSize(
            preferredSize:
                const Size.fromHeight(10.0), // here the desired height
            child: AppBar(
              backgroundColor: const Color.fromARGB(255, 255, 160, 0),
              elevation: 0.0,
              leading: const Padding(
                padding: EdgeInsets.only(
                  left: 18.0,
                  top: 12.0,
                  bottom: 12.0,
                  right: 12.0,
                ),
              ),
            )),
        body: SingleChildScrollView(
          child: Form(
            key: widget.formKey,
            child: Column(children: [
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Text(
                  "Welcome to BikeKe ",
                  style: TextStyle(
                      fontSize: 30,
                      color: Color.fromARGB(255, 255, 153, 0),
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Center(
                  child: CircleAvatar(
                radius: 48, // Image radius
                backgroundImage: NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQm-vCRr5cWB_z1nFGgXIEYUQiw6y-DnOx9qHQ1OKZhcmM1k-ffeA0depZeuu75nNY6GvA&usqp=CAU'),
              )),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: <Widget>[
                  Text(
                    "Name: ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      child: TextFormField(
                        decoration:
                            InputDecoration(labelText: "Your Full Name"),
                        controller: _nameCon,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Name not blank";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  const Text(
                    "Gender: ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Male: ",
                    style: TextStyle(fontSize: 20),
                  ),
                  Expanded(
                      child: Checkbox(
                          checkColor: Colors.white,
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: male,
                          onChanged: (bool? value) {
                            setState(() {
                              male = value!;
                              female = !male;
                              gender = true;
                            });
                          })),
                  const Text(
                    "Female: ",
                    style: TextStyle(fontSize: 20),
                  ),
                  Expanded(
                      child: Checkbox(
                          checkColor: Colors.white,
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: female,
                          onChanged: (bool? value) {
                            setState(() {
                              female = value!;
                              male = !female;
                              gender = false;
                            });
                          }))
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  const Text(
                    "E-mail: ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      child: TextFormField(
                        readOnly: true,
                        decoration:
                            InputDecoration(labelText: "astercougar@gmail.com"),
                        controller: _emailCon,
                        validator: (value) {},
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  const Text(
                    "Phone: ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      child: TextFormField(
                        decoration: InputDecoration(labelText: "Your Phone"),
                        controller: _phoneCon,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Phone not blank";
                          } else if (value.length != 10) {
                            return "Phone contain 10 digts";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: ElevatedButton(
                      child: Text("Update"),
                      onPressed: () {
                        Customer cus = new Customer(
                            email: _emailCon.text,
                            name: _nameCon.text,
                            phone: _phoneCon.text,
                            img: urlImg,
                            gender: male ? "MALE" : "FEMALE");
                        Future<String> result =
                            customerProvider.updProfile(cus);
                        result.then((value) => print(value));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => mainScreen()));
                      }))
            ]),
          ),
        ));
  }
}
