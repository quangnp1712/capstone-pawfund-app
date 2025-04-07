import 'package:flutter/material.dart';

class ShelterPage extends StatefulWidget {
  final Function callback;
  const ShelterPage(
    this.callback, {
    super.key,
  });

  @override
  State<ShelterPage> createState() => _ShelterPageState();

  static const String ShelterPageRoute = "/shelter-page";
}

class _ShelterPageState extends State<ShelterPage> {
  final List<Map<String, String>> rescueCenters = [
    {
      "image": 'assets/images/error_image.png',
      "name": "Animal Adoption Foundation"
    },
    {
      "image": 'assets/images/error_image.png',
      "name": "PAWFUND ADOPTION CENTER"
    },
    {
      "image": "assets/images/error_image.png",
      "name": "Animal Adoption Foundation"
    },
    {
      "image": "assets/images/error_image.png",
      "name": "PAWFUND ADOPTION CENTER"
    },
  ];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.deepOrangeAccent, Color(0xFFFFA726)],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/logo_1.png',
                        height: 40,
                      ),
                    ],
                  ),
                  const Center(
                      child: Text(
                    "TRUNG TÂM",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )),
                  IconButton(
                    icon: const Icon(
                      Icons.notifications_none,
                      color: Colors.white,
                      size: 30,
                      weight: 0.1,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  // Ô tìm kiếm
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Tìm kiếm trung tâm cứu hộ",
                      prefixIcon:
                          const Icon(Icons.search, color: Colors.orange),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.orange),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.orange),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // GridView hiển thị danh sách trung tâm
                  Container(
                    height: size.height * 0.8,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // 2 cột
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.9,
                      ),
                      itemCount: rescueCenters.length,
                      itemBuilder: (context, index) {
                        final center = rescueCenters[index];
                        return _centerCard(
                            center["image"]!, center["name"]!, size);
                      },
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

  Widget _centerCard(String imageUrl, String name, size) {
    return Container(
      width: size.width * 0.4,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.deepOrangeAccent),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/images/error_image.png',
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Cocoon x AAF gây quỹ cho trạm cứu trợ chó mèo",
              style: TextStyle(fontSize: 12, color: Colors.black),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF36439),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 35),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {},
              child: const Text(
                "XEM THÊM",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
