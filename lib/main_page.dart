import 'package:account_manager/account_list_page.dart';
import 'package:account_manager/set_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'event_bus_manager.dart';



class MainPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }


}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  List<Widget> _pages;

  _MainPageState(){
    _pages = List();
    _pages.add( AccountListPage());
    _pages.add(SetPage());
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: getScaffold(),
    );
  }

  Widget getScaffold(){
    return Scaffold(
      extendBody: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          EventBusManager.eventBus.fire(ValueChangeEvent(Event.addAccount));
        },
        backgroundColor: Colors.blue[600],

        child: const Icon(Icons.add, color: Colors.white,),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 5,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.account_circle,
                size: 30,
                color: _getIconColor(0),
              ),
              onPressed: () {
                setState(() {
                  _selectedIndex = 0;
                  FocusScope.of(context).requestFocus(FocusNode());
                });
              },
            ),
            SizedBox(width: 30,),
            IconButton(
              icon: Icon(
                Icons.settings,
                size: 30,
                color: _getIconColor(1),
              ),
              onPressed: () {
                setState(() {
                  _selectedIndex = 1;
                  FocusScope.of(context).requestFocus(FocusNode());
                });
              },
            ),
          ],
        ),
      ),

    );
  }
  @override
  void dispose() {
    super.dispose();
  }

  Color _getIconColor(int index){
    if(_selectedIndex == index){
      return Colors.green;
    }
    return Colors.grey;
  }
}

