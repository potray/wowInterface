if ( GetLocale() ~= "ruRU" ) then
	return;
end

local L = LibStub("AceLocale-3.0"):NewLocale("Carbonite", "ruRU")
if not L then return end

NXClassLocToCap = {		-- Convert localized class name to generic caps
	["Рыцарь смерти"] = "DEATHKNIGHT",
	["Друид"] = "DRUID",
	["Охотник"] = "HUNTER",
	["Охотница"] = "HUNTER",
	["Маг"] = "MAGE",
	["Монах"] = "MONK",
	["Паладин"] = "PALADIN",
	["Паладинша"] = "PALADIN",
	["Жрец"] = "PRIEST",
	["Жрица"] = "PRIEST",
	["Разбойник"] = "ROGUE",
	["Разбойница"] = "ROGUE",
	["Шаман"] = "SHAMAN",
	["Шаманка"] = "SHAMAN",
	["Чернокнижник"] = "WARLOCK",
	["Чернокнижница"] = "WARLOCK",
	["Воин"] = "WARRIOR",
}

-- Main Carbonite
L["Carbonite"] = true
L["CARBONITE"] = true
L["Loading"] = "Загрузка"
L["Loading Done"] = "Загрузка Завершена"
L["None"] = "Нет"
L["Goto"] = "Идти к"
L["Show Player Zone"] = "Показать местонахождение игрока"
L["Menu"] = "Меню"
L["Show Selected Zone"] = "Показать выбранную локацию"
L["Add Note"] = "Добавить Заметку"
L["TopRight"] = "Верхний Правый"
L["Help"] = "Помощь"
L["Options"] = "Настройки"
L["Toggle Map"] = "Вкл/Выкл Карту"
L["Toggle Combat Graph"] = "Вкл/Выкл График боя"
L["Toggle Events"] = "Вкл/Выкл События"
L["Left-Click to Toggle Map"] = "Левый клик чтобы Вкл/Выкл Карту"
L["Shift Left-Click to Toggle Minimize"] = "Шифт Левый клик чтобы Вкл/Выкл Минимизацию"
L["Middle-Click to Toggle Guide"] = "Средний клик чтобы Вкл/Выкл Слежение"
L["Right-Click for Menu"] = "Правый клик для Меню"
L["Carbonite requires v5.0 or higher"] = "Carbonite нужна v5.0 или выше"
L["GUID player"] = "GUID игрока"
L["GUID NPC"] = true
L["GUID pet"] = "GUID питомца"
L["Unit map error"] = true
L["Gather"] = "Добыча"
L["Entered"] = "Войти"
L["Level"] = "Уровень"
L["Deaths"] = "Смерти"
L["Bonus"] = "Бонус"
L["Reset old data"] = "Удалить старую информацию"
L["Reset old global options"] = "Удалить старые глобальные настройки"
L["Options have been reset for the new version."] = "Настройки будут сброшены для новой версии."
L["Privacy or other settings may have changed."] = "Личные или другие настройки могли изменится."
L["Cleaned"] = "Очищено"
L["items"] = "Вещи"
L["Reset old HUD options"] = "Удаление старых настроек HUD"
L["Reset old travel data"] = "Удаление старых данных о путешествии"
L["Reset old gather data"] = "Удаление старых данных о добыче"
L["Missing character data!"] = "Отсутствует информация о персонаже!"
L["Deathknight"] = "Рыцарь Смерти"
L["Death Knight"] = "Рыцарь Смерти"
L["Version"] = "Версия"
L["Maintained by"] = "Поддерживается"
L["crit"] = "Крит"
L["hit"] = "Меткость"
L["Killed"] = "Убито"
L["honor"] = "Чести"
L["Hit"] = "Попаданий"
L["Peak"] = "Максимальный"
L["Best"] = "Лучший"
L["Total"] = "Всего"
L["Time"] = "Время"
L["Event"] = "Событие"
L["Events"] = "События"
L["Position"] = "Место"
L["Died"] = "Умер"
L["Picked"] = "Собранно"
L["Mined"] = "Добыто"
L["Fished"] = "Выловлено"
L["Unknown herb"] = "Неизвестная трава"
L["Unknown ore"] = "Неизвестная руда"
L["Gathermate2_Data_Carbonite addon is not loaded!"] = "Модификация Gathermate2_Data_Carbonite не загружена!"
L["Imported"] = "Импортированно"
L["nodes from GatherMate2_Data"] = "точки из GatherMate2_Data"
L["Delete visited vendor data?"] = "Удалить информацию о посещенных торговцах?"
L["This will stop the attempted retrieval of items on login."] = "Прекратит попытки получения предметов при входе."
L["Delete"] = "Удалить"
L["Cancel"] = "Отмена"
L["items retrieved"] = "Элементы извлекаются"
L["Item retrieval from server complete"] = "Извлечение элементов с сервера завершено"
L["Show Map"] = "Показать карту"
L["Show Combat Graph"] = "Показать график боя"
L["Show Events"] = "Показать События"
L["Show Auction Buyout Per Item"] = "Показать цену выкупа на аукционе для ед."
L["Show Com Window"] = "Delete"
L["Toggle Profiling"] = "Вкл/Выкл Профилирование"
L["Left click toggle Map"] = "Левый клик чтобы Вкл/Выкл Карту"
L["Shift left click toggle minimize"] = "Шифт Левый клик чтобы Вкл/Выкл Минимизацию"
L["Alt left click toggle Watch List"] = "Альт Левый клик чтобы Вкл/Выкл Журнал Заданий"
L["Middle click toggle Guide"] = "Шифт Левый клик чтобы Вкл/Выкл Слежение"
L["Right click for Menu"] = "Правый клик для Меню"
L["Shift drag to move"] = "Перемещение с зажатым шифтом"
L["Hide In Combat"] = "Скрыть в бою"
L["Lock"] = "Закрепить"
L["Fade In"] = "Приблизить"
L["Fade Out"] = "Отдалить"
L["Layer"] = "Слой"
L["Scale"] = "Маштаб"
L["Transparency"] = "Прозрачность"
L["Reset Layout"] = "Сбросить "

