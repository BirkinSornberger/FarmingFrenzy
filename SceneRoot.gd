extends Control

#To do:
#	Finish the core game mechanics
#	Add high price random events
#	Add random major inventory loss events
#	Add dialog to indicate inventory space
#	Add random pop ups to buy more inventory space (van upgrades, bigger van?)

#Enum selectors
enum MenuLevel {Title, Instructions, PopUp, CheapPrices, Travel, Grow, Sell, Main}
@onready var currentMenu = MenuLevel.Title

enum Crops {Unselected, Avocado, Tomato, Potato, Cucumber, Garlic, Lettuce}
@onready var currentCrop = Crops.Unselected

#Nodes
@onready var titleScreen: Node = $TitleScreen
@onready var instructions: Node = $Instructions
@onready var main: Node = $Main
@onready var mainMain: Node = $Main/Interactions/Main
@onready var cheapPrices: Node = $Main/Interactions/CheapPrices
@onready var bankLoan: Node = $Main/Interactions/BankLoan
@onready var transferCrops: Node = $Main/Interactions/TransferCrops
@onready var bankDeposit: Node = $Main/Interactions/BankDeposit
@onready var travel: Node = $Main/Interactions/Travel
@onready var location: Node = $Main/Location
@onready var growMain: Node = $Main/Interactions/Main/Grow
@onready var growAmountMain: Node = $Main/Interactions/Main/Grow/GrowAmountMain
@onready var affordLabel: Node = $Main/Interactions/Main/Grow/GrowAmountMain/AffordLabel
@onready var selectGrow: Node = $Main/Interactions/Main/Grow/SelectGrow
@onready var growAmount: Node = $Main/Interactions/Main/Grow/GrowAmountMain/Quantity/GrowAmount
@onready var numberToGrow: Node = $Main/Interactions/Main/Grow/GrowAmountMain/Quantity/NumberToGrow
@onready var sellMainNode: Node = $Main/Interactions/Main/Sell
@onready var selectSell: Node = $Main/Interactions/Main/Sell/SelectSell
@onready var sellMain: Node = $Main/Interactions/Main/Sell/SellAmountMain
@onready var sellAmount: Node = $Main/Interactions/Main/Sell/SellAmountMain/Quantity/SellAmount
@onready var numberToSell: Node = $Main/Interactions/Main/Sell/SellAmountMain/Quantity/NumberToSell

#Crop Holdings
@onready var totalCrops: int = 0 #Add up all crops. Add a message indicating max inventory. Use this to calculate and limit purchase qty.
@onready var avocadoHoldings: Node = $Main/CurrentHoldings/Values/Avocados
@onready var avocadoFarm: Node = $Main/MyFarm/Values/Avocados
@onready var tomatoHoldings: Node = $Main/CurrentHoldings/Values/Tomatoes
@onready var tomatoFarm: Node = $Main/MyFarm/Values/Tomatoes
@onready var potatoHoldings: Node = $Main/CurrentHoldings/Values/Potatoes
@onready var potatoFarm: Node = $Main/MyFarm/Values/Potatoes
@onready var cucumberHoldings: Node = $Main/CurrentHoldings/Values/Cucumbers
@onready var cucumberFarm: Node = $Main/MyFarm/Values/Cucumbers
@onready var garlicHoldings: Node = $Main/CurrentHoldings/Values/Garlic
@onready var garlicFarm: Node = $Main/MyFarm/Values/Garlic
@onready var lettuceHoldings: Node = $Main/CurrentHoldings/Values/Lettuce
@onready var lettuceFarm: Node = $Main/MyFarm/Values/Lettuce

#Cities
@onready var littleTon: String = "          Littleton"
@onready var ruralPlateau: String = "   Rural Plateau"
@onready var bigCity: String = "             Big  City"
@onready var mountainVille: String = "Mountain Ville"
@onready var desertVista: String = "     Desert Vista"
@onready var techValley: String = "       Tech Valley"

#Cheap Prices
@onready var randomOffer
@onready var crazyCheapTag = $Main/Interactions/CheapPrices/CrazyCheapTag

