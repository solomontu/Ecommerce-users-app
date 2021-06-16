import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ecom/models/brandModel.dart';
import 'package:flutter_ecom/models/goryModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//GLOBAL VARIABLE
final brandGoryServices = Provider((ref) => BrandGoryServices());

StreamProvider<List<GoryModel>> goryStream =
    StreamProvider<List<GoryModel>>((ref) {
  final repository = ref.read(brandGoryServices);
  return repository.catStream();
});

//GORY FUTURE FOR SEACH FIELD
FutureProvider<List<GoryModel>> goryFutue =
    FutureProvider<List<GoryModel>>((ref) async {
  final repository = ref.read(brandGoryServices);
  return repository.goryFuture();
});

FutureProvider<List<BrandModel>> brandProvider =
    FutureProvider<List<BrandModel>>((ref) async {
  final repository = ref.read(brandGoryServices);
  return repository.bradFuture();
});

class BrandGoryServices {
  FirebaseFirestore _colref = FirebaseFirestore.instance;

//BUILT WITH RIVERPOD STREAM BUILDER
  //CATEGORY
  Stream<List<GoryModel>> catStream() {
    return _colref.collection("Categories").snapshots().map(
        (event) => event.docs.map((e) => GoryModel.catSnapShot(e)).toList());
  }

//Gory furture
  Future<List<GoryModel>> goryFuture() async {
    List<GoryModel> list = [];
    try {
      await _colref.collection("Categories").get().then((value) {
        for (var item in value.docs) {
          list.add(GoryModel.catSnapShot(item));
        }
      });
    } on Exception catch (e) {
      print(e.toString());
    }
    print(list);
    printi();

    return list;
  }

//BUILT WITH RIVERPOD FUTURE BUILDER
//BRAND
  Future<List<BrandModel>> bradFuture() async {
    List<BrandModel> list = [];
    try {
      await _colref.collection("Brands").get().then((value) {
        for (var item in value.docs) {
          list.add(BrandModel.brandSnapShot(item));
        }
      });
    } on Exception catch (e) {
      print(e.toString());
    }
    print(list);
    printi();

    return list;
  }

  printi() {
    var p = catStream();
    print(p);
  }
}
