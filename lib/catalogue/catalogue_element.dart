/// Is the class that defines an element in the party catalogue

class CatalogueElement {
  CatalogueElement({this.elementName, this.elementQuantity, this.chosenQuantity, this.elementValue});
  String elementName;
  int elementQuantity;
  int elementValue;
  int chosenQuantity = 0;
  String elementId;
  int get remainingQuantity => elementQuantity - chosenQuantity;

  CatalogueElement.fromFirestore(Map snapshot, String id) {
    elementId = id;
    elementName = snapshot['name'];
    elementValue = snapshot['value'];
    elementQuantity = 1;
  }

  CatalogueElement.fromMap(Map map) {
    elementName = map['elementName'];
    elementValue = map['elementValue'];
    elementQuantity = map['elementQuantity'];
    elementId = map['elementId'];
    chosenQuantity = map['chosenQuantity'];
  }

  catalogueElementMapper() {
    return <String, dynamic> {
      'elementName': elementName,
      'elementValue': elementValue,
      'elementQuantity': elementQuantity,
      'chosenQuantity': chosenQuantity,
      'elementId': elementId,
    };
  }

}