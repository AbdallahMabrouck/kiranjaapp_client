import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            height: 55,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white70,
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue.shade900)),
                    contentPadding: const EdgeInsets.fromLTRB(8, 5, 8, 10),
                    hintText: "Search",
                    hintStyle:
                        const TextStyle(color: Colors.grey, fontSize: 18),
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 30,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 53,
            color: Colors.transparent,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.money_outlined,
                      size: 30,
                      color: Colors.blue.shade900,
                    ),
                    const Text(
                      "Cash on Delivery",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    Icon(
                      Icons.drive_eta_rounded,
                      size: 30,
                      color: Colors.blue.shade900,
                    ),
                    const Text(
                      "Free Delivery",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    Icon(
                      Icons.price_change_rounded,
                      size: 30,
                      color: Colors.blue.shade900,
                    ),
                    const Text(
                      "Lowest Prices",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
