class Party {
  Party({this.name, this.day, this.imagePath,this.organiser, this.place, this.rating,
  this.ratingNumber,this.privacy, this.pinderPoints, this.description});
  final String name;
  final String day;
  final String imagePath;
  final String organiser;
  final String place;
  final num rating;
  final int ratingNumber;
  final String privacy;
  final int pinderPoints;
  final String description;


  static List<Party> partyGenerator() {
    List<Party> partyList = new List(5);
    partyList[0] = new Party(
      name: 'Cats Party',
      day: 'Every day',
      imagePath: 'assets/img/kittens.jpeg',
      organiser: 'Mario Rossi',
      place: 'Corso Cosenza 32, Torino',
      rating: 4,
      ratingNumber: 23,
      privacy: 'Public',
      pinderPoints: 5,
      description: 'Sounds like a nice party!'
    );
    partyList[1] = new Party(
      name: 'Pasta Party',
      day: 'Tomorrow',
      imagePath: 'assets/img/classicalParty.jpeg',
        organiser: 'Anna Tranquillini',
        place: 'Corso Cosenza 32, Torino',
        rating: 4,
        ratingNumber: 24,
        privacy: 'Public',
        pinderPoints: 7,
        description: 'Sounds like a nice party!\n\n\n\n\n\n\ngatto'
    );
    partyList[2] = new Party(
      name: 'Great Party',
      day: 'Today',
      imagePath: 'assets/img/proseccoParty.jpg',
        organiser: 'Ginuo',
        place: 'Corso Cosenza 32, Torino',
        rating: 4,
        ratingNumber: 23,
        privacy: 'Public',
        pinderPoints: 5,
        description: 'Sounds like a nice party!'
    );
    partyList[3] = new Party(
      name: 'Pizza Party',
      day: '4/4/2018',
      imagePath: 'assets/img/pasta.jpeg',
        organiser: 'Deb',
        place: 'Via sesto in Sylvis 73/4',
        rating: 5,
        ratingNumber: 27,
        privacy: 'Public',
        pinderPoints: 5,
        description: 'Sounds like a nice party!'
    );
    partyList[4] = new Party(
      name: 'Jiaozi Party',
      day: 'Today',
      imagePath: 'assets/img/movingParty.jpeg',
        organiser: 'Mario Rossi',
        place: 'Corso Cosenza 32, Torino',
        rating: 4,
        ratingNumber: 23,
        privacy: 'Public',
        pinderPoints: 5,
        description: 'Sounds like a nice party!'
    );
    return partyList;
  }
}
