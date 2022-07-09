import 'package:flutter/material.dart';
import 'package:pharma/color.dart';
import './export.dart';

class Details extends StatefulWidget {
  final dawa;
  const Details({Key? key, this.dawa}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  void initState() {
    super.initState();
  }
 _return() {
      Navigator.of(context).pushNamed('/home');
    }
  TextEditingController txtCategorie = TextEditingController();
  TextEditingController txtdesignation = TextEditingController();
  TextEditingController txtmontant = TextEditingController();
  TextEditingController txtdescription = TextEditingController();
  final Product _product = const Product();
  var update;
  _openEdit() {
    if (update != '') {
      txtCategorie.text = update['category'].toString();
      txtdesignation.text = update['name'].toString();
      txtmontant.text = update['price'].toString();
      txtdescription.text = update['description'].toString();
    }
   

    
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'MODIFIER MEDICAMENT',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            content: SizedBox(
              height: heigth(context) * 0.24,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    input(txtCategorie, 'Catégorie', TextInputType.text),
                    input(txtdesignation, 'Désignation', TextInputType.text),
                    input(txtmontant, 'Prix unitaire', TextInputType.number),
                    input(txtdescription, 'Description', TextInputType.text),
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
                    'Annuler',
                    style: TextStyle(color: maincolor),
                  )),
              TextButton(
                onPressed: () {
                  Product updateP = Product(
                      id: int.parse(_id),
                      name: txtdesignation.text,
                      category: txtCategorie.text,
                      price: double.parse(txtmontant.text),
                      description: txtdescription.text);
                  updateP.update();
                  Navigator.of(context).pushNamed('/detail');
                },
                child: const Text(
                  'Modifier',
                  style: TextStyle(color: maincolor, fontSize: 17),
                ),
              )
            ],
          );
        });
  }

  var _id = '';

  _openDelete() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'QUESTION',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            content: const Text(
                "Attention , Voulez-vous vraimet supprimer ce produit  ?"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Annuler',
                    style: TextStyle(color: maincolor),
                  )),
              TextButton(
                  onPressed: () {
                    _product.delete(_id);
                    Navigator.of(context).pushNamed('/home');
                  },
                  child: const Text(
                    'Confirmer',
                    style: TextStyle(color: maincolor),
                  ))
            ],
          );

          // TATATATA
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails'),
        backgroundColor: maincolor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pushNamed('/home'),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: FutureBuilder<dynamic>(
              future: widget.dawa == null
                  ? _product.getLimit()
                  : _product.getById(widget.dawa['id']),
              builder: (BuildContext context, AsyncSnapshot<dynamic> dawa) {
                if (dawa.connectionState == ConnectionState.waiting) {
                  return const Text('waiting data ....');
                }
                if (dawa.hasError) {
                  return const Text('Error data ....');
                }
                if (dawa.connectionState == ConnectionState.done) {
                  if (dawa.hasData) {
                    if (dawa.data != null) {
                      _id = dawa.data['message'][0]["id"].toString();
                      update = dawa.data['message'][0];
                      return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              color: maincolor,
                              height: heigth(context) * .2,
                              width: width(context),
                              child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  //00000
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          dawa.data['message'][0]["category"]
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 23,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 5, 182, 167)),
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        Text(
                                          dawa.data['message'][0]["name"]
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.white),
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        Text(
                                          'CDF ${dawa.data['message'][0]["price"].toString()}',
                                          style: const TextStyle(
                                              fontSize: 23,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ])),
                            ),
                            SizedBox(
                              height: heigth(context) * 0.03,
                            ),
                            const Text(
                              'Description',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 149, 149, 149)),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(dawa.data['message'][0]["description"]
                                .toString()),
                            SizedBox(
                              height: heigth(context) * 0.03,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                eventBtn(
                                    context, _openEdit, 'Modifier', Icons.edit),
                                eventBtn(
                                  context,
                                  _openDelete,
                                  'Supprimer',
                                  Icons.delete,
                                ),
                                eventBtn(context, _return, 'Retour',
                                    Icons.keyboard_return_sharp),
                              ],
                            )
                          ]);
                    }
                  }
                }

                return const Text('data ....');
              }),
        ),
      ),
    );
  }

  Widget eventBtn(BuildContext context, event, title, icon) {
    return Column(
      children: [
        IconButton(
          onPressed: event,
          icon: Icon(icon, color: maincolor),
          hoverColor: maincolor,
        ),
        Text(
          title,
          style: const TextStyle(color: Colors.grey),
        )
      ],
    );
  }

  Widget input(controller, hitext, type) {
    return Padding(
        padding: const EdgeInsets.only(left: 0, right: 0),
        child: TextField(
          controller: controller,
          keyboardType: type,
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
}
