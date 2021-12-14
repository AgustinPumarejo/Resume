// librerías que importamos para nuestro proyecto
import 'dart:convert'; // librería que utilizamos para encriptar la contraseña del usuario
import 'package:http/http.dart' as http; // librería que utilizamos para hacer el request a nuestro servidor
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';

void main() => runApp(new MyApp());

// Clase que se llama en nuestro main
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Aqui es donde se crea nuestra aplicación
    return new MaterialApp(
      // primero se llama a nuestra página de LogIn
        theme: ThemeData(primarySwatch: Colors.blue), home: LoginPage());
  }
}

// clase Stateful que llama a la clase _State
class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

// clase S_State que crea la página LogIn
class _State extends State<LoginPage> {
  // guarda los input de texto en variables
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Crea la barra con el título de la pantalla
        appBar: AppBar(
          title: Text('Login Screen App'),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              // crea un ListView de una lista de Widgets los cuales son los contenedores
              children: <Widget>[
                // Contenedor del Dif Huixquilucan
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'DIF HUIXQUILUCAN',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                // Contenedor en donde se ingresa el Nombre de Usuario
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController, // se guarda el input de nombre de usuario
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nombre de Usuario',
                    ),
                  ),
                ),
                // Contenedor en donde se ingresa la Contraseña
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController, // se guarda el input de contraseña
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Contraseña',
                    ),
                  ),
                ),
                // Contenedor con el botón quee inicia sesión
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('Iniciar Sesión'),
                      // Cuando se oprime se imprime en la terminal el usuario y la contraseña encriptada
                      onPressed: () {
                        var bytes1 = utf8.encode(
                            passwordController.text); // data being hashed
                        var digest1 = sha256.convert(bytes1);
                        print(nameController.text);
                        print(digest1);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CategoriesScreen(list: categories)));
                      },
                    )),
              ],
            )));
  }
}

// Lista con nuestras categorías
var categories = [
  "Educación",
  "Salud",
  "Atención al Adulto Mayor",
  "Atención Jurídica",
  "Departamento de Capacitación a la Mujer",
  "Comedor Infantil",
  "Actividad Física",
];

// Lista con las Subcategorias de Educación
var subCategories = [
  "Estancias Infantiles",
  "Jardín de Niños",
  "Prepa DIF",
  "Aulas Móviles"
];

// Lista con las Servicio de Estancias de Niños
var services = [
  "DIF Central",
  "Pirules",
  "San Fernando",
  "Jesús del monte",
  "Zacamulpa",
  "San Bartolomé Coatepec",
  "La Glorieta",
  "Magdalena Chichicaspa"
];

// Contador que del nivel de la aplicación: 0 = Home Screen, 1 = Subcatogories, 2 = Services
var counterScreens = 0;

// Clase de Categorias en donde se crean nuestro GridView
class CategoriesScreen extends StatelessWidget {
  // atributo que acepta la calse: una lista de strings
  final List<String> list;
  // Constructor de la clase
  const CategoriesScreen({
    Key? key,
    required this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // Crea el menú de hamburguesa
      drawer: Drawer(
        // Crea un ListView
        child: ListView(children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.grey,
            ),
            child: Text('Menu'),
          ),
          // Dentro del menú aparece el contrato de Términos y Condiciones
          ListTile(
            title: const Text('Términos y Condiciones'),
            onTap: () {
              print("terms");
            },
          ),
        ]),
      ),
      // Título de la pantalla
      appBar: new AppBar(
        title: new Text('DIF HUIXQUILUCAN'),
      ),
      body: new Padding(
        padding: const EdgeInsets.only(top: 12.0),
        // Crea el GridView de las Categorias y sus subcatecorias y los servicios de estas
        child: new GridView.count(
          crossAxisCount: 2,
          // lista de Widgets
          children: <Widget>[
            // Hace un for loop que itera por todos los valores de categoría, subcategorías y servicios
            for (var i in list)
              InkWell(
                // Crea los contenedores donde se van a poner las categorías, subcategorías y servicios.
                child: Container(
                    child: Center(
                      child: Container(
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: Text(i,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20))
                      ),
                    ),
                    decoration: new BoxDecoration(
                      color: Colors.blue,
                      borderRadius:
                      new BorderRadius.all(const Radius.circular(10.0)),
                    )
                ),
                // Cuando se le da click al grid se crean los grids de subcategorías para cada categoría
                onTap: () {
                  switch (counterScreens) {
                    case 0:
                      Navigator.push(
                          context,
                          // se crea de
                          MaterialPageRoute(
                              builder: (context) => SubcategoriesScreen(
                                  list: subCategories, category: i)));
                      counterScreens++;
                      break;
                    case 1:
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ServicesScreen(list: services, subCategory: i)));
                      counterScreens++;
                      break;
                    default:
                      break;
                  }
                },
              ),
          ],
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        ),
      ),
    );
  }
}

