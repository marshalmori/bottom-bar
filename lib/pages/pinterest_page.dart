import 'package:bottom_bar/widgets/pinterest_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class PinterestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _MenuModel(),
      child: Scaffold(
        //body: PinterestGrid(),
        //body: PinterestMenu(),
        body: Stack(
          children: [
            PinterestGrid(),
            _PinterestLocationMenu(),
          ],
        ),
      ),
    );
  }
}

class _PinterestLocationMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pageWidth = MediaQuery.of(context).size.width;

    final showMenu = Provider.of<_MenuModel>(context).showMenu;

    return Positioned(
      bottom: 30,
      child: Container(
        width: pageWidth,
        child: Align(
          child: PinterestMenu(
            showMenu: showMenu,
            //backgroundColorMenu: Colors.green,
            //activeIconBackgroundColor: Colors.red,
            //inactiveIconBackgroundColor: Colors.purple,
            items: [
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
            ],
          ),
        ),
      ),
    );
  }
}

class PinterestGrid extends StatefulWidget {
  @override
  _PinterestGridState createState() => _PinterestGridState();
}

class _PinterestGridState extends State<PinterestGrid> {
  final List<int> items = List.generate(200, (i) => i);

  ScrollController controller = ScrollController();
  final double beforeScrool = 0;

  @override
  void initState() {
    controller.addListener(() {
      if (controller.offset > beforeScrool && controller.offset > 150) {
        Provider.of<_MenuModel>(context, listen: false).showMenu = false;
      } else {
        Provider.of<_MenuModel>(context, listen: false).showMenu = true;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      controller: controller,
      crossAxisCount: 4,
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) => _PinterestItem(index),
      staggeredTileBuilder: (int index) =>
          new StaggeredTile.count(2, index.isEven ? 2 : 3),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }
}

class _PinterestItem extends StatelessWidget {
  final int index;
  const _PinterestItem(this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Center(
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: Text('$index'),
          ),
        ));
  }
}

class _MenuModel with ChangeNotifier {
  bool _showMenu = true;

  bool get showMenu => this._showMenu;

  set showMenu(bool value) {
    this._showMenu = value;
    notifyListeners();
  }
}
