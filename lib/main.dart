import 'package:flutter/material.dart';

void main() {
  return runApp(MaterialApp(
    title: 'Dehello',
    theme: ThemeData(primarySwatch: Colors.deepPurple),
    home: HomePage(),
    debugShowCheckedModeBanner: false,
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  double weight = 0;
  double height = 0;
  String date = ' ';
  int radioIndex = 0;
  double slider = 20;
  double bmi = 0;
  String status = ' ';
  String dropDownChoice = '3 times/week';
  int removeIndex = 0;

  var radioList = ['Male', 'Female'];
  var dropDownList = ['6 times/week','5 times/week','4 times/week',
    '3 times/week','2 times/week','1 times/week',];
  var txtstyle = TextStyle(fontSize: 20,fontWeight: FontWeight.bold);
  List <addData> data = [] ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:   Container(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(13),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Logo(),
                    SizedBox(height: 15,),
                    Weight(),
                    SizedBox(height: 15,),
                    Height(),
                    SizedBox(height: 15,),
                    Date(),
                    SizedBox(height: 15,),
                    Gender(),
                    SizedBox(height: 15,),
                    Fit(),
                    SizedBox(height: 15,),
                    age(),
                    SizedBox(height: 15,),
                    Save_and_Clear(),
                    SizedBox(height: 15,),
                    listbuilder(context),
                  ],
                ),
              ),
            )
        )
    );
  }

  Widget Logo() {
    return Image.network('https://www.cdc.gov/healthyweight/images/assessing/bmi-adult-fb-600x315.jpg',
      fit: BoxFit.fill,
    );
  }


  Widget Weight() {
    return Row(
      children: [
        Text('Weight',style: txtstyle,),
        SizedBox(width: 20,),
        Flexible(
            fit: FlexFit.loose,
            child:
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(90)),
                  labelText: 'Weight'
              ),
              onChanged: (value) {
                setState(() {
                  weight = double.parse(value);
                });
              },
            )
        )
      ],
    );
  } // txt field

  Widget Height() {
    return Row(
      children: [
        Text('Height',style: txtstyle,),
        SizedBox(width: 20,),
        Flexible(
            fit: FlexFit.loose,
            child:
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(90)),
                  labelText: 'Height'
              ),
              onChanged: (value) {
                setState(() {
                  height = double.parse(value);
                });
              },
            )
        )
      ],
    );
  } // txt field

  Widget Date() {
    return Row(
      children: [
        Text('Date',style: txtstyle,),
        SizedBox(width: 43,),
        Flexible(
            fit: FlexFit.loose,
            child:
            TextField(
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(90)),
                  labelText: 'Date'
              ),
              onChanged: (value) {
                setState(() {
                  date = value;
                });
              },
            )
        )
      ],
    );
  } // txt field



  Widget Gender() {
    return  Row(
      children: [
        Text('Gender',style: txtstyle,),
        Flexible(fit: FlexFit.loose, child: radioListTile(0),),
        Flexible(fit: FlexFit.loose, child: radioListTile(1),),
      ],
    );
  } // radioBTN

  Widget Fit() {
    return Flexible(
        fit: FlexFit.loose,
        child: Row(
          children: [
            Text('Fit',style: txtstyle,),
            SizedBox(width: 30,),
            DropdownButton(
              items: dropDownList.map((str) {
                return DropdownMenuItem(
                  child: Text(str,style: txtstyle,),
                  value: str,
                );
              }
              ).toList(),

              value: dropDownChoice,
              icon: Icon(Icons.arrow_drop_down_circle,
                color: Colors.blueAccent,),
              iconSize: 30,
              dropdownColor: Colors.blueGrey,
              underline: Container(height: 1,color: Colors.green,),
              onChanged: (value) {
                setState(() {
                  dropDownChoice = value;
                });
              },
            )
          ],
        ));
  } // dropdown

  Widget age() {
    return Row(
      children: [
        Text('age',style: txtstyle,),
        Slider(
          value: slider,
          label: slider.toString(),
          min: 20,
          max: 100,
          divisions: 80,
          activeColor: Colors.blue,

          onChanged: (value) {
            setState(() {
              slider = value;
            });
          },
        ),

        Text(slider.toString()),
      ],
    );
  } // slider

  Widget Save_and_Clear() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        RaisedButton(
          child: Text('Save'),
          color: Colors.blueGrey,
          textColor: Colors.white,
          onPressed: () {

            bmi = weight/(height*height);
            if(bmi < 18){
              status = 'Not Fit';
            }
            else if(bmi > 25){
              status = 'Fat person';
            }
            else
              status = 'healthy person';

            setState(() {
              data.add(
                  addData(
                    weight: weight,
                    height: height,
                    date: date,
                    radioChoice: radioList[radioIndex],
                    dropDownChoice: dropDownChoice,
                    slider: slider,
                    bmi: bmi,
                    status: status,
                  )
              );
            });

          },
        ),
        RaisedButton(
          color: Colors.blueGrey,
          textColor: Colors.white,
          child: Text('Clear'),
          onPressed: () {
            setState(() {
              data.removeAt(removeIndex);
            });
          },
        ),
      ],
    );
  }

  Widget listbuilder(context){
    return Container(
        height: 210,
        child: ListView.builder(itemCount: data.length,itemBuilder: (context, index) {

          return ListTile(
            title: Text('${data[index].date}                        '
                '${data[index].status}'),
            subtitle:Text('${data[index].bmi}        ${data[index].dropDownChoice}'
                '\n weight = ${data[index].weight}            '
                'height = ${data[index].height}               '
                'age = ${data[index].slider}'),
            isThreeLine: true,
            trailing: Icon(Icons.help),
            leading: Icon(Icons.home),
            onTap: () {
              removeIndex = index;
            },
          );
        }
        )
    );
  }


  Widget radioListTile (int value){
    return
      RadioListTile(
        value: value,
        title: Text('${radioList[value]}',style: TextStyle(
            fontSize: 14
        ),),
        activeColor: Colors.lightBlue,
        groupValue: radioIndex,
        onChanged: (value) {
          setState(() {
            radioIndex = value;
          });
        },
      );
  }

}

class addData{
  double weight;
  double height;
  String date;
  String radioChoice;
  double slider;
  double bmi;
  String status;
  String dropDownChoice;

  addData({this.weight, this.height, this.date, this.radioChoice, this.slider,
    this.bmi, this.status, this.dropDownChoice});
}