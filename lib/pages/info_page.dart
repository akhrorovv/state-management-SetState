import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../models/random_user_list_res.dart';

class InfoPage extends StatefulWidget {
  RandomUser? randomUser;

  InfoPage({super.key, this.randomUser});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  late RandomUser randomUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    randomUser = widget.randomUser!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.grey[200],
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 50),
        child: Stack(
          children: [
            // user info
            Container(
              height: 400,
              margin: const EdgeInsets.only(top: 50, right: 20, left: 20),
              padding: const EdgeInsets.only(top: 60),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 1, color: Colors.black),
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Text(
                      '${randomUser.name.title} ${randomUser.name.first} ${randomUser.name.last}',
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text(
                      '${randomUser.dob.age} years old',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.only(left: 20),
                      margin: const EdgeInsets.only(bottom: 15),
                      child: Row(
                        children: [
                          const Icon(Iconsax.calendar_1),
                          const SizedBox(width: 20),
                          Text(
                            maxLines: 2,
                            '${randomUser.dob.date}'.substring(0, 10),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 20),
                      margin: const EdgeInsets.only(bottom: 15),
                      child: Row(
                        children: [
                          const Icon(Iconsax.sms),
                          const SizedBox(width: 20),
                          Text(randomUser.email)
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 20),
                      margin: const EdgeInsets.only(bottom: 15),
                      child: Row(
                        children: [
                          const Icon(Iconsax.call),
                          const SizedBox(width: 20),
                          Text(randomUser.phone)
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 20),
                      margin: const EdgeInsets.only(bottom: 15),
                      child: Row(
                        children: [
                          const Icon(Iconsax.house),
                          const SizedBox(width: 20),
                          Text(
                            maxLines: 2,
                            '${randomUser.location.street.number}, ${randomUser.location.street.name}',
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 20),
                      margin: const EdgeInsets.only(bottom: 15),
                      child: Row(
                        children: [
                          const Icon(Iconsax.location),
                          const SizedBox(width: 20),
                          Text(
                            '${randomUser.location.city}, ${randomUser.location.country}',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // user image
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(2),
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(width: 1, color: Colors.black),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(randomUser.picture.large),
                    ),
                  ),
                ],
              ),
            ),

            // back button
            GestureDetector(
              onTap: (){
                Navigator.of(context).pop();
              },
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 45,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1, color: Colors.black),
                      ),
                      child: const Icon(Iconsax.arrow_left_1),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
