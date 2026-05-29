import 'package:flutter/material.dart';
import '../constantes/colores.dart';

// ── Botón principal Sonaris — Estilo verde minimalista ────

class SonarisButton extends StatefulWidget {
  final String texto;
  final VoidCallback? onTap;
  final bool cargando;
  final double height;
  final SonarisButtonStyle estilo;

  const SonarisButton({
    super.key,
    required this.texto,
    this.onTap,
    this.cargando = false,
    this.height = 56,
    this.estilo = SonarisButtonStyle.primario,
  });

  @override
  State<SonarisButton> createState() => _EstadoSonarisButton();
}

enum SonarisButtonStyle { primario, secundario, fantasma }

class _EstadoSonarisButton extends State<SonarisButton> {
  bool _presionado = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _presionado = true),
      onTapUp: (_) {
        setState(() => _presionado = false);
        widget.onTap?.call();
      },
      onTapCancel: () => setState(() => _presionado = false),
      child: AnimatedScale(
        scale: _presionado ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: Container(
          width: double.infinity,
          height: widget.height,
          decoration: _buildDecoration(),
          child: Center(
            child: widget.cargando
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                        strokeWidth: 2.5, color: Colors.white))
                : Text(
                    widget.texto,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: widget.estilo == SonarisButtonStyle.fantasma
                          ? verde
                          : Colors.white,
                      letterSpacing: 0.3,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildDecoration() {
    switch (widget.estilo) {
      case SonarisButtonStyle.primario:
        return BoxDecoration(
          color: verde,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: verde.withValues(alpha: 0.2),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        );
      case SonarisButtonStyle.secundario:
        return BoxDecoration(
          color: verde.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: verde.withValues(alpha: 0.4)),
        );
      case SonarisButtonStyle.fantasma:
        return BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        );
    }
  }
}

// ── Botón de ícono circular ───────────────────────────────

class SonarisIconButton extends StatelessWidget {
  final IconData icono;
  final VoidCallback? onTap;
  final double size;
  final bool activo;

  const SonarisIconButton({
    super.key,
    required this.icono,
    this.onTap,
    this.size = 52,
    this.activo = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: activo ? verde : tarjeta2,
          border: Border.all(
            color: activo
                ? verde.withValues(alpha: 0.5)
                : Colors.white.withValues(alpha: 0.08),
          ),
          boxShadow: activo
              ? [
                  BoxShadow(
                    color: verde.withValues(alpha: 0.25),
                    blurRadius: 12,
                  ),
                ]
              : null,
        ),
        child: Icon(
          icono,
          color: activo ? Colors.white : Colors.white.withValues(alpha: 0.5),
          size: size * 0.42,
        ),
      ),
    );
  }
}
