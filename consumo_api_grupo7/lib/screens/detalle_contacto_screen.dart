import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/persona.dart';
import '../providers/personas_provider.dart';

class DetalleContactoScreen extends StatefulWidget {
  final Persona persona;

  DetalleContactoScreen({required this.persona});

  @override
  _DetalleContactoScreenState createState() => _DetalleContactoScreenState();
}

class _DetalleContactoScreenState extends State<DetalleContactoScreen> {
  late TextEditingController _nombreController;
  late TextEditingController _apellidoController;
  late TextEditingController _telefonoController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(text: widget.persona.nombre);
    _apellidoController = TextEditingController(text: widget.persona.apellido);
    _telefonoController = TextEditingController(text: widget.persona.telefono);
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _apellidoController.dispose();
    _telefonoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isEditing ? 'Editar Contacto' : 'Detalle del Contacto',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Color(0xFF96abee),
          ),
        ),
        backgroundColor: Color(0xFF3f57a6),
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFF96abee)),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.save : Icons.edit, color: Color(0xFF96abee)),
            onPressed: () {
              if (_isEditing) {
                _saveChanges();
              } else {
                setState(() {
                  _isEditing = true;
                });
              }
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF3f57a6), Color(0xFF151622)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - kToolbarHeight,
              ),
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildTextField('Nombre', _nombreController, _isEditing, FontAwesomeIcons.user),
                    SizedBox(height: 20),
                    _buildTextField('Apellido', _apellidoController, _isEditing, FontAwesomeIcons.userTag),
                    SizedBox(height: 20),
                    _buildTextField('Teléfono', _telefonoController, _isEditing, FontAwesomeIcons.phone),
                    SizedBox(height: 40),
                    if (!_isEditing)
                      ElevatedButton.icon(
                        icon: FaIcon(FontAwesomeIcons.trash),
                        label: Text('Eliminar Contacto', style: GoogleFonts.poppins(fontSize: 16)),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color(0xFF374274),
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () => _deleteContact(),
                      ).animate().fadeIn(delay: 300.ms).scale(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, bool enabled, IconData icon) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.poppins(color: Color(0xFF96abee)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFF96abee)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFF96abee).withOpacity(0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFF96abee)),
        ),
        prefixIcon: FaIcon(icon, color: Color(0xFF96abee)),
        filled: true,
        fillColor: Color(0xFF151622).withOpacity(0.5),
      ),
      style: GoogleFonts.poppins(color: Color(0xFF96abee)),
      enabled: enabled,
    ).animate().fadeIn(delay: 200.ms).slideX();
  }

  void _saveChanges() {
    final updatedPersona = Persona(
      id: widget.persona.id,
      nombre: _nombreController.text,
      apellido: _apellidoController.text,
      telefono: _telefonoController.text,
    );

    Provider.of<PersonasProvider>(context, listen: false)
        .updatePersona(widget.persona.id!, updatedPersona)
        .then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Contacto actualizado con éxito', style: GoogleFonts.poppins()),
          backgroundColor: Color(0xFF374274),
        ),
      );
      setState(() {
        _isEditing = false;
      });
    });
  }

  void _deleteContact() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFF151622),
          title: Text('Confirmar eliminación',
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Color(0xFF96abee))
          ),
          content: Text('¿Estás seguro de que quieres eliminar este contacto?',
              style: GoogleFonts.poppins(color: Color(0xFF96abee))
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar', style: GoogleFonts.poppins(color: Color(0xFF96abee))),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Eliminar', style: GoogleFonts.poppins(color: Colors.red)),
              onPressed: () {
                Provider.of<PersonasProvider>(context, listen: false)
                    .deletePersona(widget.persona.id!)
                    .then((_) {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Contacto eliminado con éxito', style: GoogleFonts.poppins()),
                      backgroundColor: Color(0xFF374274),
                    ),
                  );
                });
              },
            ),
          ],
        );
      },
    );
  }
}

