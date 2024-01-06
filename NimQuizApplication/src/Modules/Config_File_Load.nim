import std/[paths, files, parsecfg, strutils]

type
  AppConfig* = tuple
    WindowSizeList : seq[string]
    WindowSize : string
    FontType : string
    FontSize : string
    BGMVolume : string
    SEVolume : string
    BackgroundImage : string
    ButtonImage : string
    TitleImage : string
    LabelImage : string

var
  dict*: Config
  app_config*: AppConfig

  dirHome*: Path
  pathImagesFolder*: Path

  pathDataFolder*: Path
  pathDataBaseFile*: Path

  pathConfigFile*: Path

dirHome = getCurrentDir()
echo("Current Path")
echo(string(dirHome))

pathImagesFolder = Path("Images/")

pathDataFolder = Path("Data/")
pathDataBaseFile = pathDataFolder/Path("QUIZ_DATABASE.db")

pathConfigFile = Path("config.ini")
echo("Config File Exist: " & $fileExists(pathConfigFile))

proc ConfigLoading*() =
  if fileExists(pathConfigFile) == false:
    echo("Create Config File in: " & string(pathConfigFile))
    dict = newConfig()

    dict.setSectionKey("UI", "WindowSizeList", "1280x720,1280x960,1440x900,1280x1024,1400x1050,1440x1080,1600x1024,1680x1050,1600x1200,1920x1080,1920x1200,2048x1152,2048x1536,2560x1440,2560x1600,2880x1800,3200x1800,3200x2400,3840x2160")
    dict.setSectionKey("UI", "WindowSize", "1280x720")
    dict.setSectionKey("UI", "FontType", "UDEV Gothic")
    dict.setSectionKey("UI", "FontSize", "1.0")

    dict.setSectionKey("Sound", "BGMVolume", "50")
    dict.setSectionKey("Sound", "SEVolume", "50")

    dict.setSectionKey("Images", "BackgroundImage", "background.png")
    dict.setSectionKey("Images", "ButtonImage", "button.png")
    dict.setSectionKey("Images", "TitleImage", "title.png")
    dict.setSectionKey("Images", "LabelImage", "label.png")

    dict.writeConfig(string(pathConfigFile))

  echo("Load Config File in: " & string(pathConfigFile))

  dict = nil
  dict = loadConfig(string(pathConfigFile))
  echo($dict)

  app_config.WindowSizeList = split(dict.getSectionValue("UI", "WindowSizeList"), ",")
  app_config.WindowSize = dict.getSectionValue("UI", "WindowSize")
  app_config.FontType = dict.getSectionValue("UI", "FontType")
  app_config.FontSize = dict.getSectionValue("UI", "FontSize")

  app_config.BGMVolume = dict.getSectionValue("Sound", "BGMVolume")
  app_config.SEVolume = dict.getSectionValue("Sound", "SEVolume")

  app_config.BackgroundImage = dict.getSectionValue("Images", "BackgroundImage")
  app_config.ButtonImage = dict.getSectionValue("Images", "ButtonImage")
  app_config.TitleImage = dict.getSectionValue("Images", "TitleImage")
  app_config.LabelImage = dict.getSectionValue("Images", "LabelImage")
  
  echo("Loaded Config File: " & $app_config)

proc ConfigSaving*() =
  echo("Config Saving")
  dict.setSectionKey("UI", "WindowSize", app_config.WindowSize)
  dict.setSectionKey("UI", "FontType", app_config.FontType)
  dict.setSectionKey("UI", "FontSize", app_config.FontSize)

  dict.setSectionKey("Sound", "BGMVolume", app_config.BGMVolume)
  dict.setSectionKey("Sound", "SEVolume", app_config.SEVolume)

  dict.setSectionKey("Images", "BackgroundImage", app_config.BackgroundImage)
  dict.setSectionKey("Images", "ButtonImage", app_config.ButtonImage)
  dict.setSectionKey("Images", "TitleImage", app_config.TitleImage)
  dict.setSectionKey("Images", "LabelImage", app_config.LabelImage)

  dict.writeConfig(string(pathConfigFile))