#Crop Prices
@onready var avocadoPriceLabel: Node = $Main/Interactions/Main/LeftCropsBox/LeftPrices/AvocadosPrice
@onready var tomatoPriceLabel: Node = $Main/Interactions/Main/LeftCropsBox/LeftPrices/TomatoesPrice
@onready var potatoPriceLabel: Node = $Main/Interactions/Main/LeftCropsBox/LeftPrices/PotatoesPrice
@onready var cucumberPriceLabel: Node = $Main/Interactions/Main/RightCropsBox/RightPrices/CucumbersPrice
@onready var garlicPriceLabel: Node = $Main/Interactions/Main/RightCropsBox/RightPrices/GarlicPrice
@onready var lettucePriceLabel: Node = $Main/Interactions/Main/RightCropsBox/RightPrices/LettucePrice
@onready var avocadoPrice: int = 500
@onready var tomatoPrice: int = 500
@onready var potatoPrice: int = 300
@onready var cucumberPrice: int = 250
@onready var garlicPrice: int = 100
@onready var lettucePrice: int = 50

#Money Stuff
@onready var playerCashLabel: Node = $Main/CurrentHoldings/CashValue
@onready var playerCash: int = 2500
@onready var loanValue: int = 15000
@onready var affordValue: int = 0

#Carats
@onready var titleCaratBlink: Node = $TitleScreen/TitleCaratBlink
@onready var instructionCaratBlink: Node = $Instructions/InstructionCaratBlink

#Tracking
@onready var isLoanPaid: bool = false
@onready var alreadyPoppedUp: bool = false
@onready var growSelected: bool = false
@onready var sellSelected: bool = false

func _ready() -> void:
	titleCaratBlink.play("CaratBlink")

func _process(_delta: float) -> void:
	match currentMenu:
		MenuLevel.Title:
			if Input.is_action_just_pressed("y"):
				currentMenu = MenuLevel.Instructions
				instructionCaratBlink.play("CaratBlink")
			elif Input.is_action_just_pressed("n"):
				currentMenu = MenuLevel.PopUp
				bankLoan.visible = true

		MenuLevel.Instructions:
			titleScreen.visible = false
			instructions.visible = true
			if Input.is_action_just_pressed("any"):
				currentMenu = MenuLevel.PopUp
				bankLoan.visible = true

		MenuLevel.PopUp:
			titleScreen.visible = false
			instructions.visible = false
			main.visible = true
			popUpInteractions()
		
		MenuLevel.CheapPrices:
			cheapPricesFunc()

		MenuLevel.Main:
			mainInteraction()
		
		MenuLevel.Travel:
			changeLocation()
		
		MenuLevel.Grow:
			growCrops()
		
		MenuLevel.Sell:
			sellCrops()

func _on_title_carat_blink_animation_finished(_anim_name: StringName) -> void:
	titleCaratBlink.play("CaratBlink")
func _on_instruction_carat_blink_animation_finished(_anim_name: StringName) -> void:
	instructionCaratBlink.play("CaratBlink")

func popUpInteractions():
	if bankDeposit.visible && !transferCrops.visible && !bankLoan.visible:
		if Input.is_action_just_pressed("y"):
			print("Give option to now pay off the loan")
		elif Input.is_action_just_pressed("n"):
			currentMenu = MenuLevel.CheapPrices
			mainMain.visible = true
			bankDeposit.visible = false
	if !bankLoan.visible && transferCrops.visible && !bankDeposit.visible:
		if Input.is_action_just_pressed("y"):
			print("Give option to now transfer crops to farm")
		elif Input.is_action_just_pressed("n"):
			transferCrops.visible = false
			bankDeposit.visible = true
	if bankLoan.visible && !transferCrops.visible && !bankDeposit.visible && !isLoanPaid:
		if Input.is_action_just_pressed("y"):
			print("Give option to deposit money in the bank")
		elif Input.is_action_just_pressed("n"):
			bankLoan.visible = false
			transferCrops.visible = true

