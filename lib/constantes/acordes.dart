/// Datos de los acordes soportados por el modelo MLP

const List<String> acordesBasicos = [
  'A', 'A7', 'Am', 'C', 'D', 'D7', 'Dm', 'E', 'Em', 'G'
];

const List<String> acordesIntermedios = [
  'Am7', 'B7', 'Bm', 'C7', 'Cadd9', 'Dm7', 'Em7', 'F', 'Fm', 'G7'
];

const List<String> acordes = [...acordesBasicos, ...acordesIntermedios];

const Map<String, String> nivelAcorde = {
  // Básicos
  'A': 'básico',
  'A7': 'básico',
  'Am': 'básico',
  'C': 'básico',
  'D': 'básico',
  'D7': 'básico',
  'Dm': 'básico',
  'E': 'básico',
  'Em': 'básico',
  'G': 'básico',
  // Intermedios
  'Am7': 'intermedio',
  'B7': 'intermedio',
  'Bm': 'intermedio',
  'C7': 'intermedio',
  'Cadd9': 'intermedio',
  'Dm7': 'intermedio',
  'Em7': 'intermedio',
  'F': 'intermedio',
  'Fm': 'intermedio',
  'G7': 'intermedio',
};

const Map<String, List<String>> acordesPorNivel = {
  'básico': ['A', 'A7', 'Am', 'C', 'D', 'D7', 'Dm', 'E', 'Em', 'G'],
  'intermedio': ['Am7', 'B7', 'Bm', 'C7', 'Cadd9', 'Dm7', 'Em7', 'F', 'Fm', 'G7'],
};

const Map<String, String> nombreAcorde = {
  'A': 'LA Mayor',
  'A7': 'LA Séptima',
  'Am': 'LA Menor',
  'Am7': 'LA Menor 7ma',
  'B7': 'SI Séptima',
  'Bm': 'SI Menor',
  'C': 'DO Mayor',
  'C7': 'DO Séptima',
  'Cadd9': 'DO Add9',
  'D': 'RE Mayor',
  'D7': 'RE Séptima',
  'Dm': 'RE Menor',
  'Dm7': 'RE Menor 7ma',
  'E': 'MI Mayor',
  'Em': 'MI Menor',
  'Em7': 'MI Menor 7ma',
  'F': 'FA Mayor',
  'Fm': 'FA Menor',
  'G': 'SOL Mayor',
  'G7': 'SOL Séptima',
};

const Map<String, List<String>> notasAcorde = {
  'A': ['A', 'C#', 'E'],
  'A7': ['A', 'C#', 'E', 'G'],
  'Am': ['A', 'C', 'E'],
  'Am7': ['A', 'C', 'E', 'G'],
  'B7': ['B', 'D#', 'F#', 'A'],
  'Bm': ['B', 'D', 'F#'],
  'C': ['C', 'E', 'G'],
  'C7': ['C', 'E', 'G', 'Bb'],
  'Cadd9': ['C', 'E', 'G', 'D'],
  'D': ['D', 'F#', 'A'],
  'D7': ['D', 'F#', 'A', 'C'],
  'Dm': ['D', 'F', 'A'],
  'Dm7': ['D', 'F', 'A', 'C'],
  'E': ['E', 'G#', 'B'],
  'Em': ['E', 'G', 'B'],
  'Em7': ['E', 'G', 'B', 'D'],
  'F': ['F', 'A', 'C'],
  'Fm': ['F', 'Ab', 'C'],
  'G': ['G', 'B', 'D'],
  'G7': ['G', 'B', 'D', 'F'],
};

