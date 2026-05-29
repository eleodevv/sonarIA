import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../constantes/colores.dart';
import '../constantes/acordes.dart';
import '../services/api_service.dart';
import '../services/audio_service.dart';

/// Modal interactivo que pide al usuario tocar un acorde después de ver el video.
/// Usa el modelo MLP del backend para verificar si el acorde es correcto.
class RetoAcorde extends StatefulWidget {
  final String acorde;
  final VoidCallback alCompletar;

  const RetoAcorde({
    super.key,
    required this.acorde,
    required this.alCompletar,
  });

  @override
  State<RetoAcorde> createState() => _EstadoRetoAcorde();
}

class _EstadoRetoAcorde extends State<RetoAcorde>
    with TickerProviderStateMixin {
  final AudioService _audio = AudioService();

  bool _grabando = false;
  bool _procesando = false;
  int _progreso = 0;
  Timer? _timer;
  bool? _correcto;
  String? _acordeDetectado;
  double? _confianza;
  int _intentos = 0;

  late AnimationController _entradaCtrl;
  late AnimationController _pulsoCtrl;

  @override
  void initState() {
    super.initState();
    _entradaCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..forward();
    _pulsoCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _audio.dispose();
    _entradaCtrl.dispose();
    _pulsoCtrl.dispose();
    super.dispose();
  }

  Future<void> _iniciarGrabacion() async {
    final ok = await _audio.startRecording();
    if (!ok) {
      _mostrarError('Necesitas dar permiso al micrófono');
      return;
    }
    HapticFeedback.mediumImpact();
    setState(() {
      _grabando = true;
      _progreso = 0;
      _correcto = null;
      _acordeDetectado = null;
    });
    _timer = Timer.periodic(const Duration(milliseconds: 100), (t) {
      setState(() => _progreso++);
      if (_progreso >= 40) {
        t.cancel();
        _detenerGrabacion();
      }
    });
  }

  Future<void> _detenerGrabacion() async {
    _timer?.cancel();
    HapticFeedback.mediumImpact();
    final ruta = await _audio.stopRecording();
    setState(() {
      _grabando = false;
      _progreso = 0;
    });
    if (ruta != null) await _verificar(ruta);
  }

  Future<void> _verificar(String ruta) async {
    setState(() => _procesando = true);
    try {
      final api = context.read<ApiService>();
      final r = await api.verificarAcorde(ruta, widget.acorde);
      final correcto = r['correcto'] as bool? ?? false;
      final confianza = (r['confianza'] as num?)?.toDouble() ?? 0.0;
      final detectado = r['acorde_detectado'] as String?;
      final mensaje = r['mensaje'] as String?;

      setState(() {
        _correcto = correcto;
        _acordeDetectado = detectado;
        _confianza = confianza / 100.0; // Normalizar a 0-1
        _intentos++;
      });

      if (correcto) {
        HapticFeedback.heavyImpact();
      } else {
        HapticFeedback.lightImpact();
        if (mensaje != null && mensaje.isNotEmpty) {
          _mostrarError(mensaje);
        }
      }
    } catch (e) {
      _mostrarError('Error al conectar con el servidor');
    } finally {
      setState(() => _procesando = false);
    }
  }

  void _mostrarError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg, style: const TextStyle(color: Colors.white)),
      backgroundColor: rojo,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final nombre = nombreAcorde[widget.acorde] ?? widget.acorde;

    return AnimatedBuilder(
      animation: _entradaCtrl,
      builder: (context, child) {
        return FadeTransition(
          opacity: CurvedAnimation(parent: _entradaCtrl, curve: Curves.easeOut),
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.2),
              end: Offset.zero,
            ).animate(CurvedAnimation(
                parent: _entradaCtrl, curve: Curves.easeOutCubic)),
            child: child,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(top: 100),
        decoration: const BoxDecoration(
          color: Color(0xFF121212),
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom + 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 28),

              // Resultado (si ya tocó)
              if (_correcto == true) _buildExito(),
              if (_correcto == false) _buildFallo(),

              // Estado inicial o después de fallo
              if (_correcto != true) ...[
                // Ícono del reto
                AnimatedBuilder(
                  animation: _pulsoCtrl,
                  builder: (context, child) {
                    final scale = 1.0 + (_pulsoCtrl.value * 0.05);
                    return Transform.scale(scale: scale, child: child);
                  },
                  child: Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: verde.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                      border: Border.all(color: verde.withValues(alpha: 0.3)),
                    ),
                    child:
                        const Icon(Icons.music_note_rounded, color: verde, size: 32),
                  ),
                ),
                const SizedBox(height: 20),

                // Título
                const Text(
                  '¡Tu turno!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: blanco,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Toca el acorde $nombre (${widget.acorde})',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white.withValues(alpha: 0.6),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'La IA verificará si lo tocaste correctamente',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white.withValues(alpha: 0.4),
                  ),
                ),
                const SizedBox(height: 32),

                // Barra de progreso de grabación
                if (_grabando)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: _progreso / 40,
                          minHeight: 6,
                          backgroundColor: tenue.withValues(alpha: 0.3),
                          valueColor:
                              const AlwaysStoppedAnimation<Color>(verde),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Escuchando... ${((_progreso / 40) * 4).toStringAsFixed(1)}s',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white.withValues(alpha: 0.5),
                        ),
                      ),
                    ]),
                  ),

                if (_procesando)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Column(children: [
                      SizedBox(
                        width: 28,
                        height: 28,
                        child: CircularProgressIndicator(
                            strokeWidth: 2.5, color: verde),
                      ),
                      SizedBox(height: 12),
                      Text('Analizando tu acorde...',
                          style: TextStyle(fontSize: 13, color: medio)),
                    ]),
                  ),

                const SizedBox(height: 24),

                // Botón de grabar
                if (!_grabando && !_procesando)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: GestureDetector(
                      onTap: _iniciarGrabacion,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: verde,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: verde.withValues(alpha: 0.25),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.mic_rounded,
                                color: Colors.white, size: 22),
                            const SizedBox(width: 10),
                            Text(
                              _intentos == 0
                                  ? 'Tocar acorde'
                                  : 'Intentar de nuevo',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                // Botón de grabar (detener)
                if (_grabando)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: GestureDetector(
                      onTap: _detenerGrabacion,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: rojo,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.stop_rounded,
                                color: Colors.white, size: 22),
                            SizedBox(width: 10),
                            Text(
                              'Detener',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                const SizedBox(height: 16),

                // Saltar (después de 2 intentos fallidos)
                if (_intentos >= 2 && _correcto != true)
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      widget.alCompletar();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'Saltar por ahora',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white.withValues(alpha: 0.4),
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white.withValues(alpha: 0.3),
                        ),
                      ),
                    ),
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExito() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: verde.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check_rounded, color: verde, size: 44),
        ),
        const SizedBox(height: 20),
        const Text(
          '¡Excelente!',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: verde,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Tocaste el acorde ${widget.acorde} correctamente',
          style: TextStyle(
            fontSize: 15,
            color: Colors.white.withValues(alpha: 0.7),
          ),
        ),
        if (_confianza != null) ...[
          const SizedBox(height: 6),
          Text(
            'Confianza: ${(_confianza! * 100).toStringAsFixed(0)}%',
            style: const TextStyle(fontSize: 13, color: verde),
          ),
        ],
        const SizedBox(height: 32),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            widget.alCompletar();
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: verde,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Siguiente video',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 20),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
      ]),
    );
  }

  Widget _buildFallo() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 0, 32, 24),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: rojo.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: rojo.withValues(alpha: 0.2)),
        ),
        child: Row(
          children: [
            const Icon(Icons.close_rounded, color: rojo, size: 22),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Casi, inténtalo de nuevo',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: rojo,
                    ),
                  ),
                  if (_acordeDetectado != null)
                    Text(
                      'Se detectó: $_acordeDetectado',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withValues(alpha: 0.5),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
