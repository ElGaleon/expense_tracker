import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/pages/add_edit_expense_page.dart';
import 'package:expense_tracker/pages/home_page.dart';
import 'package:expense_tracker/pages/stats_page.dart';
import 'package:expense_tracker/ui/components/bottom_bar_navigation.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/new',
      builder: (context, state) => const AddEditExpensePage(),
    ),
    GoRoute(
      path: '/edit',
      builder: (context, state) {
        final Map<String, Expense> extra = state.extra as Map<String, Expense>;
        final Expense expense = extra['expense']!;
        return AddEditExpensePage(expense: expense);
      },
    ),
    StatefulShellRoute.indexedStack(
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/stats',
              builder: (context, state) => const StatsPage(),
            ),
          ],
        ),
      ],
      builder: (context, state, child) {
        return BottomBarNavigation(
          child: child,
        );
      },
    ),
    /*
    GoRoute(
      path: '/new',
      pageBuilder: (context, state) => MaterialPage(child: ExpensesScreen()),
    ),

    GoRoute(
      path: '/tags',
      pageBuilder: (context, state) => MaterialPage(child: TagsScreen()),
    ),

     */
  ],
);
