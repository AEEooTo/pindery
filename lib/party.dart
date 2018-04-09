class Party {
  Party({this.name, this.day, this.imagePath});
  final name;
  final day;
  final imagePath;

  static List<Party> partyGenerator() {
    List<Party> partyList = new List(5);
    partyList[0] = new Party(
      name: 'Cats Party',
      day: 'Every day',
      imagePath: 'assets/img/kittens.jpeg',
    );
    partyList[1] = new Party(
      name: 'Pasta Party',
      day: 'Tomorrow',
      imagePath: 'assets/img/classicalParty.jpeg',
    );
    partyList[2] = new Party(
      name: 'Great Party',
      day: 'Today',
      imagePath: 'assets/img/proseccoParty.jpg',
    );
    partyList[3] = new Party(
      name: 'Pizza Party',
      day: '4/4/2018',
      imagePath: 'assets/img/pasta.jpeg',
    );
    partyList[4] = new Party(
      name: 'Jiaozi Party',
      day: 'Today',
      imagePath: 'assets/img/movingParty.jpeg',
    );
    return partyList;
  }
}
