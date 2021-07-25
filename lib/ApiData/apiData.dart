class Message {
  List<MessageList> messages;
  Message({required this.messages});
  factory Message.fromJson(Map<String, dynamic> json) {
    var list = json['message'] as List;
    List<MessageList> messageList =
        list.map((messages) => MessageList.fromJson(messages)).toList();
    return Message(messages: messageList);
  }
}

class MessageList {
  String purchaseInvoiceNo;
  String supplier;
  String supplierName;
  String postingDate;
  String creditTo;
  String againstExpenseAccount;
  double cost;
  bool? debitNote;
  MessageList(
      {required this.againstExpenseAccount,
      required this.cost,
      required this.creditTo,
      required this.debitNote,
      required this.postingDate,
      required this.purchaseInvoiceNo,
      required this.supplier,
      required this.supplierName});

  factory MessageList.fromJson(Map<String, dynamic> json) {
    return MessageList(
        againstExpenseAccount: json['against_expense_account'],
        cost: json['cost'],
        creditTo: json['credit_to'],
        debitNote: json['debit_note'],
        postingDate: json['posting_date'],
        purchaseInvoiceNo: json['purchase_invoice_no'],
        supplier: json['supplier'],
        supplierName: json['supplier_name']);
  }
}
// class ApiData {
//   late List<Message> message;

//   ApiData({required this.message});

//   // factory ApiData.fromJson(Map<String, dynamic> json) {
//   //   return ApiData(message: json['message']);
//   // }
//   ApiData.fromJson(Map<String, dynamic> json) {
//     if (json['message'] != null) {
//       message = <Message>[];
//       json['message'].forEach((v) {
//         message.add(new Message.fromJson(v));

//         print(message);
//         return message;
//       });
//     }
//     toJson();
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['message'] = this.message.map((v) => v.toJson());
//     print('function called');
//     // print(data.entries);
//     return data;
//   }
// }

// class Message {
//   late String? purchaseInvoiceNo;
//   late String? supplier;
//   late String? supplierName;
//   late String? postingDate;
//   late String? creditTo;
//   late String? againstExpenseAccount;
//   late String? cost;
//   late bool debitNote = false;

//   Message(
//       {required this.purchaseInvoiceNo,
//       required this.supplier,
//       required this.supplierName,
//       required this.postingDate,
//       required this.creditTo,
//       required this.againstExpenseAccount,
//       required this.cost,
//       required this.debitNote});

//   Message.fromJson(Map<String, dynamic> json) {
//     purchaseInvoiceNo = json['purchase_invoice_no'];
//     supplier = json['supplier'];
//     supplierName = json['supplier_name'];
//     postingDate = json['posting_date'];
//     creditTo = json['credit_to'];
//     againstExpenseAccount = json['against_expense_account'];
//     cost = json['cost'].toString();
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['purchase_invoice_no'] = this.purchaseInvoiceNo;
//     data['supplier'] = this.supplier;
//     data['supplier_name'] = this.supplierName;
//     data['posting_date'] = this.postingDate;
//     data['credit_to'] = this.creditTo;
//     data['against_expense_account'] = this.againstExpenseAccount;
//     data['cost'] = this.cost;
//     data['debit_note'] = this.debitNote;
//     return data;
//   }
// }
