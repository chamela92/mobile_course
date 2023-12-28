
import 'package:flutter/material.dart';
import 'package:contact_buddy/db_helper/database_helper.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen>createState() =>_HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{

  List<Map<String, dynamic>>_allData =[];
  bool _isLoading =true;

  //Get All data from database
  void _refreshData () async {
    final data = await SQLHelper.getAllData();
    setState(() {
      _allData = data;
      _isLoading = false;
    });

  }

  @override
  void initState(){
    super.initState();
    _refreshData();
  }



  Future<void> _addData() async{
    await SQLHelper.createData(_titleController.text, _descController.text,_emailController.text);
    _refreshData();
  }

  //update data
  Future<void> _updateData(int id) async{
    await SQLHelper.updateData(id, _titleController.text, _descController.text,_emailController.text);
    _refreshData();
  }

//delete data
  void _deleteData(int id) async {
    await SQLHelper.deleteData(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      backgroundColor: Colors.redAccent,
      content:Text("Data Deleted"),
    ));
    _refreshData();
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  final TextEditingController _emailController =TextEditingController();
  void showBottomSheet(int? id) async {

    //if id is not null then it will update otherwise it will new data
    //when edit icon is pressed then id will be given to bottom sheet function and
    //it will edit

    if(id != null){
      final existingData =
      _allData.firstWhere((element) => element ['id'] == id);
      _titleController.text = existingData['title'];
      _descController.text = existingData['desc'];
      _emailController.text =existingData['email'];
    }
    showModalBottomSheet(
        elevation: 5,
        isScrollControlled: true,
        context: context,
        builder: (_) => Container(
          padding:EdgeInsets.only(
            top: 90,
            left: 15,
            right: 15,
            bottom: MediaQuery.of(context).viewInsets.bottom +50,

          ),
          child:  Column(
            mainAxisSize:MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.end,
            children:[
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  border:OutlineInputBorder(),
                  hintText: "Name",
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _descController,
                decoration:  const InputDecoration(
                  border:OutlineInputBorder(),
                  hintText: "Contact Number",
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _emailController,
                decoration:  const InputDecoration(
                  border:OutlineInputBorder(),
                  hintText: "Email",
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child:ElevatedButton(
                  onPressed: () async{
                    if(id ==null){
                      await _addData();
                    }
                    if (id != null) {
                      await _updateData(id);
                    }
                    _titleController.text ="";
                    _descController.text ="";
                    _emailController.text="";

                    //Hide bottom sheet
                    Navigator.of(context).pop();
                    print("Data Added");
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Text(id ==null ?"Save Data" :"Update",

                      style: const TextStyle(
                        fontSize: 18,

                        color: Colors.cyan,
                        fontWeight: FontWeight.w500),
                      ),
                  ),
              ),

              ),

            ],
          ),
        ),

    );
  }


  @override
  Widget build(BuildContext context){
    return  Scaffold(
      backgroundColor: const Color(0xFFFE6D4F7),
      appBar: AppBar(
        title: const Text("Contact List"),
        backgroundColor: const Color(0XFFCE9DFB),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(),
      )
          :ListView.builder(
          itemCount:_allData.length ,
          itemBuilder: (context,index)=>Card(
            margin: const EdgeInsets.all(15),
            child: ListTile(
              title: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  _allData [index]['title'],
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              subtitle: Text(_allData[index]['desc']),



              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () {
                        showBottomSheet(_allData[index]['id']);
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.indigo,
                      ),
                  ),
                  IconButton(
                    onPressed: () {
                      _deleteData(_allData[index]['id']);
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.redAccent,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showBottomSheet(null),
        child: const Icon(Icons.add),
      ),
    );

}

}

