/// The class that defines an element in the party catalogue.
class CatalogueElement {
  CatalogueElement({this.elementName, this.elementQuantity, this.chosenQuantity, this.elementValue});

  /// The name of the element.
  String elementName;

  /// The quantity of the element, chosen by the party organiser.
  int elementQuantity;

  /// The value of the element.
  int elementValue;

  /// The quantity of the element that was altready chosen.
  int chosenQuantity = 0;

  /// The quantity chosen locally by the user that is taking part to the party.
  int locallyChosenQuantity = 0;

  /// The ID of the element on the DB.
  String elementId;

  /// The remaining quantity of elements.
  int get remainingQuantity => elementQuantity - chosenQuantity;

  /// Constructor used when the catalogue is downloaded from Firestore.
  /// It is used in the [CategoryTilesList] class, when the Party Master creates a new catalogue.
  CatalogueElement.fromFirestore(Map snapshot, String id) {
    elementId = id;
    elementName = snapshot['name'];
    elementValue = snapshot['value'];
    elementQuantity = 1; // The quantity is 1 as default, but will be modified by the user later.
  }

  /// Constructor used to create the element from a [Map].
  /// It is used in the [Catalogue] class to transform the Catalogue in the DB in a matrix.
  CatalogueElement.fromMap(Map map) {
    elementName = map['elementName'];
    elementValue = map['elementValue'];
    elementQuantity = map['elementQuantity'];
    elementId = map['elementId'];
    chosenQuantity = map['chosenQuantity'];
  }

  /// Creates a [Map] from a [CatalogueElement] instance.
  /// It's used in the [Catalogue] class, to create a [Map] from the catalogue.
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