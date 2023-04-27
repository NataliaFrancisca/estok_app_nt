import 'package:estok_app/models/stock_model.dart';
import 'package:estok_app/ui/tabs/em_aviso_tab.dart';
import 'package:estok_app/ui/tabs/em_estoque_tab.dart';
import 'package:estok_app/ui/tabs/em_falta_tab.dart';
import 'package:estok_app/ui/tabs/todos_tab.dart';
import 'package:flutter/material.dart';
import 'package:estok_app/models/historic_model.dart';
import 'package:estok_app/ui/pages/new_stock_page.dart';
import 'package:estok_app/ui/widgets/custom_bottom_nav_bar.dart';
import 'package:estok_app/ui/widgets/custom_navigation_drawer.dart';
import 'package:estok_app/colors.dart';

class HomePage extends StatefulWidget {
  final bool isMenuNavigator;
  HomePage({this.isMenuNavigator = false});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TabController _tabController;

  @override
  void initState(){
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if(widget.isMenuNavigator == false){
        StockModel.of(context).fetch('todos');
      }
      HistoricModel.of(context).checkHistoricLength();
    });

    _tabController = TabController(initialIndex: 0, length: 4, vsync: this);
  }

  _reloadData(){
    StockModel.of(context).fetch('todos');
    _tabController.animateTo(0);
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
          icon: Icon(Icons.menu, color: AppColors.primaryColor),
          onPressed: () {
            _scaffoldKey.currentState.openDrawer();
          },
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        ),
        
        centerTitle: true,
        backgroundColor: AppColors.lightPurpleColor,
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
        physics: NeverScrollableScrollPhysics(),
        controller: _tabController,
          children: [
            TodosTab(),
            EmEstoqueTab(),
            EmAvisoTab(),
            EmFaltaTab()
          ],
      ),

      bottomNavigationBar: CustomBottomNavBar('home_page'),
  
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add New Stock',
        child: const Icon(Icons.add),
        onPressed: () async {
          String refresh = await Navigator.push(context, MaterialPageRoute(builder: (context) => NewStockPage()));
          if(refresh == 'refresh'){
            _reloadData();
          }
        },
      ),

      drawer: CustomNavigationDrawer(_scaffoldKey)
    );
  }
}