func cheapPricesFunc():
	if !alreadyPoppedUp:
		alreadyPoppedUp = true
		mainMain.visible = false
		cheapPrices.visible = true
		var random = randi_range(1, 3)
		if random == 1:
			print("Offer a random cheap price")
			randomOffer = randi_range(1, 6)
			if randomOffer == 1:
				crazyCheapTag.text = "AVOCADOS" + crazyCheapTag.text
				avocadoPrice /= 2
			if randomOffer == 2:
				crazyCheapTag.text = "TOMATOES" + crazyCheapTag.text
				tomatoPrice /= 2
			if randomOffer == 3:
				crazyCheapTag.text = "POTATOES" + crazyCheapTag.text
				potatoPrice /= 2
			if randomOffer == 4:
				crazyCheapTag.text = "CUCUMBERS" + crazyCheapTag.text
				cucumberPrice /= 2
			if randomOffer == 5:
				crazyCheapTag.text = "GARLIC" + crazyCheapTag.text
				garlicPrice /= 2
			if randomOffer == 6:
				crazyCheapTag.text = "LETTUCE" + crazyCheapTag.text
				lettucePrice /= 2
		elif random == 2:
			currentMenu = MenuLevel.Main
			cheapPrices.visible = false
			mainMain.visible = true
		elif random == 3:
			currentMenu = MenuLevel.Main
			cheapPrices.visible = false
			mainMain.visible = true
	if Input.is_action_just_pressed("any"):
		crazyCheapTag.text = " ARE SELLING FOR CRAZY CHEAP!"
		cheapPrices.visible = false
		mainMain.visible = true
		currentMenu = MenuLevel.Main

func changeLocation():
	alreadyPoppedUp = false
	if Input.is_action_just_pressed("l"):
		littletonPrices()
		location.text = littleTon
		currentMenu = MenuLevel.CheapPrices
		cheapPrices.visible = true
		travel.visible = false
	if Input.is_action_just_pressed("r"):
		ruralPlateauPrices()
		location.text = ruralPlateau
		currentMenu = MenuLevel.CheapPrices
		cheapPrices.visible = true
		travel.visible = false
	if Input.is_action_just_pressed("b"):
		bigCityPrices()
		location.text = bigCity
		currentMenu = MenuLevel.CheapPrices
		cheapPrices.visible = true
		travel.visible = false
	if Input.is_action_just_pressed("m"):
		mountainVillePrices()
		location.text = mountainVille
		currentMenu = MenuLevel.CheapPrices
		cheapPrices.visible = true
		travel.visible = false
	if Input.is_action_just_pressed("d"):
		desertVistaPrices()
		location.text = desertVista
		currentMenu = MenuLevel.CheapPrices
		cheapPrices.visible = true
		travel.visible = false
	if Input.is_action_just_pressed("t"):
		techValleyPrices()
		location.text = techValley
		currentMenu = MenuLevel.CheapPrices
		cheapPrices.visible = true
		travel.visible = false

func mainInteraction():
	setLabels()
	if Input.is_action_just_pressed("g"):
		growMain.visible = true
		selectGrow.visible = true
		currentMenu = MenuLevel.Grow
	if Input.is_action_just_pressed("s"):
		sellMainNode.visible = true
		selectSell.visible = true
		currentMenu = MenuLevel.Sell
	if Input.is_action_just_pressed("l"):
		mainMain.visible = false
		travel.visible = true
		currentMenu = MenuLevel.Travel

func growSellToMain():
	sellMainNode.visible = false
	sellMain.visible = false
	sellSelected = false
	growAmountMain.visible = false
	growMain.visible = false
	growSelected = false
	affordLabel.text = ""
	numberToGrow.text = ""
	numberToSell.text = ""
	currentMenu = MenuLevel.Main

