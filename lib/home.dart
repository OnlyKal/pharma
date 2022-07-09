import 'package:flutter/material.dart';
import 'package:pharma/color.dart';
import './export.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final myProducts = List<String>.generate(1000, (i) => 'Product $i');
  TextEditingController seachProduct = TextEditingController();
  TextEditingController txtCategorie = TextEditingController();
  TextEditingController txtdesignation = TextEditingController();
  TextEditingController txtmontant = TextEditingController();
  TextEditingController txtdescription = TextEditingController();
  final Product _product = const Product();
  var _search = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: SizedBox(
        height: heigth(context),
        width: width(context),
        child: Column(
          children: [
            SizedBox(
              height: paddingTop(context),
            ),
            Container(
                height: heigth(context) * 0.07,
                width: width(context),
                color: maincolor,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // const Icon(Icons.ice_skating),
                        SizedBox(
                            width: width(context) * 0.8,
                            height: heigth(context) * 0.05,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: TextField(
                                onChanged: (value) {
                                  setState(() {
                                    _search = value;
                                  });
                                },
                                controller: seachProduct,
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: Color.fromARGB(213, 189, 182, 182),
                                    ),
                                    hintText: "Recherche medicament",
                                    hintStyle: TextStyle(
                                        color:
                                            Color.fromARGB(255, 203, 202, 202)),
                                    // labelText: "Recherche",
                                    labelStyle: TextStyle(
                                        color:
                                            Color.fromARGB(255, 171, 167, 167)),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: maincolor)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: maincolor)),
                                    border: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: maincolor))),
                              ),
                            )),
                        const IconButton(
                            onPressed: null,
                            icon: Icon(
                              Icons.more_vert_sharp,
                              color: Colors.white,
                            ))
                      ]),
                )),
            Expanded(
                child: FutureBuilder<dynamic>(
                    future: _product.get(),
                    builder:
                        (BuildContext context, AsyncSnapshot<dynamic> dawa) {
                      if (dawa.connectionState == ConnectionState.waiting) {
                        return const Text('waiting data ....');
                      }
                      if (dawa.hasError) {
                        return const Text('Error data ....');
                      }
                      if (dawa.connectionState == ConnectionState.done) {
                        if (dawa.hasData) {
                          if (dawa.data != null) {
                            return ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: dawa.data['message'].length,
                                itemBuilder: (context, index) {
                                  debugPrint(
                                      dawa.data['message'][index].toString());
                                  return products(dawa.data['message'][index]);
                                });
                          }
                        }
                      }

                      return const Text('data ....');
                    }))
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text(
                    'NOUVEAU MEDICAMENT',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  content: SizedBox(
                    height: heigth(context) * 0.24,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          input(txtCategorie, 'Catégorie'),
                          input(txtdesignation, 'Désignation'),
                          input(txtmontant, 'Prix unitaire'),
                          input(txtdescription, 'Description'),
                        ],
                      ),
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        _addMedicament();

                        txtCategorie.text = txtdescription.text =
                            txtmontant.text = txtdesignation.text = '';
                        Navigator.pop(context);
                        Navigator.of(context).pushNamed('/detail');
                      },
                      child: const Text(
                        'Ajouter',
                        style: TextStyle(color: maincolor, fontSize: 17),
                      ),
                    )
                  ],
                );
              });
        },
        backgroundColor: maincolor,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget products(data) {
    return GestureDetector(
      onTap:()=> Navigator.of(context).push(MaterialPageRoute(builder: (context) => Details(dawa: data,))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: width(context),
            height: 66,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: maincolor),
                          child: const Icon(
                            Icons.abc_rounded,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data['category'].toString(),
                              style: const TextStyle(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              data['name'].toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromARGB(255, 111, 156, 164)),
                            )
                          ],
                        )
                      ],
                    ),
                    Text(
                      ' CDF ${data['price'].toString()}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    )
                  ]),
            ),
          ),
          Container(
            height: 0.6,
            color: maincolor,
          )
        ],
      ),
    );
  }

  Widget input(controller, hitext) {
    return Padding(
        padding: const EdgeInsets.only(left: 0, right: 0),
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              hintText: hitext,
              hintStyle: const TextStyle(color: maincolor),
              // labelText: "Recherche",
              labelStyle:
                  const TextStyle(color: Color.fromARGB(255, 171, 167, 167)),
              enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: maincolor)),
              focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: maincolor)),
              border: const UnderlineInputBorder(
                  borderSide: BorderSide(color: maincolor))),
        ));
  }

  void _addMedicament() async {
    Product _product = Product(
        name: txtdesignation.text,
        price: double.parse(txtmontant.text),
        description: txtdescription.text,
        category: txtCategorie.text);
    _product.addProduit().then((value) {
      debugPrint(value.toString());
    });
  }
}
