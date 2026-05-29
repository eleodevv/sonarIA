import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../constantes/colores.dart';
import '../constantes/acordes.dart';
import '../widgets/reto_acorde.dart';

// ── Modelos ───────────────────────────────────────────────

class VideoModulo {
  final String titulo;
  final String subtitulo;
  final String youtubeId;
  final String duracion;
  final String descripcion;
  final List<String> aprenderas;
  final String instructor;
  final String rolInstructor;
  final bool esShort;
  final String? acordeAsociado; // Acorde que debe tocar el usuario después del video

  const VideoModulo({
    required this.titulo,
    required this.subtitulo,
    required this.youtubeId,
    required this.duracion,
    required this.descripcion,
    required this.aprenderas,
    required this.instructor,
    required this.rolInstructor,
    this.esShort = false,
    this.acordeAsociado,
  });
}

class TarjetaTeoria {
  final String titulo;
  final String contenido;
  final IconData icono;
  final List<String> puntos;
  const TarjetaTeoria({
    required this.titulo,
    required this.contenido,
    required this.icono,
    this.puntos = const [],
  });
}

class ItemModulo {
  final VideoModulo? video;
  final TarjetaTeoria? teoria;
  const ItemModulo.video(this.video) : teoria = null;
  const ItemModulo.teoria(this.teoria) : video = null;
  bool get esVideo => video != null;
}

// ── Contenido del Módulo 1 ────────────────────────────────

final _itemsModulo1 = [
  const ItemModulo.video(VideoModulo(
    titulo: 'Conociendo tu guitarra',
    subtitulo: 'Módulo 1 · Video 1',
    youtubeId: 'X0v4aT96rXM',
    duracion: 'Short',
    descripcion:
        'Descubre qué es la guitarra, para qué sirve y por qué es uno de los instrumentos más populares del mundo.',
    aprenderas: [
      'Qué es la guitarra y sus tipos principales',
      'Para qué sirve aprender a tocarla',
      'Motivación y mentalidad para empezar'
    ],
    instructor: 'Sonaris Team',
    rolInstructor: 'Equipo de instructores de guitarra',
    esShort: true,
  )),
  const ItemModulo.video(VideoModulo(
    titulo: 'Cómo colocarse la guitarra',
    subtitulo: 'Módulo 1 · Video 2',
    youtubeId: '6Qo2FK-IudU',
    duracion: 'Short',
    descripcion:
        'Conoce cada parte de tu guitarra: cabeza, clavijas, mástil, trastes, cuerdas, caja y puente.',
    aprenderas: [
      'Identificar la cabeza y las clavijas',
      'Conocer el mástil y los trastes',
      'Entender la importancia de las cuerdas',
      'Reconocer la caja y el puente'
    ],
    instructor: 'Sonaris Team',
    rolInstructor: 'Equipo de instructores de guitarra',
    esShort: true,
  )),
  const ItemModulo.video(VideoModulo(
    titulo: 'Cómo afinar mi guitarra',
    subtitulo: 'Módulo 1 · Video 3',
    youtubeId: 'S9ryVINTbLo',
    duracion: 'Short',
    descripcion:
        'Aprende a afinar tu guitarra correctamente usando un afinador o de oído para que siempre suene bien.',
    aprenderas: [
      'Cómo usar un afinador digital',
      'Nombres y notas de cada cuerda',
      'Técnica para girar las clavijas correctamente',
      'Verificar la afinación de oído'
    ],
    instructor: 'Sonaris Team',
    rolInstructor: 'Equipo de instructores de guitarra',
    esShort: true,
  )),
];

// ── Contenido del Módulo 2: Acordes básicos ───────────────

