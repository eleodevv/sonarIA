import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constantes/colores.dart';
import '../services/sesion_service.dart';

class PantallaSplash extends StatefulWidget {
  final VoidCallback alComenzar;
  const PantallaSplash({super.key, required this.alComenzar});

  @override
  State<PantallaSplash> createState() => _EstadoSplash();
}

class _EstadoSplash extends State<PantallaSplash>
    with TickerProviderStateMixin {
  final PageController _ctrl = PageController();
  int _pagina = 0;
  Timer? _timer;

  late final AnimationController _ctrlHeader;
  late final AnimationController _ctrlPulse;
  late final AnimationController _ctrlPress;

  static const _paginas = [
    _DatosPagina(
      imagen: 'assets/onboarding1.png',
      icono: Icons.waving_hand_rounded,
      titulo: 'Detecta tus acordes',
      descripcion:
          'Toca tu guitarra y la IA reconoce el acorde en tiempo real con alta precisión.',
      esSaludo: true,
    ),
    _DatosPagina(
      imagen: 'assets/onboarding2.png',
      icono: Icons.mic_rounded,
      titulo: 'Detecta tus acordes',
      descripcion:
          'Toca tu guitarra y la IA reconoce el acorde en tiempo real con alta precisión.',
    ),
    _DatosPagina(
      imagen: 'assets/onboarding3.png',
      icono: Icons.school_rounded,
      titulo: 'Aprende paso a paso',
      descripcion:
          'Módulos de video organizados por nivel para que avances a tu ritmo.',
    ),
    _DatosPagina(
      imagen: 'assets/onboarding4.png',
      icono: Icons.quiz_rounded,
      titulo: 'Pon a prueba tu nivel',
      descripcion:
          'Quiz de teoría musical y práctica de acordes para medir tu progreso.',
    ),
    _DatosPagina(
      imagen: 'assets/onboarding5.png',
      icono: Icons.auto_awesome_rounded,
      titulo: 'Asistente con IA',
      descripcion:
          'Pregúntale al asistente sobre acordes, técnicas y teoría musical en cualquier momento.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _ctrlHeader = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..forward();

    _ctrlPulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);

    _ctrlPress = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
      lowerBound: 0.0,
      upperBound: 1.0,
    );

    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (_pagina < _paginas.length - 1) {
        _ctrl.nextPage(
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _ctrl.dispose();
    _ctrlHeader.dispose();
    _ctrlPulse.dispose();
    _ctrlPress.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final nombre = context.watch<SesionService>().nombre ?? 'músico';
    final firstName = nombre.trim().split(' ').first;
    final esUltima = _pagina == _paginas.length - 1;

    return Stack(fit: StackFit.expand, children: [
      // Carrusel de páginas
      PageView.builder(
        controller: _ctrl,
        onPageChanged: (i) => setState(() => _pagina = i),
        itemCount: _paginas.length,
        itemBuilder: (_, i) => _PaginaCarrusel(
          datos: _paginas[i],
          nombre: _paginas[i].esSaludo ? firstName : null,
          activa: i == _pagina,
        ),
      ),

      // Header Sonaris
      Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(28, 18, 28, 0),
            child: FadeTransition(
              opacity: CurvedAnimation(
                parent: _ctrlHeader,
                curve: Curves.easeOut,
              ),
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, -0.25),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: _ctrlHeader,
                  curve: Curves.easeOutCubic,
                )),
                child: Row(children: [
                  SizedBox(
                    width: 44,
                    height: 44,
                    child: Image.asset(
                      'assets/logo_sonaris.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Sonaris',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: blanco,
                      letterSpacing: -0.4,
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ),
      ),

      // Contenido inferior
      Positioned(
        left: 0,
        right: 0,
        bottom: 0,
        child: Container(
          padding: const EdgeInsets.fromLTRB(28, 0, 28, 44),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Indicadores
              AnimatedBuilder(
                animation: _ctrlPulse,
                builder: (context, _) {
                  final pulse = (_ctrlPulse.value * 2 - 1).abs();
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_paginas.length, (i) {
                      final sel = i == _pagina;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 380),
                        curve: Curves.easeOutCubic,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: sel ? 24 : 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: sel
                              ? verde
                              : Colors.white.withValues(alpha: 0.22),
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: sel
                              ? [
                                  BoxShadow(
                                    color: verde.withValues(
                                      alpha: 0.35 + 0.2 * pulse,
                                    ),
                                    blurRadius: 8 + 4 * pulse,
                                    spreadRadius: 0.5,
                                  ),
                                ]
                              : null,
                        ),
                      );
                    }),
                  );
                },
              ),
              const SizedBox(height: 30),
              // Botón
              GestureDetector(
                onTapDown: (_) => _ctrlPress.forward(),
                onTapCancel: () => _ctrlPress.reverse(),
                onTapUp: (_) => _ctrlPress.reverse(),
                onTap: esUltima
                    ? widget.alComenzar
                    : () {
                        _ctrl.nextPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      },
                child: AnimatedBuilder(
                  animation: _ctrlPress,
                  builder: (context, child) {
                    final scale = 1.0 - (_ctrlPress.value * 0.04);
                    return Transform.scale(scale: scale, child: child);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    decoration: BoxDecoration(
                      color: verde,
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: [
                        BoxShadow(
                          color: verde.withValues(alpha: 0.25),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          esUltima ? 'Comenzar' : 'Siguiente',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (!esUltima) ...[
                const SizedBox(height: 16),
                _BotonSaltar(onTap: widget.alComenzar),
              ],
            ],
          ),
        ),
      ),
    ]);
  }
}

