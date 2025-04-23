import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddGunnyDepositsScreen extends StatefulWidget {
  @override
  _AddGunnyDepositsScreenState createState() => _AddGunnyDepositsScreenState();
}

class _AddGunnyDepositsScreenState extends State<AddGunnyDepositsScreen> {
  // Form fields
  DateTime selectedDate = DateTime.now();
  String selectedPlace = '';
  String selectedKmsYear = '';
  String truckMemoNumber = '';
  String acknowledgmentNumber = '';
  String lorryNumber = '';

  int noOfBundlesOnb = 0;
  int noOfUnitsOnb = 0;
  int noOfBundlesSs = 0;
  int noOfUnitsSs = 0;
  int noOfBundlesSwp = 0;
  int noOfUnitsSwp = 0;
  int noOfBundlesUs = 0;
  int noOfUnitsUs = 0;

  List<String> places = [];
  List<String> kmsYears = [];

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    fetchDropdownData();
  }

  // Fetch dropdown data from Firestore
  Future<void> fetchDropdownData() async {
    try {
      final placesSnapshot = await FirebaseFirestore.instance.collection('places').get();
      final kmsYearsSnapshot = await FirebaseFirestore.instance.collection('kms_years').get();

      setState(() {
        places = placesSnapshot.docs.map((doc) => doc['value'] as String).toList();
        kmsYears = kmsYearsSnapshot.docs.map((doc) => doc['value'] as String).toList();
      });
    } catch (e) {
      print("Error fetching dropdown data: $e");
    }
  }

  // Save form data to Firestore
  Future<void> saveGunnyDepositsData() async {
    try {
      await FirebaseFirestore.instance.collection('gunny_deposits').add({
        'date': selectedDate.toIso8601String(),
        'place': selectedPlace,
        'kms_year': selectedKmsYear,
        'truck_memo_number': truckMemoNumber,
        'acknowledgment_number': acknowledgmentNumber,
        'lorry_number': lorryNumber,
        'no_of_bundles_onb': noOfBundlesOnb,
        'no_of_units_onb': noOfUnitsOnb,
        'no_of_bundles_ss': noOfBundlesSs,
        'no_of_units_ss': noOfUnitsSs,
        'no_of_bundles_swp': noOfBundlesSwp,
        'no_of_units_swp': noOfUnitsSwp,
        'no_of_bundles_us': noOfBundlesUs,
        'no_of_units_us': noOfUnitsUs,
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Data saved successfully!'),
      ));
      Navigator.pop(context); // Navigate back after saving
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to save data: $e'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Gunny Deposits'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Date Picker
              Text("Date", style: TextStyle(fontSize: 16)),
              TextButton(
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      selectedDate = pickedDate;
                    });
                  }
                },
                child: Text(
                  "${selectedDate.toLocal()}".split(' ')[0],
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 16),

              // Truck Memo Number
              buildTextField("Truck Memo Number", (value) {
                truckMemoNumber = value;
              }),

              // Acknowledgment Number
              buildTextField("Acknowledgment Number", (value) {
                acknowledgmentNumber = value;
              }),

              // Lorry Number
              buildTextField("Lorry Number", (value) {
                lorryNumber = value;
              }),

              // Place Dropdown
              buildPlaceDropdown(),

              SizedBox(height: 16),

              // KMS Year Dropdown
              buildKmsYearDropdown(),

              SizedBox(height: 16),

              // Number of Bundles and Units (ONB, SS, SWP, US)
              buildNumericField("No. of Bundles (ONB)", (value) {
                noOfBundlesOnb = int.tryParse(value) ?? 0;
              }),
              buildNumericField("No. of Units (ONB)", (value) {
                noOfUnitsOnb = int.tryParse(value) ?? 0;
              }),
              buildNumericField("No. of Bundles (SS)", (value) {
                noOfBundlesSs = int.tryParse(value) ?? 0;
              }),
              buildNumericField("No. of Units (SS)", (value) {
                noOfUnitsSs = int.tryParse(value) ?? 0;
              }),
              buildNumericField("No. of Bundles (SWP)", (value) {
                noOfBundlesSwp = int.tryParse(value) ?? 0;
              }),
              buildNumericField("No. of Units (SWP)", (value) {
                noOfUnitsSwp = int.tryParse(value) ?? 0;
              }),
              buildNumericField("No. of Bundles (US)", (value) {
                noOfBundlesUs = int.tryParse(value) ?? 0;
              }),
              buildNumericField("No. of Units (US)", (value) {
                noOfUnitsUs = int.tryParse(value) ?? 0;
              }),

              // Save Button
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    saveGunnyDepositsData();
                  }
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPlaceDropdown() {
    return Row(
      children: [
        Expanded(
          child: DropdownButton<String>(
            value: selectedPlace.isNotEmpty ? selectedPlace : null,
            hint: Text("Select Place"),
            isExpanded: true,
            items: places.map((place) {
              return DropdownMenuItem<String>(
                value: place,
                child: Text(place),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                selectedPlace = newValue!;
              });
            },
          ),
        ),
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ManageItemsScreen(
                  title: "Manage Places",
                  collectionName: "places",
                ),
              ),
            ).then((_) => fetchDropdownData());
          },
        ),
      ],
    );
  }

  Widget buildKmsYearDropdown() {
    return Row(
      children: [
        Expanded(
          child: DropdownButton<String>(
            value: selectedKmsYear.isNotEmpty ? selectedKmsYear : null,
            hint: Text("Select KMS Year"),
            isExpanded: true,
            items: kmsYears.map((year) {
              return DropdownMenuItem<String>(
                value: year,
                child: Text(year),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                selectedKmsYear = newValue!;
              });
            },
          ),
        ),
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ManageItemsScreen(
                  title: "Manage KMS Years",
                  collectionName: "kms_years",
                ),
              ),
            ).then((_) => fetchDropdownData());
          },
        ),
      ],
    );
  }

  Widget buildNumericField(String label, Function(String) onSaved) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      keyboardType: TextInputType.number,
      validator: (value) => value == null || value.isEmpty ? "Enter $label" : null,
      onSaved: (value) => onSaved(value!),
    );
  }

  Widget buildTextField(String label, Function(String) onSaved) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      validator: (value) => value == null || value.isEmpty ? "Enter $label" : null,
      onSaved: (value) => onSaved(value!),
    );
  }
}

// Manage Items Screen for Dropdown Management
class ManageItemsScreen extends StatelessWidget {
  final String title;
  final String collectionName;

  ManageItemsScreen({required this.title, required this.collectionName});

  final TextEditingController _controller = TextEditingController();

  Future<void> addItem(BuildContext context) async {
    try {
      await FirebaseFirestore.instance.collection(collectionName).add({
        'value': _controller.text,
      });
      Navigator.pop(context);
    } catch (e) {
      print("Error adding item: $e");
    }
  }

  Future<void> deleteItem(String docId) async {
    try {
      await FirebaseFirestore.instance.collection(collectionName).doc(docId).delete();
    } catch (e) {
      print("Error deleting item: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection(collectionName).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

          final docs = (snapshot.data as QuerySnapshot).docs;

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final doc = docs[index];
              return ListTile(
                title: Text(doc['value']),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => deleteItem(doc.id),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Add ${title}"),
                content: TextField(
                  controller: _controller,
                  decoration: InputDecoration(hintText: "Enter new value"),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      addItem(context);
                    },
                    child: Text("Add"),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}