const Map<String, String> descripcionAcorde = {
  'A': 'Tres dedos en el segundo traste, cuerdas D-G-B. Acorde abierto fácil.',
  'A7': 'Como A Mayor pero sin el dedo del traste 2 en la cuerda G. Sonido bluesy.',
  'Am': 'Similar a A pero el dedo índice va en el primer traste de la cuerda B.',
  'Am7': 'Como Am pero sin el dedo en la cuerda G. Sonido suave y melancólico.',
  'B7': 'Acorde abierto con 4 dedos. Muy usado en blues y rock.',
  'Bm': 'Cejilla en traste 2. Versión menor del acorde B.',
  'C': 'Forma diagonal: dedo 3 en A traste 3, dedo 2 en D traste 2, dedo 1 en B traste 1.',
  'C7': 'Como C Mayor pero agrega el meñique en el traste 3 de la cuerda G.',
  'Cadd9': 'Como C Mayor pero agrega el dedo meñique en el traste 3 de la cuerda e.',
  'D': 'Solo se tocan 4 cuerdas (D-G-B-e). Forma de triángulo en trastes 2-3.',
  'D7': 'Como D Mayor pero agrega el dedo índice en el traste 1 de la cuerda B.',
  'Dm': 'Como D Mayor pero el dedo índice baja al traste 1 en la cuerda e.',
  'Dm7': 'Como Dm pero agrega el dedo índice en el traste 1 de la cuerda e.',
  'E': 'Dos dedos en A y D traste 2, uno en G traste 1. Todas las cuerdas suenan.',
  'Em': 'Solo dos dedos en A y D traste 2. El acorde más fácil de la guitarra.',
  'Em7': 'Como Em pero sin el dedo en la cuerda A. Muy fácil y versátil.',
  'F': 'Cejilla completa en traste 1. El reto clásico del principiante.',
  'Fm': 'Cejilla en traste 1 con forma de Em. Sonido oscuro y dramático.',
  'G': 'Tres dedos en los extremos del mástil. Todas las cuerdas suenan.',
  'G7': 'Como G Mayor pero el meñique baja al traste 1 de la cuerda e.',
};

const Map<String, String> sampleAcorde = {
  'A': 'A-07-LAZARUS.wav',
  'Am': 'Am-08-LAZARUS.wav',
  'C': 'C-05-AT2020.wav',
  'D': 'D-01-LAZARUS.wav',
  'F': 'F-07-LAZARUS.wav',
};

// ── Diagrama de traste ────────────────────────────────────

class Punto {
  final int cuerda;
  final int traste;
  final int dedo;
  const Punto(this.cuerda, this.traste, this.dedo);
}

class DiagramaAcorde {
  final int trasteInicio;
  final List<Punto> puntos;
  final List<int> cuerdaAlAire;
  final List<int> cuerdaSilencio;
  final bool tieneCejilla;
  final int trastesCejilla;
  final int cejillaDesde;
  final int cejillaHasta;

  const DiagramaAcorde({
    this.trasteInicio = 1,
    required this.puntos,
    this.cuerdaAlAire = const [],
    this.cuerdaSilencio = const [],
    this.tieneCejilla = false,
    this.trastesCejilla = 0,
    this.cejillaDesde = 0,
    this.cejillaHasta = 5,
  });
}

