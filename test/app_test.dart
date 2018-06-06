import 'package:flutter_test/flutter_test.dart';
import 'package:pindery/pindery.dart';
import 'package:pindery/user.dart';

void main() {
  User user = testUser();
  testWidgets('The app should start', (WidgetTester tester) {
    tester.pumpWidget(new Pindery(user));
  });
}

User testUser() {
  return new User(
      email: 'e@pindery.com',
      name: 'Edoardo',
      uid: 'IhBnM3laffchnwWRu5ZXcSz9xEs1',
      surname: 'Debenedetti',
      profilePictureUrl:
          'https://avatars1.githubusercontent.com/u/4366950?s=460&v=4');
}
