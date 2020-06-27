import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

final List<String> imgList = [
  'https://i.picsum.photos/id/866/500/300.jpg?hmac=gTBX2xIXKy_WSASp2ITBfmK7WFeBZyiuIumiEUmowcw',
  'https://i.picsum.photos/id/237/500/300.jpg?hmac=31zB7Ceyovr2h1qoOGeI6Pg8iB8wDymSCLEasQlnHIE',
  'https://i.picsum.photos/id/870/500/300.jpg?blur=2&grayscale&hmac=J8YcDKD75Pcbp0SlslavgdJhEHbja1KjLJ2_WP_jZbg',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

void main() => runApp(CarouselDemo());

class CarouselDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (ctx) => CarouselDemoHome(),
        '/prefetch': (ctx) => PrefetchImageDemo()
      }
    );
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
      appBar: AppBar(title: Text('Carousel demo'),),
      body: ListView(
        children: <Widget>[
          DemoItem('Image carousel slider with prefetch demo', '/prefetch'),
        ],
      ),
    );
  }
}

final List<Widget> imageSliders = imgList.map((item) => Container(
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
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                'No. ${imgList.indexOf(item)} image',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      )
    ),
  ),
)).toList();

class PrefetchImageDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PrefetchImageDemoState();
  }
}

class _PrefetchImageDemoState extends State<PrefetchImageDemo> {
  final List<String> images = [
  'https://i.picsum.photos/id/866/500/300.jpg?hmac=gTBX2xIXKy_WSASp2ITBfmK7WFeBZyiuIumiEUmowcw',
  'https://i.picsum.photos/id/237/500/300.jpg?hmac=31zB7Ceyovr2h1qoOGeI6Pg8iB8wDymSCLEasQlnHIE',
  'https://i.picsum.photos/id/870/500/300.jpg?blur=2&grayscale&hmac=J8YcDKD75Pcbp0SlslavgdJhEHbja1KjLJ2_WP_jZbg',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      images.forEach((imageUrl) {
        precacheImage(NetworkImage(imageUrl), context);
      });
    });
    super.initState();
  }

_setHorizontalItem(){
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
                onTap: (){},
                child:Text('See all'),
              )
            ],
          ),
        ),
        Expanded(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: images.length,
          itemBuilder: (context,index){
            return _setComonContainerView(context, images[index]);
          }
          )
        ),
      ],
    ),
  );
}

_setCorosalEffets(){
  return Container(
            height: 230,
            // color: Colors.red,
            child: CarouselSlider.builder(
              itemCount: images.length,
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
              ),
              itemBuilder: (context, index) {
                return Container(
                  child: Center(
                    child: Image.network(images[index], fit: BoxFit.cover, width: 1000)
                  ),
                );
              },
            )
          );
}


_setBanner(){
  return new Container(
    height: 280,
    color: Colors.white,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
          itemCount: images.length,
          itemBuilder: (context,index){
            return new Container(
              width: MediaQuery.of(context).size.width,
              padding: new EdgeInsets.all(8),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(images[index]),
                    fit: BoxFit.cover
                  ),
                  borderRadius: BorderRadius.circular(8)
                ),
              ),
            );
          }
          )
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
          _setBanner(),
          _setHorizontalItem(),
        ],
      ),
    );
  }
}



setCommonWidget(String title,String subtitle,Color color){
  return Row(
            children: <Widget>[
              Text("$title",
              style: TextStyle(
                color: color,
                fontSize: 13
              ),
              ),
              InkWell(
                onTap: (){},
                child:Text('$subtitle',
                style: TextStyle(
                color: color,
                fontSize: 13
              ),
                ),
              )
            ],
          );
}

_setComonContainerView(BuildContext context,String image){
  return new Container(
                width: MediaQuery.of(context).size.width/2,
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
                              image:NetworkImage(image),
                              fit: BoxFit.cover
                              ),
                              borderRadius: BorderRadius.circular(8)
                          ),
                        )
                    ),
                    ],
                  ),
                ),
              );
}