final _itemsModulo2 = [
  const ItemModulo.video(VideoModulo(
    titulo: 'Acorde DO (C)',
    subtitulo: 'Módulo 2 · Video 1',
    youtubeId: 'xFMDVSPvzr8',
    duracion: 'Short',
    descripcion:
        'Aprende a tocar el acorde de DO Mayor (C), con forma diagonal en el diapasón.',
    aprenderas: [
      'Posición de los dedos para el acorde C',
      'Forma diagonal en trastes 1, 2 y 3',
      'Cuerdas que suenan y cuáles no',
      'Consejos para que suene limpio'
    ],
    instructor: 'Sonaris Team',
    rolInstructor: 'Equipo de instructores de guitarra',
    esShort: true,
    acordeAsociado: 'C',
  )),
  const ItemModulo.video(VideoModulo(
    titulo: 'Acorde LA (A)',
    subtitulo: 'Módulo 2 · Video 2',
    youtubeId: 'dH5TwByFSTE',
    duracion: 'Short',
    descripcion:
        'Aprende a tocar el acorde de LA Mayor (A), uno de los acordes más usados en guitarra.',
    aprenderas: [
      'Posición de los dedos para el acorde A',
      'Cuerdas que se tocan y cuáles no',
      'Consejos para que suene limpio',
      'Ejercicio de cambio de acorde'
    ],
    instructor: 'Sonaris Team',
    rolInstructor: 'Equipo de instructores de guitarra',
    esShort: true,
    acordeAsociado: 'A',
  )),
  const ItemModulo.video(VideoModulo(
    titulo: 'Acorde RE (D)',
    subtitulo: 'Módulo 2 · Video 3',
    youtubeId: 'uBwDPGuVia8',
    duracion: 'Short',
    descripcion:
        'Aprende a tocar el acorde de RE Mayor (D), con forma de triángulo en los trastes 2 y 3.',
    aprenderas: [
      'Posición de los dedos para el acorde D',
      'Solo se tocan 4 cuerdas (D-G-B-e)',
      'Forma de triángulo en el diapasón',
      'Transición entre A y D'
    ],
    instructor: 'Sonaris Team',
    rolInstructor: 'Equipo de instructores de guitarra',
    esShort: true,
    acordeAsociado: 'D',
  )),
  const ItemModulo.video(VideoModulo(
    titulo: 'Acorde MI Mayor (E)',
    subtitulo: 'Módulo 2 · Video 4',
    youtubeId: 'cUF3pDTZVcc',
    duracion: 'Short',
    descripcion:
        'Aprende a tocar el acorde de MI Mayor (E), donde todas las cuerdas suenan.',
    aprenderas: [
      'Posición de los dedos para el acorde E',
      'Todas las cuerdas suenan en este acorde',
      'Colocación en trastes 1 y 2',
      'Transición entre D y E'
    ],
    instructor: 'Sonaris Team',
    rolInstructor: 'Equipo de instructores de guitarra',
    esShort: true,
    acordeAsociado: 'E',
  )),
  const ItemModulo.video(VideoModulo(
    titulo: 'Acorde SOL (G)',
    subtitulo: 'Módulo 2 · Video 5',
    youtubeId: 'fHBCjd8uNJ4',
    duracion: 'Short',
    descripcion:
        'Aprende a tocar el acorde de SOL Mayor (G), con los dedos en los extremos del mástil.',
    aprenderas: [
      'Posición de los dedos para el acorde G',
      'Todas las cuerdas suenan',
      'Estiramiento de dedos en el diapasón',
      'Transición entre E y G'
    ],
    instructor: 'Sonaris Team',
    rolInstructor: 'Equipo de instructores de guitarra',
    esShort: true,
    acordeAsociado: 'G',
  )),
];

// ── Pantalla principal ────────────────────────────────────

class PantallaVideos extends StatefulWidget {
  final int modulo;
  const PantallaVideos({super.key, this.modulo = 1});
  @override
  State<PantallaVideos> createState() => _EstadoPantallaVideos();
}

