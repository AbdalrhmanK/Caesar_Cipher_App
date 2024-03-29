import 'package:flutter/material.dart';

class CaesarCipher extends StatefulWidget {
  @override
  State<CaesarCipher> createState() {
    return _CaesarCipherState();
  }
}

class _CaesarCipherState extends State<CaesarCipher> {
  TextEditingController _controller = TextEditingController(); // For Encryption
  TextEditingController _controller2 =
      TextEditingController(); // For Decryption
  int _shift = 3;
  String _resultencryption = '';
  String _resultdecryption = '';
  void _encrypt() {
    // c = p+k mod 26
    String plainText = _controller.text;
    String cipherText = '';
    if (plainText.isEmpty) {
      setState(() {
        _resultencryption = cipherText;
      });
      _showAlertDialog('Please enter text to encrypt.');
      return;
    }

    for (int i = 0; i < plainText.length; i++) {
      String char = plainText[i];
      // Make sure the letter is string or charachter
      if (char.contains(RegExp(r'[A-Za-z]'))) {
        // Convert the character to its ASCII code 0
        int asciiCode = char.codeUnitAt(0);
        // Determine if the character is uppercase or lowercase
        if (char == char.toUpperCase()) {
          // Apply the shift to the ASCII code of the character, wrapping around if necessary
          // UpperCae  = 65 - 90
          int shiftedCode = (asciiCode - 65 + _shift) % 26 + 65;
          // Convert the shifted ASCII code back to a character
          // LowerCase = 97 - 122
          char = String.fromCharCode(shiftedCode);
        } else {
          int shiftedCode = (asciiCode - 97 + _shift) % 26 + 97;
          char = String.fromCharCode(shiftedCode);
        }
      } else if (char != ' '){
        setState(() {
          _resultencryption = '';
        });
        _showAlertDialog('The text should contain only letters.');
        return;
      }
      // Append the encrypted character to the cipher text
      cipherText += char;
    }
    setState(() {
      _resultencryption = cipherText;
    });
  }

  void _Decrypt() {
    // p = c+k mod 26
    String cipherText = _controller2.text;
    String plainText = '';

    if (cipherText.isEmpty) {
      setState(() {
        _resultdecryption = ' ';
      });
      _showAlertDialog('Please enter text to decrypt.');
      return;
    }

    for (int i = 0; i < cipherText.length; i++) {
      String char = cipherText[i];
      if (char.contains(RegExp(r'[A-Za-z]'))) {
        int asciiCode = char.codeUnitAt(0);
        if (char == char.toUpperCase()) {
          // UpperCae  = 65 - 90
          int shiftedCode = (asciiCode - 65 - _shift) % 26 + 65;
          char = String.fromCharCode(shiftedCode);
        } else {
          // LowerCase = 97 - 122

          int shiftedCode = (asciiCode - 97 - _shift) % 26 + 97;
          char = String.fromCharCode(shiftedCode);
        }
      } else if (char != ' '){
        setState(() {
          _resultdecryption = ' ';
        });
        _showAlertDialog('The text should contain only letters.');
        return;
      }
      plainText += char;
    }
    setState(() {
      _resultdecryption = plainText;
    });
  }

  void _showAlertDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Caesar Cipher'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Enter a message to encrypt',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _controller2,
              decoration: InputDecoration(
                hintText: 'Enter a message to Decrypt',
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Text('key: '),
                SizedBox(width: 16.0),
                DropdownButton<int>(
                  value: _shift,
                  items: List.generate(26, (i) => i + 1)
                      .map((i) => DropdownMenuItem(
                            value: i,
                            child: Text(i.toString()),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _shift = value!;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _encrypt,
                  child: Text('Encrypt'),
                ),
                SizedBox(
                  width: 150,
                ),
                ElevatedButton(
                  onPressed: _Decrypt,
                  child: Text('Decrypt'),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 10.0),
                Text('Encrypt'),
                TextField(
                  enabled: false,
                  decoration: InputDecoration(
                    hintText: _resultencryption,
                  ),
                ),
                SizedBox(height: 8.0),
                Text('Decrypt'),
                Column(
                  children: [
                    TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        hintText: _resultdecryption,
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
