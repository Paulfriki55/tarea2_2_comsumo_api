import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../providers/personas_provider.dart';
import '../widgets/persona_list_item.dart';
import 'crear_contacto_screen.dart';

class ListaContactosScreen extends StatefulWidget {
  @override
  _ListaContactosScreenState createState() => _ListaContactosScreenState();
}

class _ListaContactosScreenState extends State<ListaContactosScreen> {
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<PersonasProvider>(context, listen: false).fetchPersonas();
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Contactos',
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Color(0xFF96abee))
        ),
        backgroundColor: Color(0xFF3f57a6),
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFF96abee)),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF3f57a6), Color(0xFF151622)],
          ),
        ),
        child: Consumer<PersonasProvider>(
          builder: (context, personasProvider, child) {
            if (personasProvider.personas.isEmpty) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF96abee)),
                ).animate().scale(),
              );
            }
            return ListView.builder(
              itemCount: personasProvider.personas.length,
              itemBuilder: (context, index) {
                final persona = personasProvider.personas[index];
                return PersonaListItem(persona: persona)
                    .animate()
                    .fadeIn(delay: (50 * index).ms)
                    .slideX();
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => CrearContactoScreen()),
          );
        },
        child: FaIcon(FontAwesomeIcons.plus, color: Colors.white),
        backgroundColor: Color(0xFF374274),
      ).animate().scale(),
    );
  }
}

