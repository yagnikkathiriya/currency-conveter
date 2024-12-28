import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/country_picker_dropdown.dart';
import 'package:country_currency_pickers/utils/utils.dart';
import 'package:currency/api_service/apiService.dart';
import 'package:flutter/material.dart';

class ExchangeCurrency extends StatefulWidget {
  const ExchangeCurrency({super.key});

  @override
  State<ExchangeCurrency> createState() => _ExchangeCurrencyState();
}

class _ExchangeCurrencyState extends State<ExchangeCurrency> {
  final _textController = TextEditingController();
  String _selectedBaseCurrency = 'BDT';
  String _selectedTaregetCurrency = 'USD';
  String _finalOutput = "";

  Widget _buildDropDownItem(Country country) => Container(
        child: Row(
          children: [
            CountryPickerUtils.getDefaultFlagImage(country),
            const SizedBox(
              width: 5,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.68,
                child: Text('${country.currencyName}'))
          ],
        ),
      );
  @override
  Widget build(BuildContext context) {
    ApiService apiService = ApiService();
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(
            height: 6,
          ),
          const Center(
            child: Text(
              "Base Currency",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: Colors.white),
            child: CountryPickerDropdown(
                initialValue: "bd",
                itemBuilder: _buildDropDownItem,
                onValuePicked: (Country? country) {
                  setState(() {
                    _selectedBaseCurrency = country?.currencyCode ?? "";
                  });
                }),
          ),
          const SizedBox(
            height: 6,
          ),
          SizedBox(
            width: 300,
            child: TextField(
              controller: _textController,
              
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintText: "Enter Exchange Amount",
                  hintStyle: TextStyle(fontSize: 20,),
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          const Center(
              child: Text(
            "Target Exchange",
            style: TextStyle(fontSize: 20, color: Colors.white),
          )),
          const SizedBox(
            height: 6,
          ),
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: Colors.white),
            child: CountryPickerDropdown(
                initialValue: "us",
                itemBuilder: _buildDropDownItem,
                onValuePicked: (Country? country) {
                  setState(() {
                    _selectedTaregetCurrency = country?.currencyCode ?? "";
                  });
                }),
          ),
          const SizedBox(
            height: 6,
          ),
          GestureDetector(
            onTap: () async {
              if (_textController.text.isNotEmpty) {
                await apiService
                    .getExchange(
                        _selectedBaseCurrency, _selectedTaregetCurrency)
                    .then((value) {
                  double result = double.parse(_textController.text);
                  double exchangeRate = double.parse(value[0].value.toString());
                  double maxResult = exchangeRate * result;

                  setState(() {
                    _finalOutput = maxResult.toStringAsFixed(2).toString();
                  });
                });
              }
            },
            child: Container(
              alignment: Alignment.center,
              height: 50,
              width: MediaQuery.of(context).size.width * 0.7,
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Colors.amber),
              child: const Text(
                "Exchange Currency",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            _finalOutput,
            style: const TextStyle(
              fontSize: 30,
              color: Colors.white,
            ),
          ),
        ]),
      ),
    );
  }
}
