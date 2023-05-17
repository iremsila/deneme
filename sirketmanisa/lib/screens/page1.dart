import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

class Page1 extends StatelessWidget {
   Page1({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => boxdesign(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: start(),
      ),
    );
  }
}
class start extends StatelessWidget {
  const start({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 100.0,
                right: 100.0,
                top: 100,
                bottom: 25,
              ),
              child: Image.network('https://iasbh.tmgrup.com.tr/cab67d/1200/627/0/33/724/411?u=https://isbh.tmgrup.com.tr/sbh/2020/12/14/hafta-ici-bakkallar-ve-marketler-acik-mi-14-aralik-bugun-marketler-kaca-kadar-acik-kacta-kapaniyor-bim-a101-sok-migros-1607925145644.jpg'),
            ),
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: Text(
                'We Deliver Groceries At Your Doorstep!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
            Text( 'Fresh items everyday :)',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 25),
            GestureDetector(
              onTap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return home();
                  },
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromARGB(250, 100, 90, 200),
                ),
                child: const Text("Get Started",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
class home extends StatefulWidget {
  const home({super.key});
  @override
  State<home> createState() => _homeState();
}
class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: Icon(
            Icons.location_on,
            color: Colors.grey[700],
          ),
        ),
        title: Text(
          'USA',
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey[800],
          ),
        ), centerTitle: false,
        actions: [
          Padding(padding: const EdgeInsets.only(right: 24.0),
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12), ),
              child: Icon(
                Icons.person,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return Box();
            },
          ),
        ),
        child: const Icon(Icons.shopping_bag),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 48),
          const Padding(padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Text('Good morning,'),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              "Let's order fresh items for you",
            ),
          ),
          const SizedBox(height: 25),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Divider(),
          ),const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              "Fresh Items",
            ),
          ),
          Expanded(
            child: Consumer<boxdesign>(
              builder: (context, value, child) {
                return GridView.builder(
                  padding: const EdgeInsets.all(12),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: value.shop.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 1.2,
                  ),
                  itemBuilder: (context, index) {
                    return shopapp(
                      Name: value.shop[index][0],
                      Price: value.shop[index][1],
                      imagePath: value.shop[index][2],
                      color: value.shop[index][3],
                      onPressed: () =>
                          Provider.of<boxdesign>(context, listen: false)
                              .addItemToCart(index),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
class boxdesign extends ChangeNotifier {
  final List _shop = const [
    ["Avocado", "3", 'https://st2.myideasoft.com/idea/ha/92/myassets/products/222/avakado.jpg?revision=1603383894', Colors.yellow],
    ["Banana", "3", 'https://cdn.pixabay.com/photo/2012/04/26/18/41/banana-42793__340.png', Colors.yellow],
    ["Chicken", "3", 'https://i.ytimg.com/vi/oqcu48MLMqw/maxresdefault.jpg', Colors.yellow],
    ["Water", "3", 'https://cdnsta.avansas.com/mnresize/900/-/urun/83745/damla-cam-sise-su-0-33lt-12li-zoom-1.jpg', Colors.yellow],
  ];
  List _cart = [];
  get cart => _cart;
  get shop => _shop;
  void addItemToCart(int index) {
    _cart.add(_shop[index]);
    notifyListeners();
  }
  void removeItemFromCart(int index) {
    _cart.removeAt(index);
    notifyListeners();
  }
  String calculateTotal() {
    double totalPrice = 0;
    for (int i = 0; i < cart.length; i++) {
      totalPrice += double.parse(cart[i][1]);
    }
    return totalPrice.toStringAsFixed(2);
  }
}
class Box extends StatelessWidget {
  const Box({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.grey[800],
        ),
      ),
      body: Consumer<boxdesign>(
        builder: (context, value, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  "My box",
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListView.builder(
                    itemCount: value.cart.length,
                    padding: EdgeInsets.all(10),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10)),
                          child: ListTile(
                            leading: Image.network(
                              value.cart[index][2],
                              height: 35, ),
                            title: Text(
                              value.cart[index][0],
                              style: const TextStyle(fontSize: 20),
                            ),
                            subtitle: Text(
                              '\$' + value.cart[index][1],
                              style: const TextStyle(fontSize: 15),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.cancel),
                              onPressed: () =>
                                  Provider.of<boxdesign>(context, listen: false)
                                      .removeItemFromCart(index),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(36.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.pink,
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Price',
                            style: TextStyle(color: Colors.pink[200]),
                          ), const SizedBox(height: 8),
                          Text(
                            '\$${value.calculateTotal()}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.pink.shade200),
                          borderRadius: BorderRadius.circular(28),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: const [
                            Text(
                              'Pay Now',
                              style: TextStyle(color: Colors.white),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
class shopapp extends StatelessWidget {
  final String Name;
  final String Price;
  final String imagePath;
  final color;
  void Function()? onPressed;
  shopapp({
    super.key,
    required this.Name,
    required this.Price,
    required this.imagePath,
    required this.color,
    required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: color[100],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Image.network(
                imagePath,
                height: 64,
              ),
            ),
            Text(
              Name,
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            MaterialButton(
              onPressed: onPressed,
              color: color,
              child: Text(
                '\$' + Price,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}