const Map<String, DiagramaAcorde> diagramas = {
  // ── Básicos ───────────────────────────────────────────
  'A': DiagramaAcorde(
    trasteInicio: 1,
    puntos: [Punto(2, 2, 1), Punto(3, 2, 2), Punto(4, 2, 3)],
    cuerdaAlAire: [1, 5],
    cuerdaSilencio: [0],
  ),
  'A7': DiagramaAcorde(
    trasteInicio: 1,
    puntos: [Punto(2, 2, 1), Punto(4, 2, 2)],
    cuerdaAlAire: [1, 3, 5],
    cuerdaSilencio: [0],
  ),
  'Am': DiagramaAcorde(
    trasteInicio: 1,
    puntos: [Punto(2, 2, 2), Punto(3, 2, 3), Punto(4, 1, 1)],
    cuerdaAlAire: [1, 5],
    cuerdaSilencio: [0],
  ),
  'C': DiagramaAcorde(
    trasteInicio: 1,
    puntos: [Punto(1, 3, 3), Punto(2, 2, 2), Punto(4, 1, 1)],
    cuerdaAlAire: [3, 5],
    cuerdaSilencio: [0],
  ),
  'D': DiagramaAcorde(
    trasteInicio: 1,
    puntos: [Punto(3, 2, 1), Punto(4, 3, 3), Punto(5, 2, 2)],
    cuerdaAlAire: [2],
    cuerdaSilencio: [0, 1],
  ),
  'D7': DiagramaAcorde(
    trasteInicio: 1,
    puntos: [Punto(3, 2, 1), Punto(4, 1, 2), Punto(5, 2, 3)],
    cuerdaAlAire: [2],
    cuerdaSilencio: [0, 1],
  ),
  'Dm': DiagramaAcorde(
    trasteInicio: 1,
    puntos: [Punto(3, 2, 2), Punto(4, 3, 3), Punto(5, 1, 1)],
    cuerdaAlAire: [2],
    cuerdaSilencio: [0, 1],
  ),
  'E': DiagramaAcorde(
    trasteInicio: 1,
    puntos: [Punto(1, 2, 3), Punto(2, 2, 2), Punto(3, 1, 1)],
    cuerdaAlAire: [0, 4, 5],
  ),
  'Em': DiagramaAcorde(
    trasteInicio: 1,
    puntos: [Punto(1, 2, 1), Punto(2, 2, 2)],
    cuerdaAlAire: [0, 3, 4, 5],
  ),
  'G': DiagramaAcorde(
    trasteInicio: 1,
    puntos: [Punto(0, 3, 2), Punto(1, 2, 1), Punto(5, 3, 3)],
    cuerdaAlAire: [2, 3, 4],
  ),
  // ── Intermedios ───────────────────────────────────────
  'Am7': DiagramaAcorde(
    trasteInicio: 1,
    puntos: [Punto(2, 2, 2), Punto(3, 2, 3)],
    cuerdaAlAire: [1, 4, 5],
    cuerdaSilencio: [0],
  ),
  'B7': DiagramaAcorde(
    trasteInicio: 1,
    puntos: [Punto(1, 2, 1), Punto(2, 4, 4), Punto(3, 3, 3), Punto(4, 2, 2)],
    cuerdaAlAire: [5],
    cuerdaSilencio: [0],
  ),
  'Bm': DiagramaAcorde(
    trasteInicio: 2,
    puntos: [Punto(1, 3, 3), Punto(2, 3, 4), Punto(3, 2, 2)],
    cuerdaSilencio: [0],
    tieneCejilla: true,
    trastesCejilla: 1,
    cejillaDesde: 1,
    cejillaHasta: 5,
  ),
  'C7': DiagramaAcorde(
    trasteInicio: 1,
    puntos: [Punto(1, 3, 3), Punto(2, 2, 2), Punto(3, 3, 4), Punto(4, 1, 1)],
    cuerdaAlAire: [5],
    cuerdaSilencio: [0],
  ),
  'Cadd9': DiagramaAcorde(
    trasteInicio: 1,
    puntos: [Punto(1, 3, 3), Punto(2, 2, 2), Punto(4, 1, 1), Punto(5, 3, 4)],
    cuerdaAlAire: [3],
    cuerdaSilencio: [0],
  ),
  'Dm7': DiagramaAcorde(
    trasteInicio: 1,
    puntos: [Punto(3, 2, 2), Punto(4, 1, 1), Punto(5, 1, 1)],
    cuerdaAlAire: [2],
    cuerdaSilencio: [0, 1],
  ),
  'Em7': DiagramaAcorde(
    trasteInicio: 1,
    puntos: [Punto(1, 2, 1)],
    cuerdaAlAire: [0, 2, 3, 4, 5],
  ),
  'F': DiagramaAcorde(
    trasteInicio: 1,
    puntos: [Punto(1, 3, 3), Punto(2, 3, 4), Punto(3, 2, 2)],
    tieneCejilla: true,
    trastesCejilla: 1,
    cejillaDesde: 0,
    cejillaHasta: 5,
  ),
  'Fm': DiagramaAcorde(
    trasteInicio: 1,
    puntos: [Punto(1, 3, 3), Punto(2, 3, 4)],
    tieneCejilla: true,
    trastesCejilla: 1,
    cejillaDesde: 0,
    cejillaHasta: 5,
  ),
  'G7': DiagramaAcorde(
    trasteInicio: 1,
    puntos: [Punto(0, 3, 3), Punto(1, 1, 1), Punto(5, 2, 2)],
    cuerdaAlAire: [2, 3, 4],
  ),
};