class _EstadoPantallaVideos extends State<PantallaVideos>
    with SingleTickerProviderStateMixin {
  Set<String> _completados = {};
  late AnimationController _headerCtrl;
  late Animation<double> _headerFade;
  late Animation<Offset> _headerSlide;

  List<ItemModulo> get _items =>
      widget.modulo == 2 ? _itemsModulo2 : _itemsModulo1;

  @override
  void initState() {
    super.initState();
    _headerCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _headerFade = CurvedAnimation(parent: _headerCtrl, curve: Curves.easeOut);
    _headerSlide = Tween<Offset>(
      begin: const Offset(0, -0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _headerCtrl, curve: Curves.easeOut));
    _cargarProgreso();
    _headerCtrl.forward();
  }

  @override
  void dispose() {
    _headerCtrl.dispose();
    super.dispose();
  }

  Future<void> _cargarProgreso() async {
    final prefs = await SharedPreferences.getInstance();
    final lista = prefs.getStringList('videos_completados') ?? [];
    if (mounted) setState(() => _completados = lista.toSet());
  }

  Future<void> _marcarCompletado(String youtubeId) async {
    final prefs = await SharedPreferences.getInstance();
    _completados.add(youtubeId);
    await prefs.setStringList('videos_completados', _completados.toList());
    if (mounted) setState(() {});
  }

  bool _estaDesbloqueado(int indice) {
    if (indice == 0) return true;
    final videos = _items.where((i) => i.esVideo).toList();
    return _completados.contains(videos[indice - 1].video!.youtubeId);
  }

  @override
  Widget build(BuildContext context) {
    final videos = _items.where((i) => i.esVideo).toList();
    final totalVideos = videos.length;
    final completados = _completados.length.clamp(0, totalVideos);
    final progreso = totalVideos > 0 ? completados / totalVideos : 0.0;

    return DefaultTextStyle(
      style: const TextStyle(decoration: TextDecoration.none),
      child: Scaffold(
        backgroundColor: fondo,
        body: Column(children: [
          // ── Header mejorado con imagen de fondo ──
          FadeTransition(
            opacity: _headerFade,
            child: SlideTransition(
              position: _headerSlide,
              child: Stack(children: [
                Image.asset(
                  'assets/fondo.png',
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                Container(
                  height: 200,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0x88000000), Color(0xFF080808)],
                    ),
                  ),
                ),
                SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back_ios_new_rounded,
                              color: blanco, size: 18),
                        ),
                      ]),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: verde.withValues(alpha: 0.18),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: verde.withValues(alpha: 0.4)),
                              ),
                              child: Text(
                                'MÓDULO ${widget.modulo}',
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: verde,
                                  letterSpacing: 2,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              widget.modulo == 2
                                  ? 'Acordes básicos'
                                  : 'Fundamentos',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                color: blanco,
                                height: 1.1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
          // ── Barra de progreso ──
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  const Icon(Icons.play_circle_outline_rounded,
                      color: medio, size: 14),
                  const SizedBox(width: 6),
                  Text(
                    '$completados/$totalVideos completados',
                    style: const TextStyle(fontSize: 12, color: medio),
                  ),
                  const Spacer(),
                  Text(
                    '${(progreso * 100).round()}%',
                    style: const TextStyle(
                        fontSize: 12,
                        color: verde,
                        fontWeight: FontWeight.w600),
                  ),
                ]),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: progreso),
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.easeOutCubic,
                    builder: (_, value, __) => LinearProgressIndicator(
                      value: value,
                      minHeight: 5,
                      backgroundColor: tenue.withValues(alpha: 0.3),
                      valueColor: const AlwaysStoppedAnimation<Color>(verde),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // ── Lista de videos ──
          Expanded(
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
              itemCount: videos.length,
              separatorBuilder: (_, __) => const SizedBox(height: 14),
              itemBuilder: (_, i) {
                final video = videos[i].video!;
                final desbloqueado = _estaDesbloqueado(i);
                final completado = _completados.contains(video.youtubeId);
                final esUltimo = i == videos.length - 1;
                return _TarjetaVideo(
                  video: video,
                  desbloqueado: desbloqueado,
                  completado: completado,
                  indice: i,
                  alCompletar: () => _marcarCompletado(video.youtubeId),
                  alSiguiente: i < videos.length - 1
                      ? () {
                          final siguiente = videos[i + 1].video!;
                          if (_estaDesbloqueado(i + 1)) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PantallaDetalleVideo(
                                  video: siguiente,
                                  alCompletar: () =>
                                      _marcarCompletado(siguiente.youtubeId),
                                  alSiguiente: null,
                                  esUltimoDelModulo: i + 1 == videos.length - 1,
                                  modulo: widget.modulo,
                                ),
                              ),
                            );
                          }
                        }
                      : null,
                  esUltimoDelModulo: esUltimo,
                  modulo: widget.modulo,
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}

// ── Tarjeta del video con animaciones ────────────────────

class _TarjetaVideo extends StatefulWidget {
  final VideoModulo video;
  final bool desbloqueado;
  final bool completado;
  final int indice;
  final VoidCallback alCompletar;
  final VoidCallback? alSiguiente;
  final bool esUltimoDelModulo;
  final int modulo;

  const _TarjetaVideo({
    required this.video,
    required this.desbloqueado,
    required this.completado,
    required this.indice,
    required this.alCompletar,
    this.alSiguiente,
    this.esUltimoDelModulo = false,
    this.modulo = 1,
  });

  @override
  State<_TarjetaVideo> createState() => _EstadoTarjetaVideo();
}

