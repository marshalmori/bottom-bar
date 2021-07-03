import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PinterestButton {
  final Function onPressed;
  final IconData icon;

  PinterestButton({
    @required this.onPressed,
    @required this.icon,
  });
}

class PinterestMenu extends StatelessWidget {
  final bool showMenu;
  final Color backgroundColorMenu;
  final Color activeIconBackgroundColor;
  final Color inactiveIconBackgroundColor;

  PinterestMenu(
      {this.showMenu = true,
      this.backgroundColorMenu = Colors.white,
      this.activeIconBackgroundColor = Colors.black,
      this.inactiveIconBackgroundColor = Colors.blueGrey});

  final List<PinterestButton> items = [
    PinterestButton(
        icon: Icons.pie_chart,
        onPressed: () {
          print('Icon pie_chart');
        }),
    PinterestButton(
        icon: Icons.search,
        onPressed: () {
          print('Icon search');
        }),
    PinterestButton(
        icon: Icons.notifications,
        onPressed: () {
          print('Icon notifications');
        }),
    PinterestButton(
        icon: Icons.supervised_user_circle,
        onPressed: () {
          print('Icon supervised_user_circle');
        }),
  ];
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _MenuModel(),
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 250),
        opacity: (showMenu) ? 1 : 0,
        child: Builder(
          builder: (BuildContext context) {
            Provider.of<_MenuModel>(context).backgroundColorMenu =
                this.backgroundColorMenu;
            Provider.of<_MenuModel>(context).activeIconBackgroundColor =
                this.activeIconBackgroundColor;
            Provider.of<_MenuModel>(context).inactiveIconBackgroundColor =
                this.inactiveIconBackgroundColor;
            return _PinterestMenuBackground(
              child: _MenuItems(items),
            );
          },
        ),
      ),
    );
  }
}

class _PinterestMenuBackground extends StatelessWidget {
  final Widget child;

  _PinterestMenuBackground({@required this.child});

  @override
  Widget build(BuildContext context) {
    Color backgroundColorMenu =
        Provider.of<_MenuModel>(context).backgroundColorMenu;

    return Container(
      child: child,
      width: 250,
      height: 60,
      decoration: BoxDecoration(
          color: backgroundColorMenu,
          borderRadius: BorderRadius.all(Radius.circular(100)),
          boxShadow: <BoxShadow>[
            BoxShadow(color: Colors.black38, blurRadius: 10, spreadRadius: -5),
          ]),
    );
  }
}

class _MenuItems extends StatelessWidget {
  final List<PinterestButton> menuItems;

  _MenuItems(this.menuItems);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
          menuItems.length, (i) => _PinterestMenuButton(i, menuItems[i])),
    );
  }
}

class _PinterestMenuButton extends StatelessWidget {
  final int index;
  final PinterestButton item;

  _PinterestMenuButton(this.index, this.item);

  @override
  Widget build(BuildContext context) {
    final selectedItem = Provider.of<_MenuModel>(context).selectedItem;

    final activeIconBackgroundMenu =
        Provider.of<_MenuModel>(context).activeIconBackgroundColor;

    final inactiveIconBackgroundMenu =
        Provider.of<_MenuModel>(context).inactiveIconBackgroundColor;

    return GestureDetector(
      onTap: () {
        Provider.of<_MenuModel>(context, listen: false).selectedItem = index;
        item.onPressed();
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        child: Icon(
          item.icon,
          size: (selectedItem == index) ? 35 : 25,
          color: (selectedItem == index)
              ? activeIconBackgroundMenu
              : inactiveIconBackgroundMenu,
        ),
      ),
    );
  }
}

class _MenuModel with ChangeNotifier {
  int _selectedItem = 0;
  Color _backgroundColorMenu = Colors.white;
  Color _activeIconBackgroundColor = Colors.black;
  Color _inactiveIconBackgroundColor = Colors.blueGrey;

  int get selectedItem => this._selectedItem;

  set selectedItem(int index) {
    this._selectedItem = index;
    notifyListeners();
  }

  Color get backgroundColorMenu => this._backgroundColorMenu;

  set backgroundColorMenu(Color color) {
    this._backgroundColorMenu = color;
  }

  Color get activeIconBackgroundColor => this._activeIconBackgroundColor;

  set activeIconBackgroundColor(Color color) {
    this._activeIconBackgroundColor = color;
  }

  Color get inactiveIconBackgroundColor => this._inactiveIconBackgroundColor;

  set inactiveIconBackgroundColor(Color color) {
    this._inactiveIconBackgroundColor = color;
  }
}