func sellCrops():
	if !sellSelected:
		numberToSell.grab_focus()
		if Input.is_action_just_pressed("a"):
			currentCrop = Crops.Avocado
			sellSelected = true
			selectSell.visible = false
			sellMain.visible = true
			sellAmount.text = "HOW MANY AVOCADOS WOULD YOU LIKE TO SELL?"
		if Input.is_action_just_pressed("t"):
			currentCrop = Crops.Tomato
			sellSelected = true
			selectSell.visible = false
			sellMain.visible = true
			sellAmount.text = "HOW MANY TOMATOES WOULD YOU LIKE TO SELL?"
		if Input.is_action_just_pressed("p"):
			currentCrop = Crops.Potato
			sellSelected = true
			selectSell.visible = false
			sellMain.visible = true
			sellAmount.text = "HOW MANY POTATOES WOULD YOU LIKE TO SELL?"
		if Input.is_action_just_pressed("c"):
			currentCrop = Crops.Cucumber
			sellSelected = true
			selectSell.visible = false
			sellMain.visible = true
			sellAmount.text = "HOW MANY CUCUMBERS WOULD YOU LIKE TO SELL?"
		if Input.is_action_just_pressed("g"):
			currentCrop = Crops.Garlic
			sellSelected = true
			selectSell.visible = false
			sellMain.visible = true
			sellAmount.text = "HOW MUCH GARLIC WOULD YOU LIKE TO SELL?"
		if Input.is_action_just_pressed("l"):
			currentCrop = Crops.Lettuce
			sellSelected = true
			selectSell.visible = false
			sellMain.visible = true
			sellAmount.text = "HOW MUCH LETTUCE WOULD YOU LIKE TO SELL?"
	if sellSelected:
		if Input.is_action_just_pressed("enter"):
			match currentCrop:
				Crops.Avocado:
					if int(avocadoHoldings.text) >= int(numberToSell.text):
						var sellValue = int(numberToSell.text) * avocadoPrice
						playerCash = playerCash + sellValue
						playerCashLabel.text = str(playerCash)
						var sellResult = int(avocadoHoldings.text) - int(numberToSell.text)
						avocadoHoldings.text = str(sellResult)
						growSellToMain()
				Crops.Tomato:
					if int(tomatoHoldings.text) >= int(numberToSell.text):
						var sellValue = int(numberToSell.text) * tomatoPrice
						playerCash = playerCash + sellValue
						playerCashLabel.text = str(playerCash)
						var sellResult = int(tomatoHoldings.text) - int(numberToSell.text)
						tomatoHoldings.text = str(sellResult)
						growSellToMain()
				Crops.Potato:
					if int(potatoHoldings.text) >= int(numberToSell.text):
						var sellValue = int(numberToSell.text) * potatoPrice
						playerCash = playerCash + sellValue
						playerCashLabel.text = str(playerCash)
						var sellResult = int(potatoHoldings.text) - int(numberToSell.text)
						potatoHoldings.text = str(sellResult)
						growSellToMain()
				Crops.Cucumber:
					if int(cucumberHoldings.text) >= int(numberToSell.text):
						var sellValue = int(numberToSell.text) * cucumberPrice
						playerCash = playerCash + sellValue
						playerCashLabel.text = str(playerCash)
						var sellResult = int(cucumberHoldings.text) - int(numberToSell.text)
						cucumberHoldings.text = str(sellResult)
						growSellToMain()
				Crops.Garlic:
					if int(garlicHoldings.text) >= int(numberToSell.text):
						var sellValue = int(numberToSell.text) * garlicPrice
						playerCash = playerCash + sellValue
						playerCashLabel.text = str(playerCash)
						var sellResult = int(garlicHoldings.text) - int(numberToSell.text)
						garlicHoldings.text = str(sellResult)
						growSellToMain()
				Crops.Lettuce:
					if int(lettuceHoldings.text) >= int(numberToSell.text):
						var sellValue = int(numberToSell.text) * lettucePrice
						playerCash = playerCash + sellValue
						playerCashLabel.text = str(playerCash)
						var sellResult = int(lettuceHoldings.text) - int(numberToSell.text)
						lettuceHoldings.text = str(sellResult)
						growSellToMain()

