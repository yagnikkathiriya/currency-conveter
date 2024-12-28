import 'package:currency/ui/exchange_page.dart';
import 'package:currency/ui/home_page.dart';
import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int _selectedItemIndex = 0;

  Widget getView(){
    if(_selectedItemIndex==0){
      return const Home();
    }
    return const ExchangeCurrency();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Center(
          child: Text(
            "Currency Conveter",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
      ),
      body: getView(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.currency_exchange,), label: "Exchange")
        ],
        currentIndex: _selectedItemIndex,
        onTap: (index) {
          setState(() {
            _selectedItemIndex = index;
          });
        },
      ),
    );
  }
}
