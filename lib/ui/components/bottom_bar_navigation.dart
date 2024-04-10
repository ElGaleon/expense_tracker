import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomBarNavigation extends StatelessWidget {
  final Widget child;
  const BottomBarNavigation({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/new'),
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                tooltip: 'Home',
                icon: Icon(Icons.home,
                    color: GoRouter.of(context).routeInformationProvider.value.uri.path == '/'
                        ? Colors.deepOrange
                        : Colors.black38),
                onPressed: () => context.go('/'),
              ),
              IconButton(
                tooltip: 'Statistics',
                icon: Icon(Icons.auto_graph,
                    color: GoRouter.of(context).routeInformationProvider.value.uri.path == '/stats'
                        ? Colors.deepOrange
                        : Colors.black38),
                onPressed: () => context.go('/stats'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
