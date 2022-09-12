import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';

class ResultScreen extends StatelessWidget {
  final Future<dynamic> future;
  const ResultScreen({Key? key, required this.future}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder(
          future: future,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if(snapshot.hasData){
              if(snapshot.data.isEmpty){
                return const Center(
                  child: Text("Could not find any result",
                  style: TextStyle(
                    fontSize: 30,
                    color:  Colors.blueAccent
                  ),),
                );
              }
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) => Stack(
                    children: [
                      Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Image.network(snapshot.data[index]["largeImageURL"],)
                    ),
                      Positioned(child: Container(
                        padding: const EdgeInsets.all(20),
                          child: GestureDetector(
                            onTap: ()async{
                              await GallerySaver.saveImage(snapshot.data[index]["largeImageURL"], toDcim: true).then((value){
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Image added to gallery")
                                  )
                                );
                              });
                            },
                              child: const Icon(Icons.file_download,color: Colors.white,))), top: 0, right: 0,)
                  ]
                  )
              );
            }
            else{
              if(snapshot.hasError){
                return const Center(
                  child: Text("Something went wrong",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.redAccent
                  ),),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        )
      ),
    );
  }
}