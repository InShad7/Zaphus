import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zaphus/controller/db/db.dart';
import 'package:zaphus/view/utils/color.dart';

class ControllerProvider with ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController barcodeController = TextEditingController();

  GlobalKey<FormState> formKey2 = GlobalKey<FormState>();

  bool validationSuccess = false;
  bool isEditMode = false;
  bool paymentDone = false;
  bool productLoaded = false;

  List productList = [];
  List<Map<String, dynamic>>? products = [];
  List barcodeList = [];

  List myCount = [];

  int count = 1;

  int rewards = 0;

  DatabaseManager databaseManager = DatabaseManager();
  // List<Map<String, dynamic>> products = [
  //   {'id': 1, 'name': 'NIKE', 'image': 'assets/nikedp.jpeg', 'rate': '100'},
  //   {
  //     'id': 2,
  //     'name': 'Nike Canvas',
  //     'image': 'assets/nikedp2.webp',
  //     'rate': '200'
  //   },
  //   {
  //     'id': 3,
  //     'name': 'Nike Air',
  //     'image': 'assets/nikedp3.webp',
  //     'rate': '300'
  //   },
  // ];

  // Future getProducts() async {
  //   final QuerySnapshot querySnapshot =
  //       await FirebaseFirestore.instance.collection('products').get();
  //   final List<DocumentSnapshot> docs = querySnapshot.docs;
  //   // print(docs);
  //   return docs;
  // }

  Future<void> loadUserData() async {
    // Load user data from shared preferences
    final prefs = await SharedPreferences.getInstance();
    nameController.text = prefs.getString('name') ?? '';
    phoneController.text = prefs.getString('phone') ?? '';
    notifyListeners();
  }

  Future<void> saveUserData(BuildContext context) async {
    // Save user data to shared preferences
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('name', nameController.text);
    prefs.setString('phone', phoneController.text);
    Fluttertoast.showToast(msg: 'Saved', backgroundColor: green);
    // Navigator.pushAndRemoveUntil(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => const HomeScreen(),
    //   ),
    //   (route) => false,
    // );
  }

  void toggleEditMode() {
    isEditMode = !isEditMode;
    notifyListeners();
  }

  Future saveNumber() async {
    final pref = await SharedPreferences.getInstance();
    pref.setString('phone', phoneController.text);
  }

  Future isLoggedIn() async {
    final pref = await SharedPreferences.getInstance();
    pref.setBool('isLoggedIn', true);
  }

  void incrementQuantity({product}) {
    if (productList.contains(product['id'])) {
      int index = productList.indexOf(product['id']);
      count = myCount[index];
      if (count == 10) {
        Fluttertoast.showToast(
          msg: 'Limit exceeded',
          backgroundColor: red,
        );
      } else if (count >= 0 && count < 10) {
        count++;
        myCount[index]++;
      }
    }
    notifyListeners();
  }

  void decrementQuantity({product, context}) {
    if (productList.contains(product['id'])) {
      int index = productList.indexOf(product['id']);
      int count = myCount[index];

      if (count > 0 && count <= 10) {
        count--;

        if (count == 0) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  'Remove Product?',
                  style: TextStyle(
                    color: red,
                  ),
                ),
                content: const Text('Do you want to delete this product?'),
                actions: [
                  TextButton(
                    child: Text(
                      'No',
                      style: TextStyle(
                        color: red,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                  ),
                  TextButton(
                    child: Text(
                      'Yes',
                      style: TextStyle(
                        color: green,
                      ),
                    ),
                    onPressed: () {
                      // Remove the product from the list
                      productList.removeAt(index);
                      myCount.removeAt(index);
                      notifyListeners();
                      Fluttertoast.showToast(
                        msg: 'Removed',
                        backgroundColor: red,
                      );
                      Navigator.of(context).pop(); // Close the dialog
                    },
                  ),
                ],
              );
            },
          );
        } else {
          myCount[index] = count;
          notifyListeners();
        }
      } else {
        notifyListeners();
      }
    } else {
      notifyListeners();
    }
  }

  void getCount({product}) {
    print(' inside getcount:::::$myCount');
    if (productList.contains(product['id'])) {
      int index = productList.indexOf(product['id']);
      count = myCount[index];
    }
  }

  // Function to add products to productList
  void addProductsToProductList(List<int> productIDs) {
    productList.clear();
    myCount.clear();

    for (var productId in productIDs) {
      if (!productList.contains(productId)) {
        productList.add(productId);
        myCount.add(1);
        productLoaded = true;
      }
    }
  }

  Future<void> loadFromDB() async {
    await databaseManager.initDataBase();
    List<Map<String, dynamic>>? productDetails =
        await databaseManager.getProductsForCode(barcodeController.text);
    products = productDetails;
    if (productDetails != null) {
      final productIDs =
          productDetails.map((product) => product['id'] as int).toList();
      addProductsToProductList(productIDs);
      // notifyListeners();
    }
  }

  increaseRewards() async {
    rewards = rewards + 300;
  }
}