class _EstadoTarjetaVideo extends State<_TarjetaVideo>
    with SingleTickerProviderStateMixin {
  late AnimationController _entradaCtrl;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;
  double _escala = 1.0;

  @override
  void initState() {
    super.initState();
    _entradaCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnim = CurvedAnimation(parent: _entradaCtrl, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.18),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _entradaCtrl, curve: Curves.easeOutCubic));

    // Staggered delay: index * 100ms
    Future.delayed(Duration(milliseconds: widget.indice * 100), () {
      if (mounted) _entradaCtrl.forward();
    });
  }

  @override
  void dispose() {
    _entradaCtrl.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails _) {
    if (!widget.desbloqueado) return;
    setState(() => _escala = 0.97);
  }

  void _onTapUp(TapUpDetails _) {
    if (!widget.desbloqueado) return;
    setState(() => _escala = 1.0);
  }

  void _onTapCancel() {
    setState(() => _escala = 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final thumb =
        'https://img.youtube.com/vi/${widget.video.youtubeId}/hqdefault.jpg';

    return FadeTransition(
      opacity: _fadeAnim,
      child: SlideTransition(
        position: _slideAnim,
        child: GestureDetector(
          onTapDown: _onTapDown,
          onTapUp: _onTapUp,
          onTapCancel: _onTapCancel,
          onTap: widget.desbloqueado
              ? () {
                  setState(() => _escala = 1.0);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PantallaDetalleVideo(
                        video: widget.video,
                        alCompletar: widget.alCompletar,
                        alSiguiente: widget.alSiguiente,
                        esUltimoDelModulo: widget.esUltimoDelModulo,
                        modulo: widget.modulo,
                      ),
                    ),
                  );
                }
              : null,
          child: AnimatedScale(
            scale: _escala,
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOutBack,
            child: AnimatedOpacity(
              opacity: widget.desbloqueado ? 1.0 : 0.55,
              duration: const Duration(milliseconds: 300),
              child: Container(
                decoration: BoxDecoration(
                  color: tarjeta,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: widget.completado
                        ? verde.withValues(alpha: 0.35)
                        : Colors.white.withValues(alpha: 0.06),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Thumbnail ──
                    Stack(children: [
                      Hero(
                        tag: 'video_thumb_${widget.video.youtubeId}',
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(20)),
                          child: ColorFiltered(
                            colorFilter: widget.desbloqueado
                                ? const ColorFilter.mode(
                                    Colors.transparent, BlendMode.saturation)
                                : const ColorFilter.matrix([
                                    0.2126,
                                    0.7152,
                                    0.0722,
                                    0,
                                    0,
                                    0.2126,
                                    0.7152,
                                    0.0722,
                                    0,
                                    0,
                                    0.2126,
                                    0.7152,
                                    0.0722,
                                    0,
                                    0,
                                    0,
                                    0,
                                    0,
                                    1,
                                    0,
                                  ]),
                            child: Image.network(
                              thumb,
                              width: double.infinity,
                              height: 190,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                height: 190,
                                color: tarjeta2,
                                child: const Center(
                                  child: Icon(Icons.play_circle_outline_rounded,
                                      color: medio, size: 48),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Gradiente inferior
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(20)),
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black.withValues(alpha: 0.7),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Icono central (play / lock / check)
                      Positioned.fill(
                        child: Center(
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: widget.desbloqueado
                                  ? verde.withValues(alpha: 0.95)
                                  : Colors.black.withValues(alpha: 0.65),
                              border: widget.desbloqueado
                                  ? null
                                  : Border.all(
                                      color:
                                          Colors.white.withValues(alpha: 0.25)),
                              boxShadow: widget.desbloqueado
                                  ? [
                                      BoxShadow(
                                        color: verde.withValues(alpha: 0.4),
                                        blurRadius: 20,
                                        spreadRadius: 2,
                                      )
                                    ]
                                  : [],
                            ),
                            child: Icon(
                              widget.desbloqueado
                                  ? (widget.completado
                                      ? Icons.check_rounded
                                      : Icons.play_arrow_rounded)
                                  : Icons.lock_rounded,
                              color: widget.desbloqueado ? fondo : blanco,
                              size: widget.desbloqueado ? 34 : 26,
                            ),
                          ),
                        ),
                      ),
                      // Overlay verde completado
                      if (widget.completado)
                        Positioned(
                          top: 10,
                          left: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: verde.withValues(alpha: 0.9),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.check_rounded,
                                    color: blanco, size: 11),
                                SizedBox(width: 4),
                                Text('Completado',
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: blanco,
                                        fontWeight: FontWeight.w700)),
                              ],
                            ),
                          ),
                        ),
                      // Badge "Short" con estilo pill morado
                      if (widget.video.esShort)
                        Positioned(
                          bottom: 10,
                          right: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: morado,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: morado.withValues(alpha: 0.5),
                                  blurRadius: 8,
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.bolt_rounded,
                                    color: blanco, size: 12),
                                SizedBox(width: 3),
                                Text('Short',
                                    style: TextStyle(
                                        fontSize: 11,
                                        color: blanco,
                                        fontWeight: FontWeight.w700)),
                              ],
                            ),
                          ),
                        )
                      else if (widget.video.duracion.isNotEmpty)
                        Positioned(
                          bottom: 10,
                          right: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.75),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(widget.video.duracion,
                                style: const TextStyle(
                                    fontSize: 11,
                                    color: blanco,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ),
                    ]),
                    // ── Info ──
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.video.subtitulo,
                            style: TextStyle(
                              fontSize: 10,
                              color: widget.desbloqueado ? verde : medio,
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            widget.video.titulo,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: widget.desbloqueado ? blanco : medio,
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(children: [
                            Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: verde.withValues(alpha: 0.12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: Image.asset('assets/logo_sonaris.png',
                                    fit: BoxFit.contain),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.video.instructor,
                                    style: const TextStyle(
                                        fontSize: 13,
                                        color: blanco,
                                        fontWeight: FontWeight.w500)),
                                Text(widget.video.rolInstructor,
                                    style: const TextStyle(
                                        fontSize: 11, color: medio)),
                              ],
                            ),
                          ]),
                        ],
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
}

// ── Pantalla de detalle ───────────────────────────────────

class PantallaDetalleVideo extends StatefulWidget {
  final VideoModulo video;
  final VoidCallback alCompletar;
  final VoidCallback? alSiguiente;
  final bool esUltimoDelModulo;
  final int modulo;

  const PantallaDetalleVideo({
    super.key,
    required this.video,
    required this.alCompletar,
    this.alSiguiente,
    this.esUltimoDelModulo = false,
    this.modulo = 1,
  });

  @override
  State<PantallaDetalleVideo> createState() => _EstadoPantallaDetalleVideo();
}

class _EstadoPantallaDetalleVideo extends State<PantallaDetalleVideo>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late List<Animation<double>> _fades;
  late List<Animation<Offset>> _slides;

  // Sections: 0=title, 1=instructor, 2=description, 3=aprenderas, 4=button
  static const int _secciones = 5;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fades = List.generate(_secciones, (i) {
      final start = i * 0.12;
      final end = (start + 0.4).clamp(0.0, 1.0);
      return Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _ctrl,
          curve: Interval(start, end, curve: Curves.easeOut),
        ),
      );
    });

    _slides = List.generate(_secciones, (i) {
      final start = i * 0.12;
      final end = (start + 0.4).clamp(0.0, 1.0);
      return Tween<Offset>(
        begin: const Offset(0, 0.15),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _ctrl,
          curve: Interval(start, end, curve: Curves.easeOutCubic),
        ),
      );
    });

    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Widget _animado(int index, Widget child) => FadeTransition(
        opacity: _fades[index],
        child: SlideTransition(position: _slides[index], child: child),
      );

  @override
  Widget build(BuildContext context) {
    final thumb =
        'https://img.youtube.com/vi/${widget.video.youtubeId}/hqdefault.jpg';

    return DefaultTextStyle(
      style: const TextStyle(decoration: TextDecoration.none),
      child: Scaffold(
        backgroundColor: fondo,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Hero thumbnail ──
              Stack(children: [
                Hero(
                  tag: 'video_thumb_${widget.video.youtubeId}',
                  child: Image.network(
                    thumb,
                    width: double.infinity,
                    height: 220,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        Container(height: 220, color: tarjeta2),
                  ),
                ),
                Container(
                  height: 220,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.55),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Row(children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back_ios_new_rounded,
                            color: blanco, size: 18),
                      ),
                    ]),
                  ),
                ),
              ]),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Sección 0: Título ──
                    _animado(
                      0,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            Text(widget.video.subtitulo,
                                style: const TextStyle(
                                    fontSize: 11,
                                    color: medio,
                                    letterSpacing: 1)),
                            const Spacer(),
                            if (widget.video.esShort)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: morado,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: morado.withValues(alpha: 0.45),
                                      blurRadius: 8,
                                    ),
                                  ],
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.bolt_rounded,
                                        color: blanco, size: 12),
                                    SizedBox(width: 3),
                                    Text('Short',
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: blanco,
                                            fontWeight: FontWeight.w700)),
                                  ],
                                ),
                              )
                            else if (widget.video.duracion.isNotEmpty) ...[
                              const Icon(Icons.access_time_rounded,
                                  color: medio, size: 13),
                              const SizedBox(width: 4),
                              Text(widget.video.duracion,
                                  style: const TextStyle(
                                      fontSize: 11, color: medio)),
                            ],
                          ]),
                          const SizedBox(height: 8),
                          Text(widget.video.titulo,
                              style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  color: blanco,
                                  height: 1.2)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // ── Sección 1: Instructor ──
                    _animado(
                      1,
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: tarjeta,
                          borderRadius: BorderRadius.circular(14),
                          border:
                              Border.all(color: verde.withValues(alpha: 0.2)),
                        ),
                        child: Row(children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: verde.withValues(alpha: 0.15),
                              border: Border.all(
                                  color: verde.withValues(alpha: 0.35)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: Image.asset('assets/logo_sonaris.png',
                                  fit: BoxFit.contain),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.video.instructor,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: blanco)),
                              Text(widget.video.rolInstructor,
                                  style: const TextStyle(
                                      fontSize: 11, color: verde)),
                            ],
                          ),
                        ]),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // ── Sección 2: Descripción ──
                    _animado(
                      2,
                      Text(widget.video.descripcion,
                          style: const TextStyle(
                              fontSize: 14, color: medio, height: 1.6)),
                    ),
                    const SizedBox(height: 20),
                    // ── Sección 3: Lo que aprenderás ──
                    _animado(
                      3,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Lo que aprenderás',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: blanco)),
                          const SizedBox(height: 12),
                          ...widget.video.aprenderas
                              .asMap()
                              .entries
                              .map((entry) => _ItemAprenderas(
                                    texto: entry.value,
                                    indice: entry.key,
                                  )),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // ── Sección 4: Botón reproducir ──
                    _animado(
                      4,
                      _BotonReproducir(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => _PantallaReproductor(
                              video: widget.video,
                              alCompletar: widget.alCompletar,
                              alSiguiente: widget.alSiguiente,
                              esUltimoDelModulo: widget.esUltimoDelModulo,
                              modulo: widget.modulo,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Item animado de "Lo que aprenderás" ──────────────────

class _ItemAprenderas extends StatefulWidget {
  final String texto;
  final int indice;
  const _ItemAprenderas({required this.texto, required this.indice});

  @override
  State<_ItemAprenderas> createState() => _EstadoItemAprenderas();
}

class _EstadoItemAprenderas extends State<_ItemAprenderas>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: const Offset(0.08, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));

    Future.delayed(Duration(milliseconds: 300 + widget.indice * 80), () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.check_circle_rounded, color: verde, size: 16),
              const SizedBox(width: 10),
              Expanded(
                child: Text(widget.texto,
                    style: const TextStyle(
                        fontSize: 13, color: blanco, height: 1.4)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Botón "Reproducir video" con glow morado ─────────────

class _BotonReproducir extends StatefulWidget {
  final VoidCallback onTap;
  const _BotonReproducir({required this.onTap});

  @override
  State<_BotonReproducir> createState() => _EstadoBotonReproducir();
}

class _EstadoBotonReproducir extends State<_BotonReproducir> {
  double _escala = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _escala = 0.97),
      onTapUp: (_) {
        setState(() => _escala = 1.0);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _escala = 1.0),
      child: AnimatedScale(
        scale: _escala,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOutBack,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: morado,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: morado.withValues(alpha: 0.45),
                blurRadius: 20,
                spreadRadius: 0,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.play_arrow_rounded, color: blanco, size: 22),
              SizedBox(width: 8),
              Text('Reproducir video',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: blanco)),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Reproductor ───────────────────────────────────────────

class _PantallaReproductor extends StatefulWidget {
  final VideoModulo video;
  final VoidCallback alCompletar;
  final VoidCallback? alSiguiente;
  final bool esUltimoDelModulo;
  final int modulo;
  const _PantallaReproductor({
    required this.video,
    required this.alCompletar,
    this.alSiguiente,
    this.esUltimoDelModulo = false,
    this.modulo = 1,
  });

  @override
  State<_PantallaReproductor> createState() => _EstadoReproductor();
}

class _EstadoReproductor extends State<_PantallaReproductor> {
  late YoutubePlayerController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = YoutubePlayerController(
      initialVideoId: widget.video.youtubeId,
      flags: const YoutubePlayerFlags(autoPlay: true, mute: false),
    );
    _ctrl.addListener(_escucharEstado);
  }

  void _escucharEstado() {
    if (_ctrl.value.playerState == PlayerState.ended) {
      widget.alCompletar();
      // Si el video tiene un acorde asociado, mostrar reto interactivo
      if (widget.video.acordeAsociado != null) {
        _mostrarRetoAcorde();
      } else if (widget.esUltimoDelModulo && widget.modulo == 1) {
        _mostrarModalAfinacion();
      }
    }
  }

  void _mostrarRetoAcorde() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      enableDrag: false,
      builder: (_) => RetoAcorde(
        acorde: widget.video.acordeAsociado!,
        alCompletar: () {
          // Si es el último del módulo 1, mostrar afinación
          if (widget.esUltimoDelModulo && widget.modulo == 1) {
            Future.delayed(const Duration(milliseconds: 300), () {
              if (mounted) _mostrarModalAfinacion();
            });
          }
        },
      ),
    );
  }

  void _mostrarModalAfinacion() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const _ModalAfinacion(),
    );
  }

  @override
  void dispose() {
    _ctrl.removeListener(_escucharEstado);
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.video.esShort) {
      return _ReproductorShort(
        ctrl: _ctrl,
        video: widget.video,
        alSiguiente: widget.alSiguiente,
        esUltimoDelModulo: widget.esUltimoDelModulo,
        modulo: widget.modulo,
      );
    }

    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _ctrl,
        showVideoProgressIndicator: true,
        progressIndicatorColor: verde,
      ),
      builder: (context, player) => Scaffold(
        backgroundColor: fondo,
        body: SafeArea(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 12, 20, 0),
              child: Row(children: [
                IconButton(
                  onPressed: () {
                    _ctrl.pause();
                    SystemChrome.setPreferredOrientations(
                        [DeviceOrientation.portraitUp]);
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_rounded,
                      color: medio, size: 18),
                ),
                Expanded(
                  child: Text(widget.video.titulo,
                      style: const TextStyle(
                          fontSize: 14,
                          color: blanco,
                          fontWeight: FontWeight.w300),
                      overflow: TextOverflow.ellipsis),
                ),
              ]),
            ),
            const SizedBox(height: 12),
            player,
          ]),
        ),
      ),
    );
  }
}

