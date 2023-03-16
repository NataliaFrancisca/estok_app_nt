import 'package:estok_app_natalia_francisca/colors.dart';
import 'package:estok_app_natalia_francisca/ui/widgets/custom_list_view.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{
  TabController _tabController;

  static const List<Tab> homePageTabs = <Tab>[
    Tab(text: 'Todos'),
    Tab(text: 'Em estoque'),
    Tab(text: 'Em aviso'),
    Tab(text: 'Em falta')
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ESTOK APP",
          style: TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w700,
            fontSize: 15
          ),
        ),

        leading: Icon(
            Icons.menu,
            color: AppColors.primaryColor,
        ),

        centerTitle: true,
        backgroundColor: new Color(0xFFF7F2F8),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(84),

          child: TabBar(
            controller: _tabController,
            labelColor: AppColors.primaryColor,
            labelStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500
            ),
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(width: 6.0, color: AppColors.primaryColor)
            ),
            unselectedLabelStyle: TextStyle(
              color: new Color(0xFF909FAD),
            ),
            tabs: homePageTabs
          ),
        ),
      ),

      body: TabBarView(
        controller: _tabController,
        children: [
          Center(
            child: CustomListView()
          ),

          Center(
              child: CustomListView()
          ),

          Center(
              child: CustomListView()
          ),

          Center(
              child: CustomListView()
          ),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        unselectedLabelStyle: TextStyle(
          color: new Color(0xFF909FAD),
        ),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home'
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.playlist_add),
              label: 'Historico'
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_rounded),
              label: 'Perfil'
          ),
        ]
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => print("AAAA BUTTON"),
        tooltip: 'Increment Counter',
        child: const Icon(Icons.add),
      ),
      
    );
  }
}
