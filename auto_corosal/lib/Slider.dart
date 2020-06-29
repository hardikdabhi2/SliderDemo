import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

final fashionList = [
  "Assets/img1.png",
  "Assets/img2.png",
  "Assets/img3.png",
  "Assets/img4.png",
];

final fashionBanner = [
  "Assets/banner1.jpg",
  "Assets/banner2.png",
  "Assets/banner3.jpg",
  "Assets/banner4.jpg",
];

void main() => runApp(CarouselDemo());

class CarouselDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: '/', routes: {
      '/': (ctx) => CarouselDemoHome(),
      '/prefetch': (ctx) => PrefetchImageDemo()
    });
  }
}

class DemoItem extends StatelessWidget {
  final String title;
  final String route;
  DemoItem(this.title, this.route);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      onTap: () {
        Navigator.pushNamed(context, route);
      },
    );
  }
}

class CarouselDemoHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carousel demo'),
      ),
      body: ListView(
        children: <Widget>[
          DemoItem('Image carousel slider with prefetch demo', '/prefetch'),
        ],
      ),
    );
  }
}

final List<Widget> imageSliders = fashionList
    .map((item) => Container(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.network(item, fit: BoxFit.cover, width: 1000.0),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(200, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: Text(
                          'No. ${fashionList.indexOf(item)} image',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ))
    .toList();

class PrefetchImageDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PrefetchImageDemoState();
  }
}

class _PrefetchImageDemoState extends State<PrefetchImageDemo> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fashionList.forEach((imageUrl) {
        precacheImage(AssetImage(imageUrl), context);
      });
    });
    super.initState();
  }

  _setHorizontalItem() {
    return new Container(
      height: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Horizontal List"),
                InkWell(
                  onTap: () {},
                  child: Text('See all'),
                )
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: fashionList.length,
                  itemBuilder: (context, index) {
                    return _setComonContainerView(context, fashionList[index]);
                  })),
        ],
      ),
    );
  }

  _setCorosalEffets() {
    return Container(
        height: 230,
        // color: Colors.red,
        child: CarouselSlider.builder(
          itemCount: fashionBanner.length,
          options: CarouselOptions(
            autoPlay: true,
            aspectRatio: 2.0,
            enlargeCenterPage: true,
          ),
          itemBuilder: (context, index) {
            return Container(
                child: Center(
              child: Image(
                image: AssetImage(fashionBanner[index]),
                fit: BoxFit.cover,
              ),
            ));
          },
        ));
  }

  _setBanner() {
    return new Container(
        height: 130,
        color: Colors.white,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 1,
            itemBuilder: (context, index) {
              return new Container(
                width: MediaQuery.of(context).size.width,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('Assets/offer.png'),
                        fit: BoxFit.cover),
                  ),
                ),
              );
            }));
  }

  _setColumnGridView() {
    return new Container(
      height: 650,
      color: Colors.grey[200],
      child: new GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        physics: NeverScrollableScrollPhysics(),
        children: new List<Widget>.generate(fashionList.length, (index) {
          return Container(
            padding: new EdgeInsets.all(5),
            child: Container(
              padding: new EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Column(
                children: [
                  Expanded(
                    flex: 7,
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 12),
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(fashionList[index]),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                        Positioned(
                            right: 0,
                            bottom: 10,
                            child: Chip(
                              label: Text(
                                ' 10% OFF ',
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.red,
                            ))
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Container(
                        padding: new EdgeInsets.all(8),
                        child: new Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  '40.07 SAR',
                                  style: new TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                    fontSize: 15,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Text(
                                      '50.07',
                                      style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54,
                                        fontSize: 13,
                                      ),
                                    ),
                                    Container(
                                        height: 2,
                                        width: 45,
                                        color: Colors.black54)
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(Icons.favorite_border,
                                    color: Colors.grey, size: 20),
                                SizedBox(width: 2),
                                Text(
                                  '124',
                                  style: new TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ))
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Slider Demo'),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView(
        children: <Widget>[
          _setCorosalEffets(),
          _setHorizontalItem(),
          SizedBox(height: 15),
          _setBanner(),
          SizedBox(height: 15),
          _setColumnGridView()
        ],
      ),
    );
  }
}

setCommonWidget(String title, String subtitle, Color color) {
  return Row(
    children: <Widget>[
      Text(
        "$title",
        style: TextStyle(color: color, fontSize: 13),
      ),
      InkWell(
        onTap: () {},
        child: Text(
          '$subtitle',
          style: TextStyle(color: color, fontSize: 13),
        ),
      )
    ],
  );
}

_setComonContainerView(BuildContext context, String image) {
  return new Container(
    width: MediaQuery.of(context).size.width / 2,
    color: Colors.white,
    padding: new EdgeInsets.all(8),
    child: Material(
      elevation: 2.0,
      borderRadius: BorderRadius.circular(8),
      child: new Column(
        children: <Widget>[
          Expanded(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(image), fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(8)),
              )),
        ],
      ),
    ),
  );
}
