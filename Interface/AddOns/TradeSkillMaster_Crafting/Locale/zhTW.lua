-- ------------------------------------------------------------------------------------- --
-- 					TradeSkillMaster_Crafting - AddOn by Sapu94							 	  	  --
--   http://wow.curse.com/downloads/wow-addons/details/tradeskillmaster_crafting.aspx    --
--																													  --
--		This addon is licensed under the CC BY-NC-ND 3.0 license as described at the		  --
--				following url: http://creativecommons.org/licenses/by-nc-nd/3.0/			 	  --
-- 	Please contact the author via email at sapu94@gmail.com with any questions or		  --
--		concerns regarding this license.																	  --
-- ------------------------------------------------------------------------------------- --

-- TradeSkillMaster_Crafting Locale - zhTW
-- Please use the localization app on CurseForge to update this
-- http://wow.curseforge.com/addons/TradeSkillMaster_Crafting/localization/

local L = LibStub("AceLocale-3.0"):NewLocale("TradeSkillMaster_Crafting", "zhTW")
if not L then return end

L["All"] = "全部"
L["Are you sure you want to reset all material prices to the default value?"] = "你確定要重置所有材料價格為默認價值嗎?"
L["Ask Later"] = "以后詢問"
L["Auction House"] = "拍賣行"
L["Available Sources"] = "可用的數據來源"
L["Buy Vendor Items"] = "購買商人物品"
L["Characters (Bags/Bank/AH/Mail) to Ignore:"] = "角色（背包/銀行/拍賣行/郵件）忽略："
L["Clear Filters"] = "清除過濾條件"
L["Clear Queue"] = "清除序列"
L["Click Start Gathering"] = "點擊開始收集"
L["Collect Mail"] = "收集郵件"
L["Cost"] = "成本"
L["Could not get link for profession."] = "無法獲取專業技能鏈接。"
L["Crafting Cost"] = "製作成本"
L["Crafting Material Cost"] = "製造材料成本"
L["Crafting operations contain settings for restocking the items in a group. Type the name of the new operation into the box below and hit 'enter' to create a new Crafting operation."] = "製造操作包含為一個群組中的物品補貨的相關設定。在下面的輸入框中為新操作輸入一個名字并點擊“回車”來創建一個新的製造操作。"
L["Crafting will not queue any items affected by this operation with a profit below this value. As an example, a min profit of 'max(10g, 10% crafting)' would ensure atleast a 10g and 10% profit."] = "製造助手不會將任何受該操作影響的利潤低于此值的物品加入序列。舉例來說，最小利潤設置為“max(10g, 10% crafting)”將確保利潤為10g和10%製造成本兩者中較高的一個（即若製作成本的10%不高于10g則最小利潤為10g，若製作成本的10%高于10g則最小利潤為製造成本的10%，此僅為舉例，具體數值可自行設定）。"
L["Craft Next"] = "製造下一個"
L["Craft Price Method"] = "製造價格設定"
L["Craft Queue"] = "製造序列"
L["Create Profession Groups"] = "創建專業技能群組"
L["Custom Price"] = "自定義價格"
L["Custom Price for this item."] = "為該物品自定義價格"
L["Custom Price per Item"] = "每物品的自定義價格"
L["Default Craft Price Method"] = "默認製作價格設定"
L["Default Material Cost Method"] = "默認材料成本設定"
L["Default Price"] = "默認價格"
L["Default Price Settings"] = "默認價格設定"
L["Enchant Vellum"] = "附魔皮紙"
L["Error creating operation. Operation with name '%s' already exists."] = "創建操作出錯。名為“%s”的操作已存在。"
L[ [=[Estimated Cost: %s
Estimated Profit: %s]=] ] = [=[預估成本：%s
預估利潤：%s]=]
L["Exclude Crafts with a Cooldown from Craft Cost"] = "從製作成本中排除有冷卻時間的製作物品。"
L["Filters >>"] = "過濾條件>>"
L["First select a crafter"] = "首先選擇一個製造者"
L["Gather"] = "收集"
L["Gather All Professions by Default if Only One Crafter"] = "如果只有一個製造者則按默認收集所有專業" -- Needs review
L["Gathering"] = "收集"
L["Gathering Crafting Mats"] = "收集製造材料"
L["Gather Items"] = "收集物品"
L["General"] = "常規"
L["General Settings"] = "常規設定"
L["Give the new operation a name. A descriptive name will help you find this operation later."] = "給新操作命名。一個描述性的名字將有益于你以后找到該操作。"
L["Guilds (Guild Banks) to Ignore:"] = "忽略公會（公會銀行）："
L["Here you can view and adjust how Crafting is calculating the price for this material."] = "這裡可以查看和調整如何計算出製作材料的價格。"
L["<< Hide Queue"] = "<<隱藏製造序列"
L["If checked, Crafting will never try and craft inks as intermediate crafts."] = "若勾選，製作助手將不會嘗試將墨水作為中級材料來製造。"
L["If checked, if there is more than one way to craft the item then the craft cost will exclude any craft with a daily cooldown when calculating the lowest craft cost."] = "若勾選，如果物品不止一種方法可製作，在計算最低成本時將排除掉任何有一天冷卻時間的材料物品。"
L["If checked, if there is only one crafter for the craft queue clicking gather will gather for all professions for that crafter"] = "若勾選，當製造序列中的物品僅由一個角色來製造時點擊收集將收集該角色的所有專業。"
L["If checked, the crafting cost of items will be shown in the tooltip for the item."] = "若勾選，製作成本將會顯示在物品的滑鼠提示中。"
L["If checked, the material cost of items will be shown in the tooltip for the item."] = "若勾選，物品的製作材料成本將顯示在物品的滑鼠提示中。"
L["If checked, when the TSM_Crafting frame is shown (when you open a profession), the default profession UI will also be shown."] = "若勾選，當TSM_Crafting窗口顯示時（在你打開專業窗口時），系統內建的專業技能介面也將顯示。"
L["Inventory Settings"] = "庫存設定"
L["Item Name"] = "物品名稱"
L["Items will only be added to the queue if the number being added is greater than this number. This is useful if you don't want to bother with crafting singles for example."] = "如果被添加的數字比該值大，則物品只會添加到序列。舉例來說，如果你不想煩惱于製作單個物品，這是非常有用的設置。" -- Needs review
L["Item Value"] = "物品價值"
L["Left-Click|r to add this craft to the queue."] = "點擊|r 將該項製造添加到序列。"
L["Link"] = "鏈接"
L["Mailing Craft Mats to %s"] = "郵寄製作材料至%s"
L["Mail Items"] = "郵寄物品"
L["Mat Cost"] = "材料成本"
L["Material Cost Options"] = "材料成本選項"
L["Material Name"] = "材料名稱"
L["Materials:"] = "材料："
L["Mat Price"] = "材料價格"
L["Max Restock Quantity"] = "最大補貨數量"
L["Minimum Profit"] = "最小利潤"
L["Min Restock Quantity"] = "最小補貨數量"
L["Name"] = "名稱"
L["Need"] = "需要"
L["Needed Mats at Current Source"] = "當前來源可用的材料" -- Needs review
L["Never Queue Inks as Sub-Craftings"] = "不將墨水作為材料添加到序列"
L["New Operation"] = "新操作"
L["<None>"] = "<無>"
L["No Thanks"] = "否"
L["Nothing To Gather"] = "沒有物品可收集"
L["Nothing to Mail"] = "沒有物品可郵寄"
L["Now select your profession(s)"] = "現在選擇你的專業技能"
L["Number Owned"] = "現有數量"
L["Opens the Crafting window to the first profession."] = "打開第一專業的製造窗口" -- Needs review
L["Operation Name"] = "操作名稱" -- Needs review
L["Operations"] = "操作" -- Needs review
L["Options"] = "選項"
L["Override Default Craft Price Method"] = "覆蓋默認製造價格設定" -- Needs review
L["Percent to subtract from buyout when calculating profits (5% will compensate for AH cut)."] = "計算利潤時按百分比從直購價中扣除（設為5%將抵消拍賣行稅金）。"
L["Please switch to the Shopping Tab to perform the gathering search."] = "請切換至購物標籤頁來執行收集搜索。" -- Needs review
L["Price:"] = "價格："
L["Price Settings"] = "價格設定"
L["Price Source Filter"] = "價格來源過濾器" -- Needs review
L["Profession data not found for %s on %s. Logging into this player and opening the profression may solve this issue."] = "專業數據未找到：%s在%s。登入該角色并打開專業技能窗口可以解決該問題。" -- Needs review
L["Profession Filter"] = "專業過濾器" -- Needs review
L["Professions"] = "專業技能" -- Needs review
L["Professions Used In"] = "涉及專業" -- Needs review
L["Profit"] = "利潤"
L["Profit Deduction"] = "利潤扣除"
L["Profit (Total Profit):"] = "利潤（總利潤）：" -- Needs review
L["Queue"] = "製造序列" -- Needs review
L["Relationships"] = "關聯性" -- Needs review
L["Reset All Custom Prices to Default"] = "重設所有自定義價格為默認值" -- Needs review
L["Reset all Custom Prices to Default Price Source."] = "重設所有自定義價格為默認價格來源。" -- Needs review
L["Resets the material price for this item to the defualt value."] = "將該物品的材料價格重設為默認值。" -- Needs review
L["Reset to Default"] = "重設為默認" -- Needs review
L["Restocking to a max of %d (min of %d) with a min profit."] = "以最小利潤補貨至%d的最大值（%d的最小值）。" -- Needs review
L["Restocking to a max of %d (min of %d) with no min profit."] = "以非最小利潤補貨至%d的最大值（%d的最小值）。" -- Needs review
L["Restock Quantity Settings"] = "補貨數量設定" -- Needs review
L["Restock Selected Groups"] = "為選定分組補貨" -- Needs review
L["Restock Settings"] = "補貨設定" -- Needs review
L["Right-Click|r to subtract this craft from the queue."] = "右鍵|r從製造序列中移除該項製作。" -- Needs review
L["%s Avail"] = "%s效益" -- Needs review
L["Search"] = "搜索" -- Needs review
L["Search for Mats"] = "搜索材料" -- Needs review
L["Select Crafter"] = "選擇製造者" -- Needs review
L["Select one of your characters' professions to browse."] = "選擇一項你的角色的專業技能進行瀏覽。" -- Needs review
L["Set Minimum Profit"] = "設置最小利潤" -- Needs review
L["Shift-Left-Click|r to queue all you can craft."] = "Shift+點擊|r添加所有你可製造的物品至序列。" -- Needs review
L["Shift-Right-Click|r to remove all from queue."] = "Shift+右鍵|r移除所有序列中的製造項。" -- Needs review
L["Show Crafting Cost in Tooltip"] = "在滑鼠提示中顯示製造成本"
L["Show Default Profession Frame"] = "顯示默認專業介面" -- Needs review
L["Show Material Cost in Tooltip"] = "在滑鼠提示中顯示材料成本" -- Needs review
L["Show Queue >>"] = "顯示製造序列>>" -- Needs review
L["'%s' is an invalid operation! Min restock of %d is higher than max restock of %d."] = "“%s”是一個無效的操作！%d的最小補貨量高于%d的最大補貨量。"
L["%s (%s profit)"] = "%s（%s利潤）"
L["Stage %d"] = "階段%d" -- Needs review
L["Start Gathering"] = "開始收集" -- Needs review
L["Stop Gathering"] = "停止收集" -- Needs review
L["This is the default method Crafting will use for determining craft prices."] = "這是默認的製造助手用于確定成品價格的方法。" -- Needs review
L["This is the default method Crafting will use for determining material cost."] = "這是默認的製造助手用于確定材料價格的方法。" -- Needs review
L["Total"] = "合計"
L["TSM Groups"] = "TSM群組" -- Needs review
L["Vendor"] = "商人"
L["Visit Bank"] = "查看銀行" -- Needs review
L["Visit Guild Bank"] = "查看公會銀行" -- Needs review
L["Visit Vendor"] = "查看商人" -- Needs review
L["Warning: The min restock quantity must be lower than the max restock quantity."] = "警告：最小補貨數量必須低於最大補貨數量。"
L["When you click on the \"Restock Queue\" button enough of each craft will be queued so that you have this maximum number on hand. For example, if you have 2 of item X on hand and you set this to 4, 2 more will be added to the craft queue."] = "當你進行補貨操作時，會補貨至使你手上持有該設定的最大值。舉例來說，若此處的設定值為4，你手里只有2個x物品時，進行補貨操作就會添加2個x物品到你的生產序列。"
L["Would you like to automatically create some TradeSkillMaster groups for this profession?"] = "你想為該專業自動創建TSM群組嗎？" -- Needs review
L["You can click on one of the rows of the scrolling table below to view or adjust how the price of a material is calculated."] = "你可以點擊下列表格中的一行來查看或調整材料價格的計算方法。"
