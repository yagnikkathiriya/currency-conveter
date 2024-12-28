// ignore_for_file: deprecated_member_use, override_on_non_overriding_member

import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/country_picker_dropdown.dart';
import 'package:country_currency_pickers/utils/utils.dart';
import 'package:currency/api_service/apiService.dart';
import 'package:currency/model_api/ModelApi.dart';
import 'package:currency/ui/home_views_list.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  String _selectedCurrency = 'USD';

  Widget _buildDropDownItem(Country country) => Container(
        child: Row(
          children: [
            CountryPickerUtils.getDefaultFlagImage(country),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Text(
                '${country.currencyName}',
                style: const TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    ApiService apiService = ApiService();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const SizedBox(
            height: 6,
          ),
          const Center(
              child: Text(
            "Base Currency",
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
          )),
          const SizedBox(
            height: 6,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            height: 60,
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white),
            child: CountryPickerDropdown(
                initialValue: "bd",
                itemBuilder: _buildDropDownItem,
                onValuePicked: (Country? country) {
                  setState(() {
                    _selectedCurrency = country?.currencyCode ?? "";
                  });
                }),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "All Currency",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
          ),
          const SizedBox(
            height: 20,
          ),
          FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<ModelApi> dataList = snapshot.data ?? [];
                return Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return HomeViewsList(modelApi: dataList[index]);
                    },
                    itemCount: dataList.length,
                  ),
                );
              }
              if (snapshot.hasError) {
                return const Center(child: Text("Error occurd"));
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            future: apiService.getLatest(_selectedCurrency),
          ),
        ],
      ),
    );
  }
}
