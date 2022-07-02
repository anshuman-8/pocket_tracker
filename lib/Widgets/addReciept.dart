// import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';

class AddReciept extends StatefulWidget {
  @override
  State<AddReciept> createState() => _AddRecieptState();
}

class _AddRecieptState extends State<AddReciept> {
  // const AddReciept({Key? key}) : super(key: key);
  TextEditingController priceCtrl = new TextEditingController();

  // TextEditingController categoryCtrl = new TextEditingController();
  String _dropDownValue = 'Fuel';

  var _dropItems = ["Grocery", "Medical", "Food", "Fuel", "Others"];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Add Reciept',
            style: TextStyle(fontSize: 20),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              controller: priceCtrl,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: ' Price',
                hintText: 'eg. Munnar',
              ),
            ),
          ),
          Container(
                      width: 180,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: DropdownButton(
                        // Initial Value
                        value: _dropDownValue,
                        underline: Container(
                          height: 2,
                          color: Color.fromRGBO(106, 166, 174, 1),
                        ),
                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down),
                        elevation: 16,
                        // Array list of items
                        items: _dropItems
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            _dropDownValue = newValue!;
                          });
                        },
                      ),
                    ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(9),
                child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.navigate_next_outlined),
                    label: Text("Add")),
              ),
              Padding(
                  padding: EdgeInsets.all(9),
                  child: ElevatedButton.icon(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      label: Text("Cancel")))
            ],
          )
        ],
      ),
    );
  }
}
