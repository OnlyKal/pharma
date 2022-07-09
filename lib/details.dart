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

  final Product _product = const Product();

  _openEdit() {
    debugPrint('EDITER');
  }

  _openDelete() {
    debugPrint('Supressions');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        backgroundColor: maincolor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          //ooooo
          child: FutureBuilder<dynamic>(
              future: widget.dawa==null? _product.getLimit(): _product.getById(widget.dawa['id']) ,
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
                                eventBtn(
                                    context, _openDelete, 'Infos', Icons.info),
                              ],
                            )
                          ]);
                    }
                  }
                }

                return const Text('data ....');
              }),
          //000
          //0000
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
}
