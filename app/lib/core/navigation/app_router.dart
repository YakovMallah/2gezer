import 'package:go_router/go_router.dart';
import '../../groups/presentation/group_list_page.dart';
import '../../groups/presentation/group_add_page.dart';
import '../../groups/presentation/group_detail_page.dart';       // ← NEW
import '../../tools/shared_list/presentation/shared_list_list_page.dart';
import '../../tools/shared_list/presentation/shared_list_add_page.dart';
import '../../tools/shared_list/presentation/shared_list_page.dart';
import '../../tools/expenses/presentation/expense_list_page.dart';
import '../../tools/expenses/presentation/expense_add_page.dart';
import '../../tools/expenses/presentation/expense_detail_page.dart';
import '../auth/auth_service.dart';
import '../auth/sign_in_page.dart';
import '../auth/sign_up_page.dart';

class AppRouter {
  static GoRouter create() {
    return GoRouter(
      initialLocation: '/groups',
      refreshListenable: AuthService.instance,
      redirect: (_, state) {
        final loggedIn = AuthService.instance.currentUserId != null;
        final goingAuth = state.uri.toString().startsWith('/sign');
        if (!loggedIn && !goingAuth) return '/sign-in';
        if (loggedIn && goingAuth) return '/groups';
        return null;
      },
      routes: [
        GoRoute(path: '/sign-in', builder: (_, __) => const SignInPage()),
        GoRoute(path: '/sign-up', builder: (_, __) => const SignUpPage()),

        // GROUPS
        GoRoute(path: '/groups',
          builder: (_, __) => const GroupListPage(),
        ),
        GoRoute(path: '/groups/new',
          builder: (_, __) => const GroupAddPage(),
        ),
        GoRoute(path: '/groups/:gid',
          builder: (_, state) => GroupDetailPage(
            groupId: state.pathParameters['gid']!,
          ),
        ),

        // SHARED LISTS TOOL
        GoRoute(path: '/groups/:gid/lists',
          builder: (_, st) => SharedListListPage(
            groupId: st.pathParameters['gid']!,
          ),
        ),
        GoRoute(path: '/groups/:gid/lists/new',
          builder: (_, st) => SharedListAddPage(
            groupId: st.pathParameters['gid']!,
          ),
        ),
        GoRoute(path: '/groups/:gid/lists/:lid',
          builder: (_, st) => SharedListPage(
            groupId: st.pathParameters['gid']!,
            listId: st.pathParameters['lid']!,
          ),
        ),

        // EXPENSES TOOL
        GoRoute(path: '/groups/:gid/expenses',
          builder: (_, st) => ExpenseListPage(
            groupId: st.pathParameters['gid']!,
          ),
        ),
        GoRoute(path: '/groups/:gid/expenses/new',
          builder: (_, st) => ExpenseAddPage(
            groupId: st.pathParameters['gid']!,
          ),
        ),
        GoRoute(path: '/groups/:gid/expenses/:eid',
          builder: (_, st) => ExpenseDetailPage(
            groupId: st.pathParameters['gid']!,
            expenseId: st.pathParameters['eid']!,
          ),
        ),
      ],
    );
  }
}