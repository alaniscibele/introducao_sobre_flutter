import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _incrementando = true;
  int _contador = 0;
  List<int> _historico = [];
  int _total = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Alanis Cibele Home Page',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
                onPressed: _incrementarOuDecrementar,
                icon:
                    Icon(Icons.add_location_alt_outlined, color: Colors.white)),
          ],
        ),
        drawer: _buildDrawer(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Contagem:',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 20.0),
              Text(
                '$_contador',
                style: Theme.of(context).textTheme.headline1,
              ),
              const SizedBox(height: 20.0),
              const Text(
                "Lista de Memória:",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                    _historico.isEmpty ? '(Vazio)' : _historico.join(', '),
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 20, color: Colors.grey.shade600)),
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                'Total do Histórico:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                '$_total',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ));
  }

  Drawer _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.brown),
            child: Text(
              'Alanis Cibele',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
          ),
          ListTile(
              leading: const Icon(Icons.alarm_off_outlined),
              title: const Text('Zerar a Contagem'),
              onTap: _zerar),
          ListTile(
              leading: const Icon(Icons.wifi_protected_setup_outlined),
              title: const Text('Inverter a Contagem'),
              onTap: _inverter),
          ListTile(
              leading: const Icon(Icons.remove_red_eye_outlined),
              title: const Text('Memorizar a Contagem'),
              onTap: _memorizar),
          ListTile(
              leading: const Icon(Icons.monitor),
              title: const Text('Totalizar Historico'),
              onTap: _memorizar),
        ],
      ),
    );
  }

//-----------------------------------**-----------------------------------------
  void _incrementarOuDecrementar() {
    setState(() {
      if (_incrementando == true) {
        _contador++;
      } else {
        _contador--;
      }
    });
  }

  void _zerar() {
    Navigator.of(context).pop();
    setState(() {
      _contador = 0;
      _historico.clear();
      _total = 0;
    });
  }

  void _inverter() {
    Navigator.of(context).pop();
    setState(() {
      _incrementando = !_incrementando;
    });
  }

  void _memorizar() {
    Navigator.of(context).pop();
    setState(() {
      _historico.add(_contador);
      _total = _historico.isNotEmpty ? _historico.reduce((a, b) => a + b) : 0;
    });
  }
}
