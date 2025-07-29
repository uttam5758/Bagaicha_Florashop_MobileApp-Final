import 'package:flutter/material.dart';

class ShippngScreen extends StatelessWidget {
  const ShippngScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var address = TextEditingController();
    var phone = TextEditingController();
    var country=TextEditingController();
    var state=TextEditingController();
    var zipcode=TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shipping Details'),
        elevation: 4.0,
        centerTitle: true,
        // backgroundColor: const Color.fromARGB(255, 14, 234, 117),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: address,
                  decoration: InputDecoration(
                    labelText: 'Street Address',
                    // hintText: '1234 Main St',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    ),
                  ),
      
                const SizedBox(height: 20),
                TextFormField(
                  controller: phone,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    // hintText: '555-555-5555',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: country,
                  decoration: InputDecoration(
                    labelText: 'Country',
                    // hintText: 'Nepal',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    ),
                  ),
                const SizedBox(height: 20),
                TextFormField(
                      controller: state,
                  decoration: InputDecoration(
                
                    labelText: 'State',
                    // hintText: 'Bagmati',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    ),
                  ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: zipcode,
                  decoration: InputDecoration(
                    labelText: 'Zip Code',
                    // hintText: '90210',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    ),
                  ),
                const SizedBox(height: 20),
                
               
                
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/confirm_order',arguments: {
                      'address': address.text,
                      'phone': phone.text,
                      'country': country.text,
                      'state': state.text,
                      'zip': zipcode.text,
                    });
                  
                  },
                  style: ElevatedButton.styleFrom(
                    // backgroundColor: const Color.fromARGB(255, 14, 234, 117),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 60.0, vertical: 13.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  child: const Text(
                    "Confirm Order",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
      
              ],
            ),
          ),
        ),
      ),
    );
  }
}