-- UI Tooltips
L["Close/Menu"] = true
L["Close/Unlock"] = true
L["Pick Color"] = true
L["Unlock"] = true
L["Maximize"] = true
L["Restore"] = true
L["Minimize"] = true
L["Auto Scale"] = true

-- Stuff from old localization
L["Searching for Artifacts"] = "Поиск артефактов"		-- NXlARTIFACTS
L["Extract Gas"] = "Извлечение газа"				-- NXlEXTRACTGAS
L["Herb Gathering"] = "Сбор трав"				-- NXlHERBGATHERING
L["In Conflict"] = "В конфликте"				-- NXlINCONFLICT
L["Opening"] = "Открывание"					-- NXlOpening
L["Opening - No Text"] = "Открывание - нет текста"		-- NXlOpeningNoText
L["Everfrost Chip"] = "Осколок Вечного льда"			-- NXlEverfrost

L["yds"] = true
L["secs"] = true
L["mins"] = true

-- NxUI.lua
L[" Frame: %s Shown%d Vis%d P>%s"] = true
L[" EScale %f, Lvl %f"] = true
L[" LR %f, %f"] = true
L[" BT %f, %f"] = true
L["%s#%d %s ID%s (%s) show%d l%d x%d y%d"] = true
L["%.1f days"] = true
L["%.1f hours"] = true
L["%d mins"] = true
L["Reset old layout data"] = true
L["Window version mismatch!"] = true
L["XY missing (%s)"] = true
L["Window not found (%s)"] = true
L["Detach %s"] = true
L["Detach found %s"] = true
L["Search: [click]"] = true
L["Search: %[click%]"] = true
L["Reset old list data"] = true
L["!BUT %s"] = true
L["Key %s transfered to Watch List Item"] = true
L["CLICK (.+):"] = true
L["Key %s %s #%s %s"] = true
L["shift left/right click to change size"] = true
L["Reset old tool bar data"] = true

-- NxTravel.lua
L["Connection: %s to %s"] = true
L["Fly: %s to %s"] = true
