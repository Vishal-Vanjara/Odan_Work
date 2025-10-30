import 'package:flutter/material.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("nav_bg.jpg"),fit: BoxFit.cover,opacity: 0.4)
          ),
          child: ListView(
            children: [
        // DrawerHeader(
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Expanded(
        //         child: Image.asset("assets/bag5.jpeg", fit: BoxFit.cover),
        //       ),
        //     ],
        //   ),
        //   decoration: BoxDecoration(),
        // ),
              ListTile(leading: Icon(Icons.home), title: Text('Home',style: TextStyle(fontWeight: FontWeight.bold),)),
              ExpansionTile( leading: Icon(Icons.grading_outlined),
                title: Text('Category',style: TextStyle(fontWeight: FontWeight.bold),),
              children: [
                ListTile(title: Text('Action'),
                onTap: (){},
                ),
                ListTile(title: Text('Sci-Fi'),
                  onTap: (){},
                ),
                ListTile(title: Text('Mystery'),
                  onTap: (){},
                ),
                ListTile(title: Text('Adventure'),
                  onTap: (){},
                ),
                ListTile(title: Text('Comedy'),
                  onTap: (){},
                ),
                ListTile(title: Text('Kids'),
                  onTap: (){},
                ),
                ListTile(title: Text('Historial'),
                  onTap: (){},
                ),
                ListTile(title: Text('Magic'),
                  onTap: (){},
                ),
                ListTile(title: Text('Horror'),
                  onTap: (){},
                ),
                ListTile(title: Text('Isekai'),
                  onTap: (){},
                ),
              ],
              ),
              ListTile(leading: Icon(Icons.settings), title: Text("Setting",style: TextStyle(fontWeight: FontWeight.bold))),
              ListTile(leading: Icon(Icons.logout), title: Text("Logout",style: TextStyle(fontWeight: FontWeight.bold))),
            ],
          ),
        ),
      );
  }
}

