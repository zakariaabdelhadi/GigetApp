import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:lastgiget/screens/Explore.dart';

class AddInserat extends StatefulWidget {
  const AddInserat({Key? key}) : super(key: key);

  @override
  State<AddInserat> createState() => _AddInseratState();
}

class _AddInseratState extends State<AddInserat> {
  final current_user = FirebaseAuth.instance.currentUser!;
  final category_list = ['Games', 'Electronics', 'Textile', 'Books'];
  String? value_dropdown;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  PlatformFile? pickeledFile;
  UploadTask? uploadTask;

  bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600;

  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  Future pickleFile() async {
    final result = await FilePicker.platform.pickFiles();

    if (result == null) return;

    setState(() {
      pickeledFile = result.files.first;
    });
  }

  Future deletDocument(String id) async {
    final docUser =
        FirebaseFirestore.instance.collection("Inserat").doc("${id}");

    docUser.delete();
  }

  Future uploadArticl() async {
    final docUser = FirebaseFirestore.instance.collection("Inserat").doc();

    final path = 'images/${pickeledFile!.name}';
    final file = File(pickeledFile!.path!);
    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);
    final snapshot = await uploadTask!.whenComplete(() =>
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Article uploaded"))));
    final urlFile = await snapshot.ref.getDownloadURL();
    //////////////// send to firestore ////////////
    final title = titleController.text;
    final description = descriptionController.text;
    final photo = urlFile;

    createArticle(
        category: value_dropdown!,
        desciption: description,
        title: title,
        photo: urlFile);

    showMyDialog(context);
  }

  void showMyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => Scaffold(
        body: Center(
          child: SizedBox(
            height: 100,
            width: 300,
            child: Container(
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.gpp_good,
                        color: Colors.green,
                      ),
                      Text(
                        "Article uploaded succefully ",
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                    ],
                  ),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          titleController.text = "";
                          descriptionController.text = "";
                          pickeledFile = null;
                        });
                        Navigator.pop(context);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) =>
                        //            Explore(update:  (int count) {
                        //   int currentTab;
                        //   setState(() => currentTab = count);
                        //
                        //   })),
                        // );
                      },
                      child: Text("OK")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future createArticle(
      {required String title,
      required String desciption,
      required String photo,
      required String category}) async {
    final docUser = FirebaseFirestore.instance.collection("Inserat").doc();
    final json = {
      'id_user': current_user.uid,
      'name': title,
      'description': desciption,
      'photo': photo,
      'category': category,
    };
    await docUser.set(json);
    //  return;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ListView(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        child: BackButton(
                          //  Icons.close,
                          color: Colors.black,
                          onPressed: () {
                            if (Navigator.canPop(context)) {
                              Navigator.pop(context);
                            } else {
                              Navigator.pop(context);
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  height: 300,
                  width: 400,
                  decoration: BoxDecoration(color: Colors.black12),
                  child: pickeledFile != null
                      ? Image.file(
                          File(pickeledFile!.path!),
                          fit: BoxFit.fill,
                        )
                      : null,
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 200,
                  height: 60,
                  child:
                      insertButton(), //////////////////// insert Button to pick a file
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Divider(
                        color: Colors.black38,
                        thickness: 1,
                      ),
                      Container(
                        decoration: BoxDecoration(),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            hint: Text("Select a Category"),
                            value: value_dropdown,
                            isExpanded: true,
                            iconSize: 36,
                            icon: Icon(Icons.chevron_right),
                            items: category_list.map(buidMenuItem).toList(),
                            onChanged: (value) => setState(
                              () {
                                this.value_dropdown = value;
                              },
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.black38,
                        thickness: 1,
                      ),
                      Container(
                        height: 50,
                        child: TextFormField(
                            controller: titleController,
                            decoration: new InputDecoration.collapsed(
                                hintText: 'give a title to your article')),
                      ),
                      Divider(
                        color: Colors.black38,
                        thickness: 1,
                      ),
                      Container(
                        height: 250,
                        //   decoration: BoxDecoration(color: Colors.black12),

                        child: TextFormField(
                          controller: descriptionController,
                          decoration: new InputDecoration.collapsed(
                              hintText:
                                  'Describe your article, size, color,,,'),
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        height: 60,
                        child: OutlinedButton(
                          onPressed: () {
                            uploadArticl();
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Article uploaded")));
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                // side: BorderSide(
                                //     color: Colors.black, width: 1, style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(20.0))),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.upload,
                                size: 30,
                                color: Colors.lightBlueAccent,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                  child: Text(
                                "Upload ",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black38),
                              )),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  DropdownMenuItem<String> buidMenuItem(String item) {
    return DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: TextStyle(
          fontSize: 15,
        ),
      ),
    );
  }

  Widget insertButton() {
    return OutlinedButton(
      onPressed: () {
        // User canceled the picker

        pickleFile();
        // User canceled the picker
      },
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add,
            size: 30,
            color: Colors.lightBlueAccent,
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
              child: Text(
            "Upload Image",
            style: TextStyle(fontSize: 18, color: Colors.black38),
          )),
        ],
      ),
    );
  }
}