// ── Reproductor Short (formato vertical TikTok) ───────────

class _ReproductorShort extends StatefulWidget {
  final YoutubePlayerController ctrl;
  final VideoModulo video;
  final VoidCallback? alSiguiente;
  final bool esUltimoDelModulo;
  final int modulo;
  const _ReproductorShort({
    required this.ctrl,
    required this.video,
    this.alSiguiente,
    this.esUltimoDelModulo = false,
    this.modulo = 1,
  });

  @override
  State<_ReproductorShort> createState() => _EstadoReproductorShort();
}

class _EstadoReproductorShort extends State<_ReproductorShort> {
  bool _pausado = false;

  void _togglePausa() {
    setState(() => _pausado = !_pausado);
    if (_pausado) {
      widget.ctrl.pause();
    } else {
      widget.ctrl.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: widget.ctrl,
        showVideoProgressIndicator: true,
        progressIndicatorColor: verde,
        progressColors: const ProgressBarColors(
          playedColor: verde,
          handleColor: verde,
        ),
      ),
      builder: (context, player) => Scaffold(
        backgroundColor: Colors.black,
        body: Stack(fit: StackFit.expand, children: [
          // Video a pantalla completa vertical
          GestureDetector(
            onTap: _togglePausa,
            child: Center(
              child: AspectRatio(
                aspectRatio: 9 / 16,
                child: player,
              ),
            ),
          ),

          // Ícono de pausa central (aparece al pausar)
          if (_pausado)
            Center(
              child: Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.play_arrow_rounded,
                    color: Colors.white, size: 40),
              ),
            ),

          // Overlay superior con gradiente
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: IgnorePointer(
              child: Container(
                height: 120,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black, Colors.transparent],
                  ),
                ),
              ),
            ),
          ),

          // Overlay inferior con gradiente
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: IgnorePointer(
              child: Container(
                height: 220,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.black, Colors.transparent],
                  ),
                ),
              ),
            ),
          ),

          // Header
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Row(children: [
                GestureDetector(
                  onTap: () {
                    widget.ctrl.pause();
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.arrow_back_ios_new_rounded,
                        color: blanco, size: 16),
                  ),
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: verde,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(mainAxisSize: MainAxisSize.min, children: [
                    Icon(Icons.bolt_rounded, color: Colors.white, size: 14),
                    SizedBox(width: 4),
                    Text('Short',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600)),
                  ]),
                ),
              ]),
            ),
          ),

          // ── Botones de control: Pausar y Siguiente ──
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Info del video
                    Padding(
                      padding: const EdgeInsets.only(right: 60),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: verde.withValues(alpha: 0.2),
                                border: Border.all(
                                    color: verde.withValues(alpha: 0.5)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(3),
                                child: Image.asset('assets/logo_sonaris.png',
                                    fit: BoxFit.contain),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text('Sonaris Team',
                                style: TextStyle(
                                    color: blanco,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700)),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: verde,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text('Seguir',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700)),
                            ),
                          ]),
                          const SizedBox(height: 8),
                          Text(widget.video.titulo,
                              style: const TextStyle(
                                color: blanco,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                height: 1.3,
                              )),
                          const SizedBox(height: 4),
                          Text(widget.video.subtitulo,
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.6),
                                fontSize: 12,
                              )),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Botones de acción
                    Row(children: [
                      // Botón Pausar/Reanudar
                      Expanded(
                        child: GestureDetector(
                          onTap: _togglePausa,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.1)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  _pausado
                                      ? Icons.play_arrow_rounded
                                      : Icons.pause_rounded,
                                  color: blanco,
                                  size: 20,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  _pausado ? 'Reanudar' : 'Pausar',
                                  style: const TextStyle(
                                    color: blanco,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Botón Siguiente
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            widget.ctrl.pause();
                            if (widget.alSiguiente != null) {
                              Navigator.pop(context);
                              widget.alSiguiente!();
                            } else {
                              Navigator.pop(context);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            decoration: BoxDecoration(
                              color: verde,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Siguiente',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Icon(Icons.skip_next_rounded,
                                    color: Colors.white, size: 20),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
            ),
          ),

          // Botones laterales tipo TikTok
          Positioned(
            right: 12,
            bottom: 180,
            child: SafeArea(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                _BotonLateral(icono: Icons.favorite_rounded, label: 'Me gusta'),
                const SizedBox(height: 20),
                _BotonLateral(icono: Icons.share_rounded, label: 'Compartir'),
                const SizedBox(height: 20),
                _BotonLateral(icono: Icons.bookmark_rounded, label: 'Guardar'),
              ]),
            ),
          ),
        ]),
      ),
    );
  }
}

