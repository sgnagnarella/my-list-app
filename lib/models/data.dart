import 'package:cloud_firestore/cloud_firestore.dart';

class Data {
  final String item;
  final int quantity;

  Data({required this.item, required this.quantity});

  // Factory constructor to create MyData from a Firestore document snapshot
  factory Data.fromSnapshot(DocumentSnapshot doc) {
    return Data(
      item: doc['item'],
      quantity: doc['quantity'],
    );
  }

  void saveData() async {
    await FirebaseFirestore.instance.collection('travel_list').add({
      'item': item,
      'quantity': quantity,
    });
  }

  static Future<List<Data>> fetchData() async {
    // FirebaseFirestore.instance.collection('travel_list').add({
    //   'item': 'Shoes', 
    //   'quantity': 0, // Replace with your actual field names and values
    // });

    final snapshot = await FirebaseFirestore.instance.collection('travel_list').get();
    return snapshot.docs.map((doc) => Data.fromSnapshot(doc)).toList();
  }

  static Stream<List<Data>> fetchDataStream() {
    return FirebaseFirestore.instance
        .collection('travel_list')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Data.fromSnapshot(doc)).toList());
  }


}

