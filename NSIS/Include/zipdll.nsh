;ZipDLL include file for NSIS
;Written by Tim Kosse (mailto:tim.kosse@gmx.de)
;some improvements by deguix

;Supported languages with their translators in alphabetical order:

;Arabic translation by asdfuae
;Brazilian Portuguese translation by "deguix"
;Chinese, Simplified translation by Kii Ali <kiiali@cpatch.org>
;Chinese, Traditional traslation by "matini" and Kii Ali <kiiali@cpatch.org>
;Croatian translation by "iostriz"
;Danish translation by Claus Futtrup
;French translation by "veekee"
;German translation by Tim Kosse
;Hungarian translation by Toth Laszlo
;Korean translation by Seongab Kim
;Lithuanian translation by Vytautas Krivickas
;Polish translation by Krzysztof Galuszka
;Russion translation by Sergey
;Spanish translation by "dark_boy"

!ifndef ZIPDLL_USED

!define ZIPDLL_USED

!macro ZIPDLL_EXTRACT SOURCE DESTINATION FILE

  !define "FILE_${FILE}"

  !ifndef FILE_<ALL>
    Push "${FILE}"
  !endif

  IfFileExists "${DESTINATION}" +2
    CreateDirectory "${DESTINATION}"

  Push "${DESTINATION}"

  IfFileExists "${SOURCE}" +2
    SetErrors

  Push "${SOURCE}"

  ;The strings that will be translated are (ready to copy,
  ;remove leading semicolons in your language block):

  !ifdef LANG_ENGLISH

    ;English is default language of ZipDLL, no need to push the untranslated strings

    ;StrCmp $LANGUAGE ${LANG_ENGLISH} 0 +1

      ;Push "  Error: %s"
      ;Push "Could not get file attributes."
      ;Push "Error: Could not get file attributes."
      ;Push "Could not extract %s"
      ;Push "  Error: Could not extract %s"

      ;!ifdef FILE_<ALL>
        ;Push "  Extract: %s"
        ;Push "  Extracting %d files and directories"
        ;Push "Extracting contents of %s to %s"
      ;!else
        ;Push "Specified file does not exist in archive."
        ;Push "Error: Specified file does not exist in archive."
        ;Push "Extracting the file %s from %s to %s"
      ;!endif

      ;Push "/TRANSLATE"

  !endif

  !ifdef LANG_HUNGARIAN

    StrCmp $LANGUAGE ${LANG_HUNGARIAN} 0 +10

      Push "  Hiba: %s"
      Push "Nem olvashat?a f醞l attrib鷗umai."
      Push "Hiba: Nem olvashat?a f醞l attrib鷗umai."
      Push "Nem siker黮t kicsomagolni a(z) %s"
      Push "  Hiba: Nem siker黮t kicsomagolni a(z) %s"

      !ifdef FILE_<ALL>
        Push "  Kicsomagol醩: %s"
        Push "  %d f醞l 閟 mappa kicsomagol醩a"
        Push "%s tartalom kicsomagol醩a a %s helyre"
      !else
        Push "A megadott f醞l nem tal醠hat?az arh韛umban."
        Push "Hiba: A megadott f醞l nem tal醠hat?az arh韛umban."
        Push "%s f醞l kcsomagol醩a a(z) %s f醞lb髄 a %s helyre"
      !endif

      Push "/TRANSLATE"

  !endif

  !ifdef LANG_FRENCH

    StrCmp $LANGUAGE ${LANG_FRENCH} 0 +10

      Push "  Erreur : %s"
      Push "Impossible de r閏up閞er les informations sur le fichier."
      Push "Erreur : Impossible de r閏up閞er les informations sur le fichier."
      Push "Impossible de d閏ompresser %s."
      Push "  Erreur : Impossible de d閏ompresser %s."

      !ifdef FILE_<ALL>
        Push "  D閏ompression : %s"
        Push "  D閏ompression de %d fichiers et r閜ertoires"
        Push "D閏ompression des donn閑s de %s vers %s"
      !else
        Push "Le fichier sp閏ifi?n'existe pas dans l'archive"
        Push "Erreur : Le fichier sp閏ifi?n'existe pas dans l'archive"
        Push "D閏ompression du fichier %s depuis %s vers %s"
      !endif

      Push "/TRANSLATE"

  !endif

  !ifdef LANG_GERMAN

    StrCmp $LANGUAGE ${LANG_GERMAN} 0 +10

      Push "  Fehler: %s"
      Push "Dateiattribute konnten nicht ermittelt werden."
      Push "Fehler: Dateiattribute konnten nicht ermittelt werden."
      Push "%s konnte nicht dekomprimiert werden."
      Push "  Fehler: %s konnte nicht dekomprimiert werden."

      !ifdef FILE_<ALL>
        Push "  Dekomprimiere: %s"
        Push "  Dekomprimiere %d Dateien und Verzeichnisse"
        Push "Dekomprimiere Inhalt von %s nach %s"
      !else
        Push "Die angegebene Datei existiert nicht im Archiv"
        Push "Fehler: Die angegebene Datei existiert nicht im Archiv"
        Push "Dekomprimiere Datei %s von %s nach %s"
      !endif

      Push "/TRANSLATE"

  !endif

  !ifdef LANG_SPANISH

    StrCmp $LANGUAGE ${LANG_SPANISH} 0 +10

      Push "  Error: %s"
      Push "No se obtuvieron atributos del archivo"
      Push "Error: No se obtuvieron atributos del archivo"
      Push "No se pudo extraer %s"
      Push "  Error: No se pudo extraer %s"

      !ifdef FILE_<ALL>
        Push "  Extraer: %s"
        Push "  Extrayendo %d archivos y directorios"
        Push "Extraer archivos de %s a %s"
      !else
        Push "Archivo especificado no existe en el ZIP"
        Push "Error: El archivo especificado no existe en el ZIP"
        Push "Extrayendo el archivo %s de %s a %s"
      !endif

      Push "/TRANSLATE"

  !endif

  !ifdef LANG_PORTUGUESEBR

    StrCmp $LANGUAGE ${LANG_PORTUGUESEBR} 0 +10

      Push "  Erro: %s"
      Push "N鉶 se pode ler os atributos do arquivo"
      Push "Error: N鉶 se pode ler os atributos do arquivo"
      Push "N鉶 se pode extrair %s"
      Push "  Erro: N鉶 se pode extrair %s"

      !ifdef FILE_<ALL>
        Push "  Extraindo: %s"
        Push "  Extraindo %d arquivos e diret髍ios"
        Push "Extraindo arquivos de %s a %s"
      !else
        Push "O arquivo especificado n鉶 existe no ZIP"
        Push "Erro: O arquivo especificado n鉶 existe no ZIP"
        Push "Extraindo o arquivo %s de %s a %s"
      !endif

      Push "/TRANSLATE"

  !endif

  !ifdef LANG_TRADCHINESE

  StrCmp $LANGUAGE ${LANG_TRADCHINESE} 0 +11

    Push "  岿粇: %s"
    Push "礚猭眔郎妮┦"
    Push "岿粇: 礚猭眔郎妮┦"
    Push "礚猭秆溃罽 %s"
    Push "  岿粇礚猭秆溃罽 %s"
    
    !ifdef FILE_<ALL>
      Push "  秆溃罽%s"
      Push "  タ秆溃罽 %d 郎籔ヘ魁"
      Push "タ秆溃罽 %s ず甧 %s"
    !else
      Push "﹚郎ぃ溃罽"
      Push "岿粇﹚郎ぃ溃罽"
      Push "タ秆溃罽郎 %s 眖 %s  %s"
    !endif
    
    Push "/TRANSLATE"

  !endif

  !ifdef LANG_SIMPCHINESE

  StrCmp $LANGUAGE ${LANG_SIMPCHINESE} 0 +11

    Push "  错误: %s"
    Push "无法取得文件属性。"
    Push "错误: 无法取得文件属性。"
    Push "无法解压缩 %s"
    Push "  错误：无法解压缩 %s"
    
    !ifdef FILE_<ALL>
      Push "  解压缩：%s"
      Push "  正在解压缩 %d 文件与目录"
      Push "正在解压缩 %s 的内容到 %s"
    !else
      Push "指定的文件并不存在于压缩包。"
      Push "错误：指定的文件并不存在于压缩包。"
      Push "正在解压缩文件 %s ，从 %s 到 %s"
    !endif
    
    Push "/TRANSLATE"

  !endif

  !ifdef LANG_LITHUANIAN

    StrCmp $LANGUAGE ${LANG_LITHUANIAN} 0 +10

      Push "  Klaida: %s"
      Push "Negaleta gauti bylos nuorodu."
      Push "Klaida: Negaleta gauti bylos nuorodu."
      Push "Negaleta i歵raukti %s"
      Push "  Klaida: Negaleta i歵raukti %s"

      !ifdef FILE_<ALL>
        Push "  I歵raukiam : %s"
        Push "  I歵raukiame %d bylas ir katalogus"
        Push "I歵raukiame viska is %s i %s"
      !else
        Push "Parinkta byla nesurasta 歩ame archyve."
        Push "Klaida: Parinkta byla nesurasta 歩ame archyve."
        Push "I歵raukiame byla %s i?%s i %s"
      !endif

      Push "/TRANSLATE"

  !endif

  !ifdef "LANG_POLISH"

    strcmp $LANGUAGE ${LANG_POLISH} 0 +10

      Push "  B彻d: %s"
      Push "Nie mo縠 pobra?atrybutu pliku."
      Push "B彻d: Nie mo縠 pobra?atrybutu pliku."
      Push "Nie mo縠 rozpakowa?%s."
      Push "  B彻d: Nie mo縠 rozpakowa?%s."

      !ifdef FILE_<ALL>
        Push "  Rozpakuj: %s"
        Push "  Rozpakowywanie %d plik體 i katalog體"
        Push "Rozpakowywanie zawarto渃i %s do %s"
      !else
        Push "Plik nie istnieje w archiwum"
        Push "B彻d: Plik nie istnieje w archiwum"
        Push "Rozpakowywanie pliku %s z %s do %s"
      !endif

      Push "/TRANSLATE"

  !endif

  !ifdef "LANG_KOREAN"
    strcmp $LANGUAGE ${LANG_KOREAN} 0 +10
      Push "  坷幅 : %s"
      Push "拳老 加己阑 掘绢棵 荐 绝嚼聪促."
      Push "坷幅: 拳老 加己阑 掘绢棵 荐 绝嚼聪促."
      Push "%s阑(甫) 钱 荐 绝嚼聪促."
      Push "  坷幅: %s阑(甫) 钱 荐 绝嚼聪促."

      !ifdef FILE_<ALL>
        Push "  钱扁 : %s"
        Push "  %d俺狼 颇老苞 弃歹甫 仟绰 吝"
        Push "%s狼 郴侩阑 %s俊 仟绰 吝"
      !else
        Push "瘤沥等 颇老捞 拘绵 颇老 救俊 绝嚼聪促."
        Push "坷幅: 瘤沥等 颇老捞 拘绵 颇老 救俊 绝嚼聪促."
        Push "%s 颇老阑 %s俊辑 %s肺 仟绰 吝"
      !endif

      Push "/TRANSLATE"

  !endif

  !ifdef "LANG_RUSSIAN"

    strcmp $LANGUAGE ${LANG_RUSSIAN} 0 +10

      Push "  硒栳赅: %s"
      Push "湾 祛泱 镱塍麒螯 囹痂狍螓 羿殡?"
      Push "硒栳赅: 湾 祛泱 镱塍麒螯 囹痂狍螓 羿殡?"
      Push "湾 祛泱 桤怆鬻?%s"
      Push "  硒栳赅: 湾 祛泱 桤怆鬻?%s"

      !ifdef LANG_<ALL>
        Push "  如怆尻帼 : %s"
        Push "  如怆鬻屙桢 %d 羿殡钼 ?镟镱?
        Push "扬桉铌 桤怆尻噱禧?羿殡钼 桤 %s ?%s"
      !else
        Push "如怆尻噱禧?羿殡 礤 钺磬痼驽??囵蹊忮."
        Push "硒栳赅: S如怆尻噱禧?羿殡 礤 钺磬痼驽??囵蹊忮."
        Push "如怆鬻屙桢 羿殡?%s 桤 %s ?%s"
      !endif

      Push "/TRANSLATE"

  !endif

  !ifdef LANG_ARABIC

    StrCmp $LANGUAGE ${LANG_ARABIC} 0 +10

      Push "  呜橇: %s"
      Push "徙 硗蔗 卺?握瞧?轻汜?"
      Push "呜橇: 徙 硗蔗 卺?握瞧?轻汜?"
      Push "崆 磴咪 怯饰亚?%s"
      Push " 呜橇: 崆 磴咪 怯饰亚?%s"
  
      !ifdef FILE_<ALL>
        Push "  怯饰亚?: %s"
        Push "  怯饰亚?闾嵯鞘 ?汜萸?%d"
        Push "怯饰亚?阃舒砬?%s 裴?%s"
      !else
        Push "轻汜?垌?沔替?蓓 轻犹?"
        Push "呜橇: 轻汜?垌?沔替?蓓 轻犹?"
        Push "怯饰亚?轻汜?%s 沅 %s 裴?%s"
      !endif

      Push "/TRANSLATE"

  ;!endif

  !ifdef LANG_DANISH

    StrCmp $LANGUAGE ${LANG_DANISH} 0 +10

      Push "  Fejl: %s"
      Push "Kunne ikke l鎠e fil attributter."
      Push "Fejl: Kunne ikke l鎠e fil attributter."
      Push "Kunne ikke udpakke %s"
      Push "  Fejl: Kunne ikke udpakke %s"

      !ifdef FILE_<ALL>
        Push "  Udpakker: %s"
        Push "  Udpakker %d filer og mapper"
        Push "Udpakker indhold fra %s til %s"
      !else
        Push "Specificeret fil eksisterer ikke i filarkivet"
        Push "Fejl: Specificeret fil eksisterer ikke i filarkivet"
        Push "Udpakker fil %s fra %s til %s"
      !endif

      Push "/TRANSLATE"

  !endif 

  !ifdef LANG_CROATIAN

    StrCmp $LANGUAGE ${LANG_CROATIAN} 0 +10

      Push "  Gre歬a: %s"
      Push "Ne mogu dohvatiti atribute datoteke."
      Push "Gre歬a: Ne mogu dohvatiti atribute datoteke."
      Push "Ne mogu ekstrahirati %s"
      Push "  Gre歬a: Ne mogu ekstrahirati %s"

      !ifdef FILE_<ALL>
        Push "  Ekstrakcija: %s"
        Push "  Ekstrakcija %d datoteka i mapa"
        Push "Ekstrakcija sadr瀉ja %s u %s"
      !else
        Push "Tra瀍na datoteka ne postoji u arhivi."
        Push "Gre歬a: Tra瀍na datoteka ne postoji u arhivi."
        Push "Ekstrakcija datoteke %s iz %s u %s"
      !endif

      Push "/TRANSLATE"

  !endif

  !ifdef FILE_<ALL>
    ZipDLL::extractall
  !else
    ZipDLL::extractfile
  !endif

  !undef "FILE_${FILE}"

!macroend

!endif
