import 'package:digital_document_verification_portal/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'my_encryption.dart';
import 'package:digital_document_verification_portal/screens/myfiles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController tec = TextEditingController();
  var encryptedText, plainText;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 50,
        margin: const EdgeInsets.all(10),
        child: ElevatedButton(
          onPressed: () {
            FirebaseAuth.instance.signOut().then((value) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => loginScreen()));
            });
          },
          style:
              ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple[300]),
          child: const Center(
            child: Text("Logout"),
          ),
        ),
      ),
      appBar: AppBar(
        title: Text("Encryption/Decryption"),
        backgroundColor: Colors.deepPurple[300],
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: tec,
              ),
            ),
            Column(
              children: [
                Text(
                  "PLAIN TEXT",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.deepPurple[300],
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(plainText == null ? "" : plainText),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  "ENCRYPTED TEXT",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.deepPurple[300],
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(encryptedText == null
                      ? ""
                      : encryptedText is encrypt.Encrypted
                          ? encryptedText.base64
                          : encryptedText),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    plainText = tec.text;
                    setState(() {
                      encryptedText =
                          MyEncryptionDecryption.encryptFernet(plainText);
                    });
                    tec.clear();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple[300]),
                  child: Text("Encrypt"),
                ),
                SizedBox(
                  width: 15,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      encryptedText =
                          MyEncryptionDecryption.decryptFernet(encryptedText);
                      print("Type: " + encryptedText.runtimeType.toString());
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple[300]),
                  child: Text("Decrypt"),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: Text("My Files"),
                  onPressed: () {
                    FirebaseAuth.instance.signOut().then((value) {});
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => myFiles()));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple[300]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