func growCrops():
	if !growSelected:
		if Input.is_action_just_pressed("a"):
			currentCrop = Crops.Avocado
			growSelected = true
			selectGrow.visible = false
			growAmountMain.visible = true
			@warning_ignore("integer_division")
			affordValue = int(playerCash) / int(avocadoPrice)
			affordLabel.text = "(" + str(affordValue) + ")"
			growAmount.text = "HOW MANY AVOCADOS WOULD YOU LIKE TO GROW?"
		if Input.is_action_just_pressed("t"):
			currentCrop = Crops.Tomato
			growSelected = true
			selectGrow.visible = false
			growAmountMain.visible = true
			@warning_ignore("integer_division")
			affordValue = int(playerCash) / int(tomatoPrice)
			affordLabel.text = "(" + str(affordValue) + ")"
			growAmount.text = "HOW MANY TOMATOES WOULD YOU LIKE TO GROW?"
		if Input.is_action_just_pressed("p"):
			currentCrop = Crops.Potato
			growSelected = true
			selectGrow.visible = false
			growAmountMain.visible = true
			@warning_ignore("integer_division")
			affordValue = int(playerCash) / int(potatoPrice)
			affordLabel.text = "(" + str(affordValue) + ")"
			growAmount.text = "HOW MANY POTATOES WOULD YOU LIKE TO GROW?"
		if Input.is_action_just_pressed("c"):
			currentCrop = Crops.Cucumber
			growSelected = true
			selectGrow.visible = false
			growAmountMain.visible = true
			@warning_ignore("integer_division")
			affordValue = int(playerCash) / int(cucumberPrice)
			affordLabel.text = "(" + str(affordValue) + ")"
			growAmount.text = "HOW MANY CUCUMBERS WOULD YOU LIKE TO GROW?"
		if Input.is_action_just_pressed("g"):
			currentCrop = Crops.Garlic
			growSelected = true
			selectGrow.visible = false
			growAmountMain.visible = true
			@warning_ignore("integer_division")
			affordValue = int(playerCash) / int(garlicPrice)
			affordLabel.text = "(" + str(affordValue) + ")"
			growAmount.text = "HOW MUCH GARLIC WOULD YOU LIKE TO GROW?"
		if Input.is_action_just_pressed("l"):
			currentCrop = Crops.Lettuce
			growSelected = true
			selectGrow.visible = false
			growAmountMain.visible = true
			@warning_ignore("integer_division")
			affordValue = int(playerCash) / int(lettucePrice)
			affordLabel.text = "(" + str(affordValue) + ")"
			growAmount.text = "HOW MUCH LETTUCE WOULD YOU LIKE TO GROW?"
	if growSelected:
		#Handle player input to type number of crops here
		match currentCrop:
			Crops.Avocado:
				numberToGrow.grab_focus()
				if Input.is_action_just_pressed("enter"):
					var requestAmount = numberToGrow.text
					if int(requestAmount) <= int(affordValue):
						var updateHoldings = int(avocadoHoldings.text) + int(requestAmount)
						avocadoHoldings.text = str(updateHoldings)
						var purchaseCost = int(requestAmount) * int(avocadoPrice)
						var updateCash = int(playerCash) - int(purchaseCost)
						playerCashLabel.text = str(updateCash)
						playerCash = updateCash
						growSellToMain()
					elif int(requestAmount) >= int(affordValue):
						growSellToMain()
			Crops.Tomato:
				numberToGrow.grab_focus()
				if Input.is_action_just_pressed("enter"):
					var requestAmount = numberToGrow.text
					if int(requestAmount) <= int(affordValue):
						var updateHoldings = int(tomatoHoldings.text) + int(requestAmount)
						tomatoHoldings.text = str(updateHoldings)
						var purchaseCost = int(requestAmount) * int(tomatoPrice)
						var updateCash = int(playerCash) - int(purchaseCost)
						playerCashLabel.text = str(updateCash)
						playerCash = updateCash
						growSellToMain()
					elif int(requestAmount) >= int(affordValue):
						growSellToMain()
			Crops.Potato:
				numberToGrow.grab_focus()
				if Input.is_action_just_pressed("enter"):
					var requestAmount = numberToGrow.text
					if int(requestAmount) <= int(affordValue):
						var updateHoldings = int(potatoHoldings.text) + int(requestAmount)
						potatoHoldings.text = str(updateHoldings)
						var purchaseCost = int(requestAmount) * int(potatoPrice)
						var updateCash = int(playerCash) - int(purchaseCost)
						playerCashLabel.text = str(updateCash)
						playerCash = updateCash
						growSellToMain()
					elif int(requestAmount) >= int(affordValue):
						growSellToMain()
			Crops.Cucumber:
				numberToGrow.grab_focus()
				if Input.is_action_just_pressed("enter"):
					var requestAmount = numberToGrow.text
					if int(requestAmount) <= int(affordValue):
						var updateHoldings = int(cucumberHoldings.text) + int(requestAmount)
						cucumberHoldings.text = str(updateHoldings)
						var purchaseCost = int(requestAmount) * int(cucumberPrice)
						var updateCash = int(playerCash) - int(purchaseCost)
						playerCashLabel.text = str(updateCash)
						playerCash = updateCash
						growSellToMain()
					elif int(requestAmount) >= int(affordValue):
						growSellToMain()
			Crops.Garlic:
				numberToGrow.grab_focus()
				if Input.is_action_just_pressed("enter"):
					var requestAmount = numberToGrow.text
					if int(requestAmount) <= int(affordValue):
						var updateHoldings = int(garlicHoldings.text) + int(requestAmount)
						garlicHoldings.text = str(updateHoldings)
						var purchaseCost = int(requestAmount) * int(garlicPrice)
						var updateCash = int(playerCash) - int(purchaseCost)
						playerCashLabel.text = str(updateCash)
						playerCash = updateCash
						growSellToMain()
					elif int(requestAmount) >= int(affordValue):
						growSellToMain()
			Crops.Lettuce:
				numberToGrow.grab_focus()
				if Input.is_action_just_pressed("enter"):
					var requestAmount = numberToGrow.text
					if int(requestAmount) <= int(affordValue):
						var updateHoldings = int(lettuceHoldings.text) + int(requestAmount)
						lettuceHoldings.text = str(updateHoldings)
						var purchaseCost = int(requestAmount) * int(lettucePrice)
						var updateCash = int(playerCash) - int(purchaseCost)
						playerCashLabel.text = str(updateCash)
						playerCash = updateCash
						growSellToMain()
					elif int(requestAmount) >= int(affordValue):
						growSellToMain()

