# DevDeck

**Every card unlocks a new tool.**

DevDeck es una aplicación móvil desarrollada en Flutter que reúne siete herramientas independientes bajo una misma identidad visual: un mazo de cartas con tema oscuro, diseño minimalista y animaciones propias del framework, sin motores gráficos externos.

---

## Descripción

DevDeck presenta siete herramientas como cartas de un mazo: Identity, Timeline, Academy, Forecast, Pokédex, Newsroom y Contact. Cada carta abre una pantalla que consume una API pública distinta, con un diseño oscuro y minimalista basado en Material Design 3.

---

## Tecnologías

- **Flutter** / **Dart**
- **Material Design 3** (tema oscuro)
- **Provider** — manejo de estado
- **http** — consumo de APIs REST
- **google_fonts** — tipografía Inter
- **url_launcher** — enlaces externos, correo (`mailto:`) y teléfono (`tel:`)
- **audioplayers** — reproducción del cry oficial de Pokémon
- **intl** — formateo de fechas

---

## APIs utilizadas

| Herramienta | API | Descripción |
|---|---|---|
| Identity | [genderize.io](https://api.genderize.io/) | Predicción de género a partir de un nombre |
| Timeline | [agify.io](https://api.agify.io/) | Predicción de edad a partir de un nombre |
| Academy | adamix.net (proxy) | Búsqueda de universidades por país |
| Forecast | [Open-Meteo](https://open-meteo.com/) | Clima actual en República Dominicana |
| Pokédex | [PokeAPI](https://pokeapi.co/) | Información y sonido oficial de Pokémon |
| Newsroom | WordPress REST API ([steamdeckhq.com](https://steamdeckhq.com)) | Últimas 3 noticias del sitio |

---

## Instalación

### Requisitos previos
- Flutter SDK instalado (`>=3.3.0`)
- Un editor compatible (Android Studio, VS Code)
- Un emulador o dispositivo Android conectado

### Pasos

```bash
git clone <url-del-repositorio>
cd devdeck
flutter pub get
flutter run
```

### Generar APK de producción

```bash
flutter build apk --release
```

El archivo resultante estará en:
```
build/app/outputs/flutter-apk/app-release.apk
```

---

## Estructura del proyecto

```
lib/
├── core/
│   ├── constants/       # Colores, textos, dimensiones, endpoints, assets
│   ├── theme/           # ThemeData global (Material 3, modo oscuro)
│   ├── network/         # Cliente HTTP centralizado
│   ├── enums/           # ViewState (Loading/Success/Error/Empty)
│   └── utils/           # Formateo de fechas, validadores
├── models/              # Modelos tipados de cada API
├── services/             # Consumo de APIs (uno por herramienta)
├── providers/            # Manejo de estado (ChangeNotifier)
├── animations/           # Animación de la carta y transiciones de página
├── widgets/               # Componentes reutilizables (AppBar, Card, botones, estados)
├── screens/               # Las 8 pantallas de la app
├── routes/                # Tabla de rutas nombradas
└── main.dart              # Punto de entrada
```

---

## Créditos

**Desarrollado por:** Sebastian Pilier Mercedes
**Matrícula:** 2024-0132
**Institución:** Instituto Tecnológico de las Américas (ITLA)

- GitHub: [github.com/CBAST-and](https://github.com/CBAST-and/)
- LinkedIn: [Sebastian Pilier Mercedes](https://www.linkedin.com/in/sebastian-pilier-mercedes-3827a23aa)
- Correo: 20240132@itla.edu.do