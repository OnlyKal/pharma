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
    debugPrint(widget.dawa.toString());
    super.initState();
  }

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
          child: Column(children: [
            Container(
                color: maincolor,
                height: heigth(context) * .2,
                width: width(context),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'ANTIBIOTIQUES',
                          style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 5, 182, 167)),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          'Paracetamole ',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              color: Colors.white),
                        ),
                         SizedBox(
                          height: 16,
                        ),
                        Text(
                          'CDF 300.0',
                          style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ]),
                )),
            SizedBox(
              height: heigth(context) * 0.03,
            ),
            const Text(
                "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy "),
            SizedBox(
              height: heigth(context) * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                eventBtn(context, _openEdit,'Modifier',Icons.edit),
                
                eventBtn(context, _openDelete,'Supprimer',Icons.delete,),
                
                eventBtn(context, _openDelete,'Infos',Icons.info),
              ],
            )
          ]),
        ),
      ),
    );
  }

  Widget eventBtn(BuildContext context, event,title,icon) {
    return Column(
      children: [
        IconButton(
          onPressed: event,
          icon:  Icon(icon, color: maincolor),
          hoverColor: maincolor,
        ),
         Text(
          title,
          style:const TextStyle(color: Colors.grey),
        )
      ],
    );
  }
}
