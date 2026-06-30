# SELVA · La Travesía — APK

Juego en un solo archivo (`www/index.html`) empaquetado con Capacitor.
El APK firmado se compila en GitHub Actions (no necesitas Android Studio ni compilar en tu PC).

- **appId:** `com.joseluengo.selva`
- **Nombre:** SELVA

Para cambiar el id o el nombre, edita `capacitor.config.json`.

---

## Pasos

### 1. Sube esto a un repo de GitHub
Crea un repo (p. ej. `selva`), rama `main`, y sube todos estos archivos con GitHub Desktop.
No subas `node_modules/` ni `android/` (ya están en `.gitignore`); Actions los genera solos.

### 2. Convierte tu keystore a base64
Reutiliza tu keystore de siempre. En **PowerShell** (Windows):

```powershell
[Convert]::ToBase64String([IO.File]::ReadAllBytes("C:\ruta\a\tu\keystore.jks")) | Set-Clipboard
```

Eso copia el base64 al portapapeles (lo pegarás en el secret del paso 3).

### 3. Crea los 4 secrets en el repo
En GitHub: **Settings → Secrets and variables → Actions → New repository secret**:

| Secret | Valor |
|---|---|
| `KEYSTORE_BASE64` | el base64 del paso 2 |
| `KEYSTORE_PASSWORD` | la contraseña del keystore |
| `KEY_ALIAS` | el alias de la clave |
| `KEY_PASSWORD` | la contraseña del alias |

### 4. Compila
El workflow se lanza solo al hacer push a `main`. También puedes lanzarlo a mano en
**Actions → Build APK → Run workflow**.

### 5. Descarga el APK
Cuando termine (✓ verde), entra al run y baja el artifact **`selva-apk`**.
Descomprímelo, copia el `.apk` a tu Samsung e instálalo.

---

## Notas

- El sonido arranca con el primer toque en pantalla (norma de los navegadores/WebView).
- Si lo quieres **a pantalla completa y en horizontal**, dilo y te añado la configuración
  (orientación `landscape` + modo inmersivo) al proyecto Android.
- Para subirlo a Google Play en vez de instalarlo a mano, cambia `assembleRelease` por
  `bundleRelease` en el workflow y sube el `.aab` resultante.