class _BotonLateral extends StatelessWidget {
  final IconData icono;
  final String label;
  const _BotonLateral({required this.icono, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.15),
          shape: BoxShape.circle,
        ),
        child: Icon(icono, color: blanco, size: 24),
      ),
      const SizedBox(height: 4),
      Text(label,
          style: TextStyle(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 11,
              fontWeight: FontWeight.w500)),
    ]);
  }
}

// ── Modal de Afinación de Guitarra ────────────────────────
// Se muestra al completar el Módulo 1

class _ModalAfinacion extends StatefulWidget {
  const _ModalAfinacion();

  @override
  State<_ModalAfinacion> createState() => _EstadoModalAfinacion();
}

class _EstadoModalAfinacion extends State<_ModalAfinacion>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  int _cuerdaActiva = -1;

  static const _cuerdas = [
    _CuerdaInfo(nombre: 'E', nota: 'Mi grave', numero: 6, hz: '82 Hz'),
    _CuerdaInfo(nombre: 'A', nota: 'La', numero: 5, hz: '110 Hz'),
    _CuerdaInfo(nombre: 'D', nota: 'Re', numero: 4, hz: '147 Hz'),
    _CuerdaInfo(nombre: 'G', nota: 'Sol', numero: 3, hz: '196 Hz'),
    _CuerdaInfo(nombre: 'B', nota: 'Si', numero: 2, hz: '247 Hz'),
    _CuerdaInfo(nombre: 'e', nota: 'Mi agudo', numero: 1, hz: '330 Hz'),
  ];

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, child) {
        final slide = Tween<Offset>(
          begin: const Offset(0, 0.3),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));

        return SlideTransition(
          position: slide,
          child: FadeTransition(
            opacity: CurvedAnimation(parent: _ctrl, curve: Curves.easeOut),
            child: child,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(top: 80),
        decoration: const BoxDecoration(
          color: Color(0xFF121212),
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
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
            const SizedBox(height: 24),

            // Header con celebración
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    verde.withValues(alpha: 0.12),
                    verde.withValues(alpha: 0.04),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: verde.withValues(alpha: 0.2)),
              ),
              child: Column(children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: verde.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.celebration_rounded,
                      color: verde, size: 28),
                ),
                const SizedBox(height: 14),
                const Text(
                  '¡Módulo 1 completado!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: blanco,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Antes de continuar, asegúrate de que tu guitarra esté afinada correctamente.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withValues(alpha: 0.6),
                    height: 1.4,
                  ),
                ),
              ]),
            ),
            const SizedBox(height: 24),

            // Título sección cuerdas
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Row(children: [
                Icon(Icons.music_note_rounded, color: verde, size: 18),
                SizedBox(width: 8),
                Text(
                  'Afinación estándar',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: blanco,
                  ),
                ),
                Spacer(),
                Text(
                  'E A D G B e',
                  style: TextStyle(
                    fontSize: 13,
                    color: verde,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2,
                  ),
                ),
              ]),
            ),
            const SizedBox(height: 16),

            // Cuerdas interactivas
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: List.generate(_cuerdas.length, (i) {
                  final cuerda = _cuerdas[i];
                  final activa = _cuerdaActiva == i;
                  return GestureDetector(
                    onTap: () => setState(() =>
                        _cuerdaActiva = _cuerdaActiva == i ? -1 : i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: activa
                            ? verde.withValues(alpha: 0.1)
                            : const Color(0xFF1A1A1A),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: activa
                              ? verde.withValues(alpha: 0.4)
                              : Colors.white.withValues(alpha: 0.06),
                        ),
                      ),
                      child: Row(children: [
                        // Número de cuerda
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: activa
                                ? verde.withValues(alpha: 0.2)
                                : Colors.white.withValues(alpha: 0.06),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '${cuerda.numero}',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: activa ? verde : medio,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        // Nombre de la nota
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cuerda.nombre,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: activa ? verde : blanco,
                                ),
                              ),
                              Text(
                                cuerda.nota,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white.withValues(alpha: 0.5),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Frecuencia
                        Text(
                          cuerda.hz,
                          style: TextStyle(
                            fontSize: 13,
                            color: activa
                                ? verde
                                : Colors.white.withValues(alpha: 0.4),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 10),
                        // Indicador visual de cuerda
                        Container(
                          width: 40,
                          height: 3,
                          decoration: BoxDecoration(
                            color: activa
                                ? verde
                                : Colors.white.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ]),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 20),

            // Tip
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.lightbulb_outline_rounded,
                      color: ambar, size: 18),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Usa un afinador digital o la app GuitarTuna para verificar cada cuerda. Gira las clavijas lentamente.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white.withValues(alpha: 0.6),
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Botón continuar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: verde,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text(
                    'Listo, continuar',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom + 24),
          ],
        ),
      ),
    );
  }
}

class _CuerdaInfo {
  final String nombre;
  final String nota;
  final int numero;
  final String hz;
  const _CuerdaInfo({
    required this.nombre,
    required this.nota,
    required this.numero,
    required this.hz,
  });
}
