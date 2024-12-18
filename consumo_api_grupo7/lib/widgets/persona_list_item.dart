import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/persona.dart';import '../screens/detalle_contacto_screen.dart';

class PersonaListItem extends StatelessWidget {
  final Persona persona;

  const PersonaListItem({Key? key, required this.persona}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DetalleContactoScreen(persona: persona),
                ),
              );
            },
            backgroundColor: Color(0xFF374274),
            foregroundColor: Colors.white,
            icon: FontAwesomeIcons.penToSquare,
            label: 'Editar',
          ),
          SlidableAction(
            onPressed: (context) {
              // Implementar lógica de eliminación
            },
            backgroundColor: Color(0xFF3f57a6),
            foregroundColor: Colors.white,
            icon: FontAwesomeIcons.trash,
            label: 'Eliminar',
          ),
        ],
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Color(0xFF96abee),
          child: FaIcon(FontAwesomeIcons.user, color: Color(0xFF151622)),
        ),
        title: Text(
          '${persona.nombre} ${persona.apellido}',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Color(0xFF96abee)),
        ),
        subtitle: Text(
          persona.telefono,
          style: GoogleFonts.poppins(color: Color(0xFF96abee).withOpacity(0.7)),
        ),
        trailing: FaIcon(FontAwesomeIcons.angleRight, color: Color(0xFF96abee)),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DetalleContactoScreen(persona: persona),
            ),
          );
        },
      ),
    );
  }
}

