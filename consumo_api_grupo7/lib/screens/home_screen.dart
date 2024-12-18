import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'crear_contacto_screen.dart';
import 'lista_contactos_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF3f57a6),
              Color(0xFF2a3c7d),
              Color(0xFF1f2d5e),
              Color(0xFF151622),
            ],
            stops: [0.1, 0.4, 0.7, 1.0],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 5,
                              blurRadius: 10,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'assets/logo_espe.png',
                          height: 120,
                          fit: BoxFit.contain,
                        ),
                      ).animate().fadeIn(duration: 1000.ms).scale(),
                    ),
                    SizedBox(height: 40),
                    AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          '📱 Gestión de Contactos',
                          textStyle: GoogleFonts.poppins(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF96abee),
                          ),
                          speed: const Duration(milliseconds: 100),
                        ),
                      ],
                      totalRepeatCount: 1,
                      displayFullTextOnTap: true,
                    ),
                    SizedBox(height: 20),
                    _buildInfoText('🚀 Desarrollo de Aplicaciones Móviles', 18, FontWeight.w600),
                    SizedBox(height: 10),
                    _buildInfoText('🏫 NRC: 2509 | 👨‍🏫 Profesor: Ing. Doris Chicaiza', 14, FontWeight.normal),
                    SizedBox(height: 20),
                    _buildInfoText('👥 Grupo 7', 18, FontWeight.bold),
                    _buildInfoText('👨‍💻 Almeida Marlyn, Pullaguari Axel, Sanchez Paul', 14, FontWeight.normal),
                    SizedBox(height: 10),
                    _buildInfoText('📝 Tarea 2.2: Creación de API', 16, FontWeight.w600),
                    SizedBox(height: 40),
                    _buildButton(
                      icon: FontAwesomeIcons.userPlus,
                      label: 'Crear Contacto',
                      color: Color(0xFF374274),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CrearContactoScreen()),
                      ),
                    ),
                    SizedBox(height: 20),
                    _buildButton(
                      icon: FontAwesomeIcons.addressBook,
                      label: 'Ver Lista de Contactos',
                      color: Color(0xFF3f57a6),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ListaContactosScreen()),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoText(String text, double fontSize, FontWeight fontWeight) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white.withOpacity(0.1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      margin: EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: Color(0xFF96abee),
        ),
      ),
    ).animate().fadeIn(delay: 200.ms).slideX();
  }

  Widget _buildButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        icon: FaIcon(icon, color: Colors.white),
        label: Text(label, style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: color,
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
      ),
    ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.2, end: 0);
  }
}