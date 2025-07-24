import 'package:go_router/go_router.dart';
import 'package:two_gezer/screens/home_page.dart';

class AppRouter {
  static GoRouter create() {
    return GoRouter(
      initialLocation: '/',
      routes: [GoRoute(path: '/', builder: (_, __) => const HomePage())],
    );
  }
}
