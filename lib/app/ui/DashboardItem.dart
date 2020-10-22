import 'package:flutter/material.dart';
import 'package:flutter_api/app/services/api.dart';
import 'package:intl/intl.dart';

class DashboardItemStyle {
  const DashboardItemStyle(this.color, this.imgUl, this.title);

  final Color color;
  final String imgUl;
  final String title;
}

Map<ApiEndPoint, DashboardItemStyle> _itemsStyle = {
  ApiEndPoint.cases:
      DashboardItemStyle(Color(0xFFFF0000), "assets/count.png", "Cases"),
  ApiEndPoint.casesConfirmed: DashboardItemStyle(
      Color(0xFFF0F000), "assets/patient.png", "Cases Confirmed"),
  ApiEndPoint.casesSuspected: DashboardItemStyle(
      Color(0xFFFF0000), "assets/suspect.png", "Cases Suspected"),
  ApiEndPoint.deaths:
      DashboardItemStyle(Color(0xFFF0F0FF), "assets/death.png", "Deaths"),
  ApiEndPoint.recovered:
      DashboardItemStyle(Color(0xFFFF0000), "assets/fever.png", "Recovered"),
};

class DashboardItem extends StatelessWidget {
  const DashboardItem({Key key, this.endPoint, this.value}) : super(key: key);

  final ApiEndPoint endPoint;
  final int value;

  String numberFormat(int number) {
    if (number == null) {
      return "";
    } else {
      return NumberFormat("##,###,###,###", 'en_US').format(number);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dataStyle = _itemsStyle[endPoint];
    return Container(
      padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 8,
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FittedBox(
                    child: Text(
                      dataStyle.title,
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          .copyWith(color: dataStyle.color),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 56,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      dataStyle.imgUl,
                      color: dataStyle.color,
                    ),
                    FittedBox(
                      child: Text(
                        numberFormat(value),
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(color: dataStyle.color),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