func setLabels():
	avocadoPriceLabel.text = str(avocadoPrice)
	tomatoPriceLabel.text = str(tomatoPrice)
	potatoPriceLabel.text = str(potatoPrice)
	cucumberPriceLabel.text = str(cucumberPrice)
	garlicPriceLabel.text = str(garlicPrice)
	lettucePriceLabel.text = str(lettucePrice)

func littletonPrices():
	avocadoPrice = 500
	tomatoPrice = 425
	potatoPrice = 225
	cucumberPrice = 150
	garlicPrice = 75
	lettucePrice = 20
func ruralPlateauPrices():
	avocadoPrice = 675
	tomatoPrice = 575
	potatoPrice = 300
	cucumberPrice = 225
	garlicPrice = 125
	lettucePrice = 30
func bigCityPrices():
	avocadoPrice = 750
	tomatoPrice = 650
	potatoPrice = 375
	cucumberPrice = 300
	garlicPrice = 175
	lettucePrice = 40
func mountainVillePrices():
	avocadoPrice = 800
	tomatoPrice = 750
	potatoPrice = 425
	cucumberPrice = 350
	garlicPrice = 225
	lettucePrice = 50
func desertVistaPrices():
	avocadoPrice = 950
	tomatoPrice = 825
	potatoPrice = 500
	cucumberPrice = 400
	garlicPrice = 250
	lettucePrice = 60
func techValleyPrices():
	avocadoPrice = 1000
	tomatoPrice = 900
	potatoPrice = 600
	cucumberPrice = 475
	garlicPrice = 300
	lettucePrice = 75

func addUpCrops():
	var holding1 = int(avocadoHoldings.text) + int(tomatoHoldings.text) + int(potatoHoldings.text)
	var holding2 = int(cucumberHoldings.text) + int(garlicHoldings.text) + int(lettuceHoldings.text)
	var holdingTotal = holding1 + holding2
	totalCrops = totalCrops + holdingTotal