// Clase para la pantalla de subtegorias
class SubcategoriesScreen extends StatelessWidget {
  // atributos que acepta de la clase como parámetros
  final String category;
  final List<String> list;
  // constructor de clase
  const SubcategoriesScreen({
    Key? key,
    required this.list,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            counterScreens--;
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(child: CategoriesScreen(list: list)),
    );
  }
}

// Clase para la pantalla de servicios
class ServicesScreen extends StatelessWidget {
  // atributos que acepta de la calse como parámetros
  final String subCategory;
  final List<String> list;
  // constructor de clase
  const ServicesScreen({
    Key? key,
    required this.list,
    required this.subCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(subCategory),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            counterScreens--;
            Navigator.pop(context);
          },
        ),
      ),
      body: new Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: new GridView.count(
          crossAxisCount: 1,
          childAspectRatio: 4,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 2.0,
          children: <Widget>[
            for (var i in list)
              InkWell(
                child: Container(
                    child: Center(
                      child: Container(
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: Text(i,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20))),
                    ),
                    decoration: new BoxDecoration(
                      color: Colors.blue,
                      borderRadius:
                      new BorderRadius.all(const Radius.circular(10.0)),
                    )),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ServiceDetailScreen(service: i)));
                },
              ),
          ],
        ),
      ),
    );
  }
}

// función fetch para obtener datos del servicio
Future<ServiceRequest> fetchServiceRequest() async {
  // variable de response
  final response = await http
      .get(Uri.parse('http://52.207.255.109:5000/servicio/'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    //return parseServiceDetail(response.body);
    return ServiceRequest.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load information');
  }
}

// Service request para cada servicio
class ServiceRequest {
  final ServiceDetail one;
  final ServiceDetail two;
  final ServiceDetail three;

  ServiceRequest({
    required this.one,
    required this.two,
    required this.three,
  });

  factory ServiceRequest.fromJson(Map<String, dynamic> json) {
    return ServiceRequest(
        one: ServiceDetail.fromJson(json["0"]),
        two: ServiceDetail.fromJson(json["1"]),
        three: ServiceDetail.fromJson(json["2"])
    );
  }
}

// clase con variables de la base de datos en la tabla de servicios
class ServiceDetail {
  final int idServicio;
  final String direccion;
  final String descripcion;
  final int fechaPublicacion;
  final int fechaVencimiento;
  final double cuota;
  final String imagen;
  final String subcategoria;
  final int fechaCreacion;
  final int fechaModificacion;

  ServiceDetail ({
    required this.idServicio,
    required this.direccion,
    required this.descripcion,
    required this.fechaPublicacion,
    required this.fechaVencimiento,
    required this.cuota,
    required this.imagen,
    required this.subcategoria,
    required this.fechaCreacion,
    required this.fechaModificacion
  });

  factory ServiceDetail.fromJson(Map<String, dynamic> json) {
    return ServiceDetail(
        idServicio: json["idServicio"],
        direccion: json["direccion"],
        descripcion: json["descripcion"],
        fechaPublicacion: json["fechaPublicacion"],
        fechaVencimiento: json["fechaVencimiento"],
        cuota: json["cuota"],
        imagen: json["imagen"],
        subcategoria: json["subcategoria"],
        fechaCreacion: json["fecha_creacion"],
        fechaModificacion: json["fechaModificacion"]
    );
  }
}

// clase que enseña la información de casda servicio con base a la información de la base de datos
class ServiceDetailScreen extends StatelessWidget {
  final String service;
  late Future<ServiceRequest> serviceDetails;

  ServiceDetailScreen({
    Key? key,
    required this.service,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    serviceDetails = fetchServiceRequest();
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(service),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: new Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
          child: FutureBuilder<ServiceRequest>(
            future: fetchServiceRequest(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    // descripción
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: Text(snapshot.data!.one.descripcion,
                          textAlign: TextAlign.justify),
                    ),
                    // ubicación
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: Text(snapshot.data!.one.direccion),
                      alignment: Alignment.topLeft,
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: Text("Cuota:   " + snapshot.data!.one.cuota.toString()),
                      alignment: Alignment.topLeft,
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: Image.network("https://difhuixquilucan.gob.mx/wp-content/uploads/2020/03/logoDif.png"),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          )
      ),
    );
  }
}
