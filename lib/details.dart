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
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Home()),
    );
  }

  TextEditingController seachProduct = TextEditingController();
  TextEditingController txtdesignation = TextEditingController();
  TextEditingController txtpachat = TextEditingController();
  TextEditingController txtpvente = TextEditingController();
  TextEditingController txtdescription = TextEditingController();

  final Product _product = const Product();
  var update;
  String? _devise;

  _openEdit() {
    if (update != '') {
      txtdesignation.text = update['name'].toString();
      txtpachat.text = update['pachat'].toString();
      txtpvente.text = update['pvente'].toString();
      txtdescription.text = update['description'].toString();
      _devise = update['devise'].toString();
    }

    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: const Text(
                'Modification du produit',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              content: SizedBox(
                height: heigth(context) * 0.3,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          RadioListTile(
                            title: const Text('FC'),
                            // leading: Radio(
                            value: 'FC',
                            groupValue: _devise,
                            onChanged: (value) {
                              setState(() {
                                _devise = value.toString();
                              });
                            },
                          ),
                          // ),
                          RadioListTile(
                            title: const Text('USD'),
                            // leading: Radio(
                            value: 'USD',
                            groupValue: _devise,
                            onChanged: (value) {
                              setState(() {
                                _devise = value.toString();
                              });
                            },
                          ),
                          // ),
                        ],
                      ),
                      input(txtdesignation, 'Désignation', TextInputType.text),
                      input(txtpachat, "Prix d'achat", TextInputType.number),
                      input(txtpvente, 'Prix de vente', TextInputType.number),
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
                      'ANNULER',
                      style: TextStyle(color: maincolor, fontSize: 17),
                    )),
                TextButton(
                  onPressed: () {
                    modifier();
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'MODIFIER',
                    style: TextStyle(color: maincolor, fontSize: 17),
                  ),
                )
              ],
            );
          });
        });
  }

  void modifier() => setState(() {
        Product updateP = Product(
            id: int.parse(_id),
            name: txtdesignation.text,
            pachat: double.parse(txtpachat.text),
            pvente: double.parse(txtpvente.text),
            description: txtdescription.text,
            devise: _devise);
        updateP.update();
      });

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
        title: const Text('Détails du produit'),
        backgroundColor: maincolor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Home()),
          ),
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
                              decoration: BoxDecoration(
                                  color: maincolor,
                                  borderRadius: BorderRadius.circular(10)),
                              width: width(context),
                              child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          dawa.data['message'][0]["name"]
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 23,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 7, 220, 202)),
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        // Text(
                                        //   dawa.data['message'][0]["name"]
                                        //       .toString(),
                                        //   style: const TextStyle(
                                        //       fontSize: 14,
                                        //       fontWeight: FontWeight.w300,
                                        //       color: Colors.white),
                                        // ),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "Prix achat (PA)",
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 7, 220, 202)),
                                                ),
                                                Text(
                                                  '${dawa.data['message'][0]["pachat"].toString()} ${dawa.data['message'][0]["devise"].toString()} ',
                                                  style: const TextStyle(
                                                      fontSize: 23,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              width: width(context) * 0.1,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "Prix vente (PV)",
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 7, 220, 202)),
                                                ),
                                                Text(
                                                  ' ${dawa.data['message'][0]["pvente"].toString()} ${dawa.data['message'][0]["devise"].toString()}',
                                                  style: const TextStyle(
                                                      fontSize: 23,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          ],
                                        )
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
}
