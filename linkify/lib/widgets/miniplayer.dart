import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class Miniplayer extends StatefulWidget{
//   Miniplayer();
//   @override
//   State<Miniplayer> createState()=>MiniplayerState();
// }
// class MiniplayerState extends State<Miniplayer>{
//   @override
//   Widget build(BuildContext context,){
//     return Placeholder;
//   }
// }

class Miniplayer extends StatelessWidget {
  const Miniplayer({
    Key? key,
    required this.list,
  }) : super(key: key);

  final List list;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: ((context, index) {
          bool last = list.length == (index + 1);
          return Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: last ? 16 : 0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // img
                Container(
                  width: 138,
                  height: 138,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(list[index].img),
                        fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                // name
                SizedBox(
                  width: 135,
                  child: Text(list[index].title,
                      style: const TextStyle(
                          color: Color(0xffffffff),
                          fontWeight: FontWeight.w700,
                          fontFamily: "Raleway",
                          fontStyle: FontStyle.normal,
                          fontSize: 13.0,
                          overflow: TextOverflow.ellipsis),
                      maxLines: 2,
                      textAlign: TextAlign.left),
                ),
                const SizedBox(
                  height: 4,
                ),
                // show-creator
                SizedBox(
                  width: 135,
                  child: Text(list[index].creator ?? '',
                      style: const TextStyle(
                          color: Color(0xffb3b3b3),
                          fontWeight: FontWeight.w500,
                          fontFamily: "Raleway",
                          fontStyle: FontStyle.normal,
                          fontSize: 13.0,
                          overflow: TextOverflow.ellipsis),
                      maxLines: 1,
                      textAlign: TextAlign.left),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}