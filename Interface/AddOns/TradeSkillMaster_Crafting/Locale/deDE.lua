-- ------------------------------------------------------------------------------------- --
-- 					TradeSkillMaster_Crafting - AddOn by Sapu94							 	  	  --
--   http://wow.curse.com/downloads/wow-addons/details/tradeskillmaster_crafting.aspx    --
--																													  --
--		This addon is licensed under the CC BY-NC-ND 3.0 license as described at the		  --
--				following url: http://creativecommons.org/licenses/by-nc-nd/3.0/			 	  --
-- 	Please contact the author via email at sapu94@gmail.com with any questions or		  --
--		concerns regarding this license.																	  --
-- ------------------------------------------------------------------------------------- --

-- TradeSkillMaster_Crafting Locale - deDE
-- Please use the localization app on CurseForge to update this
-- http://wow.curseforge.com/addons/TradeSkillMaster_Crafting/localization/

local L = LibStub("AceLocale-3.0"):NewLocale("TradeSkillMaster_Crafting", "deDE")
if not L then return end

L["All"] = "Alle"
L["Are you sure you want to reset all material prices to the default value?"] = "Wirklich alle Materialpreise auf den Standardwert zurücksetzen?"
L["Ask Later"] = "Später nachfragen" -- Needs review
L["Auction House"] = "Auktionshaus"
L["Available Sources"] = "Verfügbare Quellen" -- Needs review
L["Buy Vendor Items"] = "Bei Händler kaufen" -- Needs review
L["Characters (Bags/Bank/AH/Mail) to Ignore:"] = "Ignoriere die Charaktere (Taschen/Bank/AH/Briefkasten):"
L["Clear Filters"] = "Filter leeren"
L["Clear Queue"] = "Leeren"
L["Click Start Gathering"] = "Klicke Sammeln starten" -- Needs review
L["Collect Mail"] = "Post einsammeln" -- Needs review
L["Cost"] = "Kosten"
L["Could not get link for profession."] = "Konnte nicht den Berufslink bekommen." -- Needs review
L["Crafting Cost"] = "Herstellungskosten" -- Needs review
L["Crafting Material Cost"] = "Herstellungsmaterialkosten" -- Needs review
L["Crafting operations contain settings for restocking the items in a group. Type the name of the new operation into the box below and hit 'enter' to create a new Crafting operation."] = "Crafting-Operationen enthalten Einstellungen zum Auffüllen von Gegenständen in einer Gruppe. Schreibt den Namen der neuen Operation in das untere Eingabefeld und drückt ENTER, um eine neue Crafting-Operation zu erstellen."
L["Crafting will not queue any items affected by this operation with a profit below this value. As an example, a min profit of 'max(10g, 10% crafting)' would ensure atleast a 10g and 10% profit."] = "Crafting wird keine von dieser Operation betroffenen Gegenstände in die Warteschlange setzen, die einen Gewinn unterhalb diesen Wertes erzielen. Zum Beispiel würde ein Minimalgewinn von 'max(10g, 10% crafting)' mindestens 10g und 10% Gewinn sicherstellen." -- Needs review
L["Craft Next"] = "Nächstes herstellen"
L["Craft Price Method"] = "Herstellungspreismethode" -- Needs review
L["Craft Queue"] = "Herstellungswarteschlange" -- Needs review
L["Create Profession Groups"] = "Berufsgruppen erstellen" -- Needs review
L["Custom Price"] = "Benutzerdefinierter Preis" -- Needs review
L["Custom Price for this item."] = "Benutzerdefinierter Preis für diesen Gegenstand." -- Needs review
L["Custom Price per Item"] = "Benutzerdefinierter Preis pro Gegenstand" -- Needs review
L["Default Craft Price Method"] = "Standardmethode für Herstellungspreis"
L["Default Material Cost Method"] = "Standardmethode für Herstellungskosten"
L["Default Price"] = "Standardpreis" -- Needs review
L["Default Price Settings"] = "Standardpreis-Einstellungen"
L["Enchant Vellum"] = "Verzauberungspergament" -- Needs review
L["Error creating operation. Operation with name '%s' already exists."] = "Fehler beim Erstellen der Operation. Ein Operation mit Namen '%s' existiert bereits."
L[ [=[Estimated Cost: %s
Estimated Profit: %s]=] ] = [=[Vorrausichtliche Kosten: %s
Vorrausichtlicher Profit: %s]=] -- Needs review
L["Exclude Crafts with a Cooldown from Craft Cost"] = "Ignoriere Herstellungskosten von Gegenständen, die eine Abklingzeit haben"
L["Filters >>"] = "Filter >>" -- Needs review
L["First select a crafter"] = "Zuerst einen Hersteller auswählen"
L["Gather"] = "Sammeln" -- Needs review
L["Gather All Professions by Default if Only One Crafter"] = "Sammle standardmäßig alle Berufe bei nur einem Hersteller" -- Needs review
L["Gathering"] = "Sammeln"
L["Gathering Crafting Mats"] = "Sammle Herstellungsmaterialien." -- Needs review
L["Gather Items"] = "Sammeln"
L["General"] = "Allgemein"
L["General Settings"] = "Allgemeine Einstellungen"
L["Give the new operation a name. A descriptive name will help you find this operation later."] = "Gebt der neuen Operation einen Namen. Ein beschreibender Name macht die Operation später leichter auffindbar."
L["Guilds (Guild Banks) to Ignore:"] = "Ignoriere die Gilden (Gildenbanken):"
L["Here you can view and adjust how Crafting is calculating the price for this material."] = "Hier könnt Ihr einsehen und anpassen, wie Crafting die Preise für dieses Material berechnet."
L["<< Hide Queue"] = "<< Warteschlange"
L["If checked, Crafting will never try and craft inks as intermediate crafts."] = "Wenn aktiviert, wird Crafting niemals versuchen, Tinten als Zwischenprodukte herzustellen." -- Needs review
L["If checked, if there is more than one way to craft the item then the craft cost will exclude any craft with a daily cooldown when calculating the lowest craft cost."] = "Wenn aktiviert, werden, sofern es mehr als eine Möglichkeit zum Herstellen eines Gegenstandes gibt, die Herstellungskosten von täglich-herstellbaren Gegenständen beim Berechnen der niedrigsten Herstellungskosten ignoriert." -- Needs review
L["If checked, if there is only one crafter for the craft queue clicking gather will gather for all professions for that crafter"] = "Wenn aktiviert, wird, sofern es nur einen Hersteller für die Warteschlange gibt, der Sammeln-Button für alle Berufe des Herstellers sammeln." -- Needs review
L["If checked, the crafting cost of items will be shown in the tooltip for the item."] = "Wenn aktiviert, werden die Herstellungskosten eines Gegenstands im Tooltip angezeigt."
L["If checked, the material cost of items will be shown in the tooltip for the item."] = "Wenn aktiviert, werden die Materialkosten eines Gegenstands im Tooltip angezeigt."
L["If checked, when the TSM_Crafting frame is shown (when you open a profession), the default profession UI will also be shown."] = "Wenn aktiviert, wird beim Anzeigen des TSM_Crafting-Fensters (wenn Ihr einen Beruf öffnen) auch das Standard-Berufs-UI angezeigt." -- Needs review
L["Inventory Settings"] = "Inventareinstellungen"
L["Item Name"] = "Gegenstandsname"
L["Items will only be added to the queue if the number being added is greater than this number. This is useful if you don't want to bother with crafting singles for example."] = "Gegenstände werden nur zur Warteschlange hinzufügt, falls die hinzuzufügende Menge größer als diese Zahl ist. Dies ist beispielsweise praktisch, um die Herstellung einzelner Gegenstände zu vermeiden."
L["Item Value"] = "Wert des Gegenstands" -- Needs review
L["Left-Click|r to add this craft to the queue."] = "Linksklick|r, um diesen Gegenstand in die Warteschlange zu setzen."
L["Link"] = "Link" -- Needs review
L["Mailing Craft Mats to %s"] = "Verschicke Herstellungsmaterialien an %s" -- Needs review
L["Mail Items"] = "Gegenstände verschicken" -- Needs review
L["Mat Cost"] = "Materialkosten" -- Needs review
L["Material Cost Options"] = "Materialkosten - Optionen"
L["Material Name"] = "Materialname" -- Needs review
L["Materials:"] = "Materialien:" -- Needs review
L["Mat Price"] = "Materialpreis"
L["Max Restock Quantity"] = "Maximale Auffüllmenge"
L["Minimum Profit"] = "Mindestgewinn"
L["Min Restock Quantity"] = "Minimale Auffüllmenge"
L["Name"] = "Name"
L["Need"] = "Bedarf"
L["Needed Mats at Current Source"] = "Benötigte Materialien bei aktueller Quelle" -- Needs review
L["Never Queue Inks as Sub-Craftings"] = "Ignoriere Tinten als Zwischenprodukte"
L["New Operation"] = "Neue Operation"
L["<None>"] = "<Nichts>" -- Needs review
L["No Thanks"] = "Nein, Danke" -- Needs review
L["Nothing To Gather"] = "Nichts zu sammeln" -- Needs review
L["Nothing to Mail"] = "Nichts zu verschicken" -- Needs review
L["Now select your profession(s)"] = "Wählt jetzt einen oder mehrere Eurer Berufe aus" -- Needs review
L["Number Owned"] = "Anzahl in Besitz"
L["Opens the Crafting window to the first profession."] = "Öffnet das Crafting-Fenster des ersten Berufs." -- Needs review
L["Operation Name"] = "Operationsname"
L["Operations"] = "Operationen"
L["Options"] = "Optionen"
L["Override Default Craft Price Method"] = "Überschreibe voreingestellte Herstellungspreismethoden" -- Needs review
L["Percent to subtract from buyout when calculating profits (5% will compensate for AH cut)."] = "Der Prozentsatz, der vom Sofortkaufpreis abgezogen werden soll, wenn der Gewinn berechnet wird (5% decken die AH-Kosten)."
L["Please switch to the Shopping Tab to perform the gathering search."] = "Bitte wechselt zum Shopping-Tab, um die Sammelsuche durchzuführen." -- Needs review
L["Price:"] = "Preis:"
L["Price Settings"] = "Preiseinstellungen"
L["Price Source Filter"] = "Preisquellenfilter" -- Needs review
L["Profession data not found for %s on %s. Logging into this player and opening the profression may solve this issue."] = "Berufsdaten nicht gefunden für %s auf %s. Dieses Problem kann gelöst werden, wenn Ihr Euch bei diesem Spieler einloggt und das Berufsfenster öffnet." -- Needs review
L["Profession Filter"] = "Berufsfilter" -- Needs review
L["Professions"] = "Berufe" -- Needs review
L["Professions Used In"] = "In Berufe verwendet" -- Needs review
L["Profit"] = "Profit"
L["Profit Deduction"] = "Gewinnabzug"
L["Profit (Total Profit):"] = "Gewinn (Gesamtgewinn):" -- Needs review
L["Queue"] = "Warteschlange" -- Needs review
L["Relationships"] = "Beziehungen" -- Needs review
L["Reset All Custom Prices to Default"] = "Standard aller benutzerdefinierten Preise wiederherstellen"
L["Reset all Custom Prices to Default Price Source."] = "Setzt alle benutzerdefinierten Preise auf ihre Standard-Preisquellen zurück."
L["Resets the material price for this item to the defualt value."] = "Setzt den Materialpreis für diesen Gegenstand auf den Standardwert." -- Needs review
L["Reset to Default"] = "Standard wiederherstellen"
L["Restocking to a max of %d (min of %d) with a min profit."] = "Fülle bis zu einer Menge von %d auf (Minimum von %d), mit einem Minimalgewinn." -- Needs review
L["Restocking to a max of %d (min of %d) with no min profit."] = "Fülle bis zu einer Menge von %d auf (Minimum von %d), ohne Minimalgewinn." -- Needs review
L["Restock Quantity Settings"] = "Auffüllmenge-Einstellungen" -- Needs review
L["Restock Selected Groups"] = "Ausgewählte Gruppe auffüllen"
L["Restock Settings"] = "Auffüll-Einstellungen" -- Needs review
L["Right-Click|r to subtract this craft from the queue."] = "Rechtsklick|r, um diesen Gegenstand aus der Warteschlange zu entfernen."
L["%s Avail"] = "%s Gewinn" -- Needs review
L["Search"] = "Suchen" -- Needs review
L["Search for Mats"] = "Suche nach Materialien" -- Needs review
L["Select Crafter"] = "Wähle Hersteller aus" -- Needs review
L["Select one of your characters' professions to browse."] = "Wählt die Berufe von einem Eurer Charaktere aus, um sie zu durchsuchen." -- Needs review
L["Set Minimum Profit"] = "Setze Mindestgewinn"
L["Shift-Left-Click|r to queue all you can craft."] = "Umschalt-Linksklick|r, um alles, was hergestellt werden kann, in die Warteschlange zu setzen." -- Needs review
L["Shift-Right-Click|r to remove all from queue."] = "Umschalt-Rechtsklick|r, um alles aus der Warteschlange zu entfernen." -- Needs review
L["Show Crafting Cost in Tooltip"] = "Zeige Herstellungskosten im Tooltip"
L["Show Default Profession Frame"] = "Öffne das Standard-Berufsfenster" -- Needs review
L["Show Material Cost in Tooltip"] = "Zeige Materialkosten im Tooltip an" -- Needs review
L["Show Queue >>"] = "Warteschlange >>"
L["'%s' is an invalid operation! Min restock of %d is higher than max restock of %d."] = "'%s' ist eine ungültige Operation! Minimale Auffüllmenge von %d ist höher als maximale Auffüllmenge von %d."
L["%s (%s profit)"] = "%s (%s Gewinn)"
L["Stage %d"] = "Schritt %d" -- Needs review
L["Start Gathering"] = "Sammeln starten"
L["Stop Gathering"] = "Sammeln stoppen"
L["This is the default method Crafting will use for determining craft prices."] = "Dies ist die Standardmethode, mit der Crafting die Herstellungskosten ermittelt." -- Needs review
L["This is the default method Crafting will use for determining material cost."] = "Dies ist die Standardmethode, mit der Crafting die Materialkosten ermittelt." -- Needs review
L["Total"] = "Total"
L["TSM Groups"] = "TSM-Gruppen" -- Needs review
L["Vendor"] = "NPC-Händler"
L["Visit Bank"] = "Bank besuchen"
L["Visit Guild Bank"] = "Gildenbank besuchen"
L["Visit Vendor"] = "Händler besuchen" -- Needs review
L["Warning: The min restock quantity must be lower than the max restock quantity."] = "Warnung: Die minimale Auffüllmenge muss kleiner sein als die maximale Auffüllmenge."
L["When you click on the \"Restock Queue\" button enough of each craft will be queued so that you have this maximum number on hand. For example, if you have 2 of item X on hand and you set this to 4, 2 more will be added to the craft queue."] = "Wenn Ihr oft genug auf den Button \"Warteschlange\" drückt, wird jeder herstellbare Gegenstand in die Warteschlange gesetzt, so dass Ihr diese maximale Anzahl vorrätig habt. Zum Beispiel: Wenn Ihr 2-mal den Gegenstand X vorrätig habt und Ihr den Wert auf 4 setzt, werden 2 weitere in die Warteschlange eingefügt."
L["Would you like to automatically create some TradeSkillMaster groups for this profession?"] = "Möchtet Ihr, dass TSM automatisch einige Gruppen für diesen Beruf erstellt?"
L["You can click on one of the rows of the scrolling table below to view or adjust how the price of a material is calculated."] = "Ihr könnt auf eine der Reihen in der unteren scrollbaren Tabelle klicken, um die Preisberechnung für ein Material anzuzeigen und zu ändern."
