import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../models/random_user_list_res.dart';
import '../services/http_service.dart';
import 'info_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController scrollController = ScrollController();
  bool isLoading = true;
  List<RandomUser> userList = [];
  int currentPage = 1;

  loadRandomUserList() async {
    setState(() {
      isLoading = true;
    });
    var response = await Network.GET(Network.API_RANDOM_USER_LIST,
        Network.paramsRandomUserList(currentPage));
    var randomUserListRes = Network.parseRandomUserList(response!);
    currentPage = randomUserListRes.info.page + 1;

    setState(() {
      userList.addAll(randomUserListRes.results);
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadRandomUserList();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent <=
          scrollController.offset) {
        loadRandomUserList();
      }
    });
  }

  _callToInfoPage(RandomUser randomUser) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return InfoPage(randomUser: randomUser);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        title: const Text('Random Users - SetState'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          ListView.builder(
            controller: scrollController,
            itemCount: userList.length,
            itemBuilder: (ctx, index) {
              return _itemOfRandomUser(userList[index], index);
            },
          ),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : const SizedBox.shrink()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        splashColor: Colors.grey[300],
        onPressed: () {
          scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        },
        child: const Icon(Iconsax.arrow_up_1),
      ),
    );
  }

  Widget _itemOfRandomUser(RandomUser randomUser, int index) {
    return GestureDetector(
      onTap: () {
        _callToInfoPage(randomUser);
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          border: Border.all(width: 1, color: Colors.black),
        ),
        child: Row(
          children: [
            CachedNetworkImage(
              height: 80,
              width: 80,
              fit: BoxFit.cover,
              imageUrl: randomUser.picture.large,
              filterQuality: FilterQuality.high,
              placeholder: (context, url) => Container(
                height: 80,
                width: 80,
                color: Colors.grey,
              ),
              errorWidget: (context, url, error) => Container(
                height: 80,
                width: 80,
                color: Colors.grey,
                child: const Icon(Icons.error),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$index - ${randomUser.name.first} ${randomUser.name.last}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    randomUser.email,
                    maxLines: 1,
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    randomUser.cell,
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
