import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class DashSummery extends StatefulWidget {
  DashSummery({Key? key}) : super(key: key);

  @override
  State<DashSummery> createState() => _DashSummeryState();
}

class _DashSummeryState extends State<DashSummery> {
  String name = 'John Jecob';
  String basicSalary = "Rs. 150000";
  String previousMonthSalary = "Rs. 150000";
  bool _showTable = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.amberAccent.shade100,
      color: Colors.white,
      width: MediaQuery.of(context).size.width - 30,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Summary",
                style: GoogleFonts.righteous(
                  fontSize: 20,
                ),
              ),
            ),
            const Divider(),
            InkWell(
              onTap: (){
                setState(() {
                  _showTable = !_showTable;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Card(
                        shape: CircleBorder(),
                        elevation: 10,
                        child: CircularPercentIndicator(
                          animation: true,
                          animationDuration: 2000,
                          circularStrokeCap: CircularStrokeCap.round,
                          radius: 40.0,
                          lineWidth: 10.0,
                          percent: 8 / 10,
                          center: Text("${(8 / 10 * 100).toStringAsFixed(2)}%"),
                          progressColor: Colors.blue,
                          backgroundColor: Colors.blue.shade100,
                        ),
                      ),
                      Text("Attendance"),
                    ],
                  ),
                  summeryCircularProgress(10,28,Colors.red,Colors.red.shade100,"Leave"),
                  summeryCircularProgress(12,15,Colors.green,Colors.green.shade100,"Task progress"),
                ],
              ),
            ),
            if(_showTable)
            Container(
              margin: EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width - 20,
              // color: Colors.purple.shade50,
              color: Colors.amber.shade100,
              child: DataTable(
                columns:
                const [
                  DataColumn(label: Text('Description')),
                  DataColumn(label: Text('Value')),
                ],
                rows: [
                  DataRow(
                    cells: [
                      DataCell(Text('Basic Salary')),
                      DataCell(Text('${basicSalary}')),
                    ],
                  ),
                  const DataRow(
                    cells: [
                      DataCell(Text('Task Remain')),
                      DataCell(Text('03')),
                    ],
                  ),
                  const DataRow(
                    cells: [
                      DataCell(Text('Leaves Remaining')),
                      DataCell(Text('18')),
                    ],
                  ),
                  const DataRow(
                    cells: [
                      DataCell(Text('No Pay Leaves')),
                      DataCell(Text('0')),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Press for More info",
                style: GoogleFonts.righteous(
                  fontSize: 10,color: Colors.grey
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Creating a Summery Circle Progress
  Widget summeryCircularProgress(int varValue,int fixedV,Color progressColor,Color backgroundColor,String title){
    return Column(
      children: [
        Card(
          shape: const CircleBorder(),
          elevation: 10,
          child: CircularPercentIndicator(
            animation: true,
            animationDuration: 2000,
            circularStrokeCap: CircularStrokeCap.round,
            radius: 40.0,
            lineWidth: 10.0,
            percent: varValue / fixedV,
            center: Text("$varValue / $fixedV"),
            // center: Text("${(10 / 28 * 100).toStringAsFixed (2)}%"),
            progressColor: progressColor,
            backgroundColor: backgroundColor,
          ),
        ),
        Text(title)
      ],
    );
  }
}
