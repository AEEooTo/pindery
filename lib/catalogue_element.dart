import 'package:cloud_firestore/cloud_firestore.dart' show DocumentSnapshot;

class CatalogueElement {
  CatalogueElement({this.elementName, this.elementQuantity, this.chosenQuantity});
  String elementName;
  int elementQuantity;
  int elementValue;
  int chosenQuantity = 0;
  int get remainingQuantity => elementQuantity - chosenQuantity;

  CatalogueElement.fromFirestore(DocumentSnapshot snapshot) {
    elementName = snapshot['name'];
    elementValue = snapshot['value'];
    elementQuantity = 1;
  }

}