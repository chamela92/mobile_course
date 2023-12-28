import 'package:flutter/material.dart';
import 'home_screen.dart';

class WelcomeScreen extends StatelessWidget{
  const WelcomeScreen({super.key});



  @override
  Widget build(BuildContext context){
    return  Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(10),
        child:  Column(
          children :[
            const SizedBox(height: 15),
             Align(alignment: Alignment.centerRight,
              child: TextButton(
               onPressed: (){
                 // Navigator.push(context,MaterialPageRoute(
                 //builder:(context) =>
                 //));
               },
              child: const Text(
                  "SKIP",
                style: TextStyle(
                  color: Color(0xFF7165D6),
                  fontSize: 20,
                ),

            )

            ),
            ),
            const SizedBox(height :50),
             Padding(
              padding: const EdgeInsets.all(20),
              child:Image.network("https://img.freepik.com/free-vector/panda-bear-cute-animal-cartoon-flat-style-illustration_24908-60694.jpg?w=740&t=st=1703432501~exp=1703433101~hmac=0dd1565f55fe8aeb0d3c4ede883f23dabf79aed0cec006b309cf0f58d6548266"),
            ),

            const SizedBox(height :10),
            const Text("Contact Buddy",
            style:TextStyle(
              color:Color(0xFF7165D6),
              fontSize: 40,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              wordSpacing: 2,
            ),
            ),
            const SizedBox(height:60),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Material(
                  color:const Color(0XFF7165d6),
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    onTap: () {
                       Navigator.push(context,MaterialPageRoute(
                       builder:(context) => const HomeScreen(),
                      ));
                    },
                    child: const Padding (padding:EdgeInsets.symmetric(vertical: 15,horizontal: 40),
                        child:Text("Get Started",
                          style: TextStyle(
                            color:Color(0xFFFFFFFF),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,

                          ),
                        )
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}





  
  










