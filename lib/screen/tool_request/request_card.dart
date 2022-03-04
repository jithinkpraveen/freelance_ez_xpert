import 'package:flutter/material.dart';

class RequestCard extends StatelessWidget {
  const RequestCard({Key? key, this.data}) : super(key: key);
  // ignore: prefer_typing_uninitialized_variables
  final data;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 5, 10, 8),
      padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[400]!,
            blurRadius: 1,
            offset: const Offset(0, 0),
          )
        ],
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Text(
                "${data['tool_name']}",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                decoration: BoxDecoration(
                  color: data['status'] == 1
                      ? Colors.orange
                      : data['status'] == 2
                          ? Colors.green
                          : Colors.red,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  data['status'] == 1
                      ? "Pending"
                      : data['status'] == 2
                          ? "Approved"
                          : "Rejected",
                  style: const TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
          const SizedBox(height: 3),
          Text(
            "${data['from_date']} - ${data['to_date']}",
            style: const TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 3),
          Text(
            data['reason'] ?? "Not avaliable",
            style: const TextStyle(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
