# AudioBridge

Гонит звук с ПК (что именно играет сейчас) на телефон по USB-кабелю.

```
ПК ──(WASAPI loopback)──▶ TCP :8228 ──(adb reverse, USB)──▶ телефон (динамики/наушники)
```

[Лицензия](LICENSE) — MIT.

## Структура

```
AudioBridge/
├─ apk/audioBridge.apk      готовое приложение для телефона
├─ pc/                      готовая программа для ПК (портативная, ничего ставить не нужно)
│  ├─ AudioBridge.exe       сама программа (внутри всё, включая .NET)
│  ├─ install-app.bat       установка APK на телефон (один клик)
│  └─ platform-tools/       adb уже внутри — отдельно ставить не надо
└─ source/                  исходники (pc + android) для тех, кто хочет собирать сам
```

## Как пользоваться (1 минута)

1. Подключи телефон по USB. Включи **USB-отладку** (Параметры → Для разработчиков).
2. Запусти `pc\AudioBridge.exe`.
3. Нажми **«▶ Старт»**.

Программа сама: сделает `adb reverse`, и если приложения на телефоне нет — **установит его с ПК автоматически**.
Останется один раз открыть на телефоне приложение **AudioBridge** и нажать «Старт» — и звук уже слышно на телефоне.

Если автоматическая установка не вышла (телефон не увидел ПК по adb) — двойной клик по `pc\install-app.bat`.

### Советы

- **Источник звука.** По умолчанию — системный звук (что играет в Windows). Куда удобнее: вывести ПК-звук в
  «CABLE Input» (Virtual Audio Cable), а в AudioBridge выбрать «CABLE In 16ch» — телефон работает как
  «виртуальные наушники для компьютера».
- **Тест-тон 440 Гц** — вместо звука ПК шлётся синус, удобно проверять канал.
- **⟳ adb reverse** — повторяет подключение, если перетыкали кабель.
- Громкость регулируется на телефоне.

## Замечания

- Задержка: ~50–100 мс по USB.
- Качество: стерео 48 кГц 16 бит.
- adb внутри не требует ни установки, ни прав администратора.

## Сборка из исходников

**ПК** (`source\pc`):
```
dotnet build AudioBridge.csproj -c Release
dotnet publish AudioBridge.csproj -c Release -r win-x64 --self-contained true /p:PublishSingleFile=true /p:EnableCompressionInSingleFile=true /p:IncludeNativeLibrariesForSelfExtract=true -o dist
```

**Android** (`source\android`): нужны JDK 17, Android SDK, Gradle 8.5. Проще всего — `source\build-apk.ps1`
(создаст всё на `E:\`, соберёт `apk\audioBridge.apk`). Либо открой `source\android` в Android Studio и собери как обычно.