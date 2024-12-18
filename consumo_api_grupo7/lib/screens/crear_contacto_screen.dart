import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/persona.dart';
import '../providers/personas_provider.dart';

class CrearContactoScreen extends StatefulWidget {
  @override
  _CrearContactoScreenState createState() => _CrearContactoScreenState();
}

class _CrearContactoScreenState extends State<CrearContactoScreen> {
  final _formKey = GlobalKey<FormState>();
  String _nombre = '';
  String _apellido = '';
  String _telefono = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Contacto', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Color(0xFF96abee))),
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
        child: SafeArea(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - kToolbarHeight,
              ),
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        'Ingrese los datos del nuevo contacto',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF96abee),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 30),
                      _buildAnimatedTextField(
                        label: 'Nombre',
                        onSaved: (value) => _nombre = value!,
                        icon: FontAwesomeIcons.user,
                        delay: 0,
                      ),
                      SizedBox(height: 20),
                      _buildAnimatedTextField(
                        label: 'Apellido',
                        onSaved: (value) => _apellido = value!,
                        icon: FontAwesomeIcons.userTag,
                        delay: 200,
                      ),
                      SizedBox(height: 20),
                      _buildAnimatedTextField(
                        label: 'Teléfono',
                        onSaved: (value) => _telefono = value!,
                        icon: FontAwesomeIcons.phone,
                        delay: 400,
                      ),
                      SizedBox(height: 40),
                      ElevatedButton.icon(
                        icon: FaIcon(FontAwesomeIcons.floppyDisk),
                        label: Text('Guardar Contacto', style: GoogleFonts.poppins(fontSize: 16)),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color(0xFF374274),
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: _submitForm,
                      ).animate().fadeIn(delay: 600.ms).scale(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedTextField({
    required String label,
    required Function(String?) onSaved,
    required IconData icon,
    required int delay,
  }) {
    return TextFormField(
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor ingrese $label';
        }
        return null;
      },
      onSaved: onSaved,
    ).animate().fadeIn(delay: delay.ms).slideX();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final newPersona = Persona(
        nombre: _nombre,
        apellido: _apellido,
        telefono: _telefono,
      );
      Provider.of<PersonasProvider>(context, listen: false)
          .addPersona(newPersona)
          .then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Contacto agregado con éxito', style: GoogleFonts.poppins()),
            backgroundColor: Color(0xFF374274),
          ),
        );
        Navigator.pop(context);
      });
    }
  }
}