// ── Página individual del carrusel ────────────────────────

class _PaginaCarrusel extends StatefulWidget {
  final _DatosPagina datos;
  final String? nombre;
  final bool activa;
  const _PaginaCarrusel({
    required this.datos,
    this.nombre,
    this.activa = true,
  });

  @override
  State<_PaginaCarrusel> createState() => _EstadoPaginaCarrusel();
}

class _EstadoPaginaCarrusel extends State<_PaginaCarrusel>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _fadeIn;
  late final Animation<double> _iconScale;
  late final Animation<Offset> _titleSlide;
  late final Animation<double> _titleFade;
  late final Animation<Offset> _descSlide;
  late final Animation<double> _descFade;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fadeIn = CurvedAnimation(
      parent: _ctrl,
      curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
    );
    _iconScale = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.05, 0.7, curve: Curves.elasticOut),
      ),
    );
    _titleSlide = Tween<Offset>(
      begin: const Offset(0, 0.35),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _ctrl,
      curve: const Interval(0.25, 0.85, curve: Curves.easeOutCubic),
    ));
    _titleFade = CurvedAnimation(
      parent: _ctrl,
      curve: const Interval(0.25, 0.85, curve: Curves.easeOut),
    );
    _descSlide = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _ctrl,
      curve: const Interval(0.4, 1.0, curve: Curves.easeOutCubic),
    ));
    _descFade = CurvedAnimation(
      parent: _ctrl,
      curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
    );
    if (widget.activa) {
      _ctrl.forward();
    } else {
      _ctrl.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(covariant _PaginaCarrusel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.activa && !oldWidget.activa) {
      _ctrl
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final datos = widget.datos;
    final nombre = widget.nombre;
    final esSaludo = nombre != null;

    return Stack(fit: StackFit.expand, children: [
      Image.asset(datos.imagen, fit: BoxFit.cover),
      // Gradiente oscuro
      const DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0x55000000),
              Color(0x33000000),
              Color(0xCC000000),
              Color(0xFF000000),
            ],
            stops: [0.0, 0.25, 0.7, 1.0],
          ),
        ),
        child: SizedBox.expand(),
      ),
      // Contenido
      SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(28, 0, 28, 200),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ícono con estilo verde
              FadeTransition(
                opacity: _fadeIn,
                child: ScaleTransition(
                  scale: _iconScale,
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: verde.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: verde.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: Icon(datos.icono, color: verde, size: 28),
                  ),
                ),
              ),
              const SizedBox(height: 22),
              // Título
              SlideTransition(
                position: _titleSlide,
                child: FadeTransition(
                  opacity: _titleFade,
                  child: Text(
                    esSaludo ? 'Hola, $nombre.' : datos.titulo,
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w800,
                      color: blanco,
                      height: 1.05,
                      letterSpacing: -0.8,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              // Descripción
              SlideTransition(
                position: _descSlide,
                child: FadeTransition(
                  opacity: _descFade,
                  child: esSaludo
                      ? Text(
                          'LISTO PARA TOCAR',
                          style: TextStyle(
                            fontSize: 12,
                            color: verde.withValues(alpha: 0.9),
                            letterSpacing: 4,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      : Text(
                          datos.descripcion,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withValues(alpha: 0.7),
                            height: 1.6,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}

// ── Botón Saltar ──────────────────────────────────────────

class _BotonSaltar extends StatelessWidget {
  final VoidCallback onTap;
  const _BotonSaltar({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        child: Text(
          'Saltar',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white.withValues(alpha: 0.5),
          ),
        ),
      ),
    );
  }
}

// ── Modelo ────────────────────────────────────────────────

class _DatosPagina {
  final String imagen;
  final IconData icono;
  final String titulo;
  final String descripcion;
  final bool esSaludo;
  const _DatosPagina({
    required this.imagen,
    required this.icono,
    required this.titulo,
    required this.descripcion,
    this.esSaludo = false,
  });
}
