import 'package:estok_app_natalia_francisca/colors.dart';
import 'package:estok_app_natalia_francisca/ui/pages/new_stock_page.dart';
import 'package:estok_app_natalia_francisca/ui/tabs/home_tab.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{
  TabController _tabController;

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
              fontWeight: FontWeight.w500,
              fontFamily: 'Montserrat',
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
        onPressed: () => {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context){
            return NewStockPage();
          }))
        },
        tooltip: 'Increment Counter',
        child: const Icon(Icons.add),
      ),

      drawer: SafeArea(
        child: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/back_account.png'),
                ),

                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/0/04/Convenience_store_interior.jpg'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(Colors.transparent.withOpacity(0.60), BlendMode.colorBurn)
                  ),
                ),
                
                accountName: Text('Michael Jackson'),
                accountEmail: Text("michaeljackson@mail.com"),
              ),

              SizedBox(height: 14.0),

              ListTile(
                  leading: Icon(Icons.account_circle_rounded),
                  title: Text('Meu Perfil'),
                  trailing: Icon(Icons.arrow_forward_ios, size: 20),
                  onTap: (){
                },
              ),

              ListTile(
                  leading: Icon(Icons.store),
                  title: Text('Estoques'),
                  trailing: Icon(Icons.arrow_forward_ios, size: 20),
                  onTap: (){
                },
              ),

              ListTile(
                  leading: Icon(Icons.playlist_add),
                  title: Text('Histórico'),
                  trailing: Icon(Icons.arrow_forward_ios, size: 20),
                  onTap: (){
                },
              ),

            ],
          )
        ),

      ),
      
    );
  }
}
