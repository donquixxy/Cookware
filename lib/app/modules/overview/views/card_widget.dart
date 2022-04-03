import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/data/models/recipe_models.dart';

class CardWidget extends StatelessWidget {
  CardWidget({required this.resep, required this.docId});

  Recipes resep;
  String docId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Container(
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Image.network(
                  resep.imageUrl,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Text(
                  resep.name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        left: 20, top: 10, bottom: 10, right: 15),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                        ),
                        const SizedBox(
                          width: 1,
                        ),
                        Text(
                          resep.cookTime,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        const Icon(Icons.person),
                        Padding(
                          padding: const EdgeInsets.only(right: 18.0),
                          child: Text(resep.recipeBy),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );

    // return Card(
    //   shape: const RoundedRectangleBorder(
    //       borderRadius: BorderRadius.only(
    //           topLeft: Radius.circular(10), topRight: Radius.circular(10))),
    //   child: Container(
    //     child: Column(children: [
    //       Expanded(
    //         child: ClipRRect(
    //           borderRadius: const BorderRadius.only(
    //               topLeft: Radius.circular(10), topRight: Radius.circular(10)),
    //           child: Hero(
    //               tag: docId,
    //               child: Image.network(
    //                 resep.imageUrl,
    //                 fit: BoxFit.cover,
    //               )),
    //         ),
    //       ),
    //       Padding(
    //         padding: EdgeInsets.all(7),
    //         child: Text(resep.name),
    //       )
    //     ]),
    //   ),
    // );
  }
}
