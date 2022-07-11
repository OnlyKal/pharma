import 'package:flutter/material.dart';
import 'package:pharma/color.dart';
import './export.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController seachProduct = TextEditingController();
  TextEditingController txtCategorie = TextEditingController();
  TextEditingController txtdesignation = TextEditingController();
  TextEditingController txtmontant = TextEditingController();
  TextEditingController txtdescription = TextEditingController();
  final Product _product = const Product();

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
            Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 5, bottom: 5),
                child: Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                'assets/images.png',
                              ),
                              fit: BoxFit.cover)),
                    ),
                    const Text(
                      'Pharma',
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 22),
                    ),
                    const Text(
                      'Lab',
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 22),
                    ),
                  ],
                )),
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
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 190, 190, 190)),
                                onChanged: (value) {
                                  setState(() {});
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
                      ]),
                )),
            Expanded(
                child: FutureBuilder<dynamic>(
                    future: seachProduct.text == ''
                        ? _product.get()
                        : _product.getLike(seachProduct.text),
                    builder:
                        (BuildContext context, AsyncSnapshot<dynamic> dawa) {
                      if (dawa.connectionState == ConnectionState.waiting) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              SizedBox(
                                height: 12,
                                width: 12,
                                child: CircularProgressIndicator(
                                  strokeWidth: 1,
                                  backgroundColor: maincolor,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Text('Attente ...')
                            ],
                          ),
                        );
                      }
                      if (dawa.hasError) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.error,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text('Il ya une erreur ...')
                            ],
                          ),
                        );
                      }
                      if (dawa.connectionState == ConnectionState.done) {
                        if (dawa.hasData) {
                          if (dawa.data != null) {
                            if (dawa.data['type'] == 'success') {
                              return ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: dawa.data['message'].length,
                                  itemBuilder: (context, index) {
                                    List data = dawa.data['message'].toList();
                                    data.sort((a, b) {
                                      return a['name']
                                          .toLowerCase()
                                          .compareTo(b['name'].toLowerCase());
                                    });
                                    return products(data[index]);
                                  });
                            } else {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.error,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text('Aucun résultat trouvé ...')
                                  ],
                                ),
                              );
                            }
                          }
                        }
                      }
                      return Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.error,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text('Aucun résultat trouvé ...')
                          ],
                        ),
                      );
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
                    'Ajouter nouveau produit',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  content: SizedBox(
                    height: heigth(context) * 0.24,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          input(txtCategorie, 'Catégorie', TextInputType.text),
                          input(txtdesignation, 'Désignation',
                              TextInputType.text),
                          input(txtmontant, 'Prix unitaire',
                              TextInputType.number),
                          input(txtdescription, 'Description',
                              TextInputType.text),
                        ],
                      ),
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'ANNULER',
                        style: TextStyle(
                            color: maincolor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        _addMedicament();

                        txtCategorie.text = txtdescription.text =
                            txtmontant.text = txtdesignation.text = '';
                      },
                      child: const Text(
                        'AJOUTER',
                        style: TextStyle(
                            color: maincolor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
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
    return data == null
        ? const Text('')
        : GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Details(
                      dawa: data,
                    ))),
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
                                  child: Center(
                                      child: Text(
                                    data['name'][0].toUpperCase(),
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 230, 233, 233),
                                        fontWeight: FontWeight.bold),
                                  ))),
                              const SizedBox(
                                width: 8,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data['name'].toString(),
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    data['category'].toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color:
                                            Color.fromARGB(255, 111, 156, 164)),
                                  )
                                ],
                              )
                            ],
                          ),
                          Text(
                            ' ${data['price'].toString()} FC',
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

  Widget input(controller, hitext, type) {
    return Padding(
        padding: const EdgeInsets.only(left: 0, right: 0),
        child: TextField(
          controller: controller,
          keyboardType: type,
          decoration: InputDecoration(
              label: Text(hitext),
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
    if (txtCategorie.text != '') {
      if (txtdesignation.text != '') {
        if (txtmontant.text != '') {
          if (txtdescription.text != '') {
            Product _product = Product(
                name: txtdesignation.text,
                price: double.parse(txtmontant.text),
                description: txtdescription.text,
                category: txtCategorie.text);
            _product.addProduit().then((value) {});
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Details()),
            );
          }
        }
      }
    }
  }
}
