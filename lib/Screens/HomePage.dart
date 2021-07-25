import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:task_app/ApiData/apiData.dart';
import 'dart:convert';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<Message> messages;

  Future<Message> getUserData() async {
    var response = await http.get(Uri.parse(
        'https://test.extensionceramics.com/api/method/erpnext.accounts.doctype.purchase_invoice.purchase_invoice.tally_integration'));
    final jsonresponse = json.decode(response.body);
    Message mssg = new Message.fromJson(jsonresponse);
    print(mssg);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // ApiData values = new ApiData(message: jsonresponse);
      return Message.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    super.initState();
    messages = getUserData();
  }

  Widget build(BuildContext context) {
    GoogleSignIn _googleSignIn = GoogleSignIn();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              _googleSignIn.signOut();
              Navigator.pop(context);
            },
            icon: Icon(Icons.logout)),
        title: Text(widget.title),
      ),
      body: FutureBuilder<Message>(
          future: messages,
          builder: (context, snapshot) {
            return snapshot.hasData
                ? Center(
                    child: Container(
                      width: 360,
                      child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemExtent: 250,
                          itemCount: snapshot.data!.messages.length,
                          itemBuilder: (context, index) {
                            var doc = snapshot.data!.messages[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                  elevation: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Supplier Name: ${doc.purchaseInvoiceNo},',
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          'Purchase Invoice Number ${doc.supplier},',
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          'Supplier Name: ${doc..supplierName},',
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          'Posting Date: ${doc.postingDate},',
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          'Credit To: ${doc.creditTo},',
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          'against Expense Account: ${doc.againstExpenseAccount},',
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          'Cost: ${doc.cost},',
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        doc.debitNote != null
                                            ? Text(
                                                'Debit Note: ${doc.debitNote},',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                ),
                                              )
                                            : Text('')
                                      ],
                                    ),
                                  )),
                            );
                          }),
                    ),
                  )
                : snapshot.hasError
                    ? Text('${snapshot.error}')
                    : Center(child: CircularProgressIndicator());
          }),
    );
  }
}
