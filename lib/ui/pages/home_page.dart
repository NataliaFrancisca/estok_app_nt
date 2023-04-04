import 'package:estok_app_natalia_francisca/colors.dart';
import 'package:estok_app_natalia_francisca/models/stock_model.dart';
import 'package:estok_app_natalia_francisca/ui/pages/historic_page.dart';
import 'package:estok_app_natalia_francisca/ui/pages/new_stock_page.dart';
import 'package:estok_app_natalia_francisca/ui/pages/perfil_page.dart';
import 'package:estok_app_natalia_francisca/ui/tabs/home_tab.dart';
import 'package:estok_app_natalia_francisca/ui/widgets/custom_bottom_nav_bar.dart';
import 'package:estok_app_natalia_francisca/ui/widgets/custom_navigation_drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    StockModel.of(context).fetch();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          "ESTOK APP",
          style: TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w700,
            fontSize: 15
          ),
        ),

        leading: IconButton(
            icon: Icon(
              Icons.menu, 
              color: AppColors.primaryColor
            ),
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
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
              fontWeight: FontWeight.w500,
            ),
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(width: 6.0, color: AppColors.primaryColor)
            ),
            unselectedLabelColor: new Color(0xFF909FAD),
            tabs: [
              Tab(text: 'TODOS'),
              Tab(text: 'Em estoque'),
              Tab(text: 'Em aviso'),
              Tab(text: 'Em falta')
            ]
          ),
        ),
      ),

      body: TabBarView(
        controller: _tabController,
          children: [
            HomeTab('todos'),
            HomeTab('Em estoque'),
            HomeTab('Em aviso'),
            HomeTab('Em falta'),
          ],
      ),

      bottomNavigationBar: CustomBottomNavBar('home_page'),
  
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment Counter',
        child: const Icon(Icons.add),
        onPressed: () => {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context){
            return NewStockPage();
          }))
        },
      ),

      drawer: CustomNavigationDrawer(_scaffoldKey)
      
    );
  }
}
