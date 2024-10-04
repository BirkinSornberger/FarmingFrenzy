extends Control

#To do:
#	Finish the core game mechanics
#	Add high price random events
#	Add random major inventory loss events
#	Add random pop ups to buy more inventory space (van upgrades, bigger van?)
#	Add an option to "Withdraw", then in a sub menu choose farm crops or bank money

#Enum selectors
enum MenuLevel {Title, Instructions, PopUp, CheapPrices, Travel, Grow, Sell, BankLoan, TransferCrops, BankDeposit, Main}
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
@onready var loanDepositAmount: Node = $Main/Interactions/BankLoan/LoanDepositAmount
@onready var loanDeposit: Node = $Main/Interactions/BankLoan/LoanDeposit
@onready var loanDepositConfirm: Node = $Main/Interactions/BankLoan/LoanDepositConfirm
@onready var cropTransfer: Node = $Main/Interactions/TransferCrops/CropTransfer
@onready var cropTransferConfirm: Node = $Main/Interactions/TransferCrops/CropTransferConfirm
@onready var cropTransferNumber: Node = $Main/Interactions/TransferCrops/CropTransferNumber
@onready var cropTransferAmount: Node = $Main/Interactions/TransferCrops/CropTransferAmount
@onready var bankDepositMain: Node = $Main/Interactions/BankDeposit/BankDeposit
@onready var bankDepositConfirm: Node = $Main/Interactions/BankDeposit/BankDepositConfirm
@onready var bankDepositAmount: Node = $Main/Interactions/BankDeposit/BankDepositAmount

#Crop Holdings
@onready var inventorySpace: int = 20
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
@onready var bankValueLabel: Node = $Main/MyFarm/BankValue
@onready var playerCashLabel: Node = $Main/CurrentHoldings/CashValue
@onready var loanValueLabel: Node = $Main/MyFarm/LoanValue
@onready var playerCash: int = 2500
@onready var loanValue: int = 15000
@onready var bankValue: int = 0
@onready var affordValue: int = 0

#Carats
@onready var titleCaratBlink: Node = $TitleScreen/TitleCaratBlink
@onready var instructionCaratBlink: Node = $Instructions/InstructionCaratBlink

#Tracking
@onready var isLoanPaid: bool = false
@onready var alreadyPoppedUp: bool = false
@onready var growSelected: bool = false
@onready var sellSelected: bool = false
@onready var cropSelected: bool = false
@onready var selectedCrop = null

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
		
		MenuLevel.BankLoan:
			bankLoanFunc()
		
		MenuLevel.TransferCrops:
			transferCropsFunc()
		
		MenuLevel.BankDeposit:
			bankDepositFunc()

func _on_title_carat_blink_animation_finished(_anim_name: StringName) -> void:
	titleCaratBlink.play("CaratBlink")
func _on_instruction_carat_blink_animation_finished(_anim_name: StringName) -> void:
	instructionCaratBlink.play("CaratBlink")

func cropTransferSwitch():
	cropTransfer.visible = true
	cropTransferConfirm.visible = false
	cropTransferNumber.visible = false
	cropTransferAmount.visible = false
	cropTransferAmount.text = ""

func bankDepositFunc():
	bankDepositMain.visible = false
	bankDepositConfirm.visible = true
	bankDepositAmount.visible = true
	bankDepositAmount.grab_focus()
	var intDeposit = int(bankDepositAmount.text)
	if Input.is_action_just_pressed("enter"):
		if playerCash > intDeposit:
			playerCash -= intDeposit
			bankValue += intDeposit
			bankValueLabel.text = str(bankValue)
			playerCashLabel.text = str(playerCash)
			bankDepositAmount.text = ""
			bankDeposit.visible = false
			bankDepositMain.visible = true
			bankDepositAmount.visible = false
			bankDepositConfirm.visible = false
			cheapPrices.visible = true
			currentMenu = MenuLevel.CheapPrices
		else:
			bankDepositAmount.text = ""

func transferCropsFunc():
	var cropTransferInt = int(cropTransferAmount.text)
	var oneShot = false
	if !cropSelected:
		cropTransfer.visible = false
		cropTransferConfirm.visible = true
		if Input.is_action_just_pressed("a"):
			oneShot = true
			cropSelected = true
			selectedCrop = "a"
		if Input.is_action_just_pressed("t"):
			oneShot = true
			cropSelected = true
			selectedCrop = "t"
		if Input.is_action_just_pressed("p"):
			oneShot = true
			cropSelected = true
			selectedCrop = "p"
		if Input.is_action_just_pressed("c"):
			oneShot = true
			cropSelected = true
			selectedCrop = "c"
		if Input.is_action_just_pressed("g"):
			oneShot = true
			cropSelected = true
			selectedCrop = "g"
		if Input.is_action_just_pressed("l"):
			oneShot = true
			cropSelected = true
			selectedCrop = "l"
	if cropSelected:
		cropTransferNumber.visible = true
		cropTransferAmount.visible = true
		cropTransferAmount.grab_focus()
		if selectedCrop == "a":
			if oneShot:
				cropTransferNumber.text = "HOW MANY AVOCADOS?"
			if Input.is_action_just_pressed("enter"):
				if cropTransferInt <= int(avocadoHoldings.text):
					var valueStore
					valueStore = int(avocadoHoldings.text) - cropTransferInt
					avocadoHoldings.text = str(valueStore)
					valueStore = int(avocadoFarm.text) + cropTransferInt
					avocadoFarm.text = str(valueStore)
					transferCrops.visible = false
					bankDeposit.visible = true
					cropTransferSwitch()
					oneShot = false
					cropSelected = false
					currentMenu = MenuLevel.PopUp
		if selectedCrop == "t":
			if oneShot:
				cropTransferNumber.text = "HOW MANY TOMATOES?"
			if Input.is_action_just_pressed("enter"):
				if cropTransferInt <= int(tomatoHoldings.text):
					var valueStore
					valueStore = int(tomatoHoldings.text) - cropTransferInt
					tomatoHoldings.text = str(valueStore)
					valueStore = int(tomatoFarm.text) + cropTransferInt
					tomatoFarm.text = str(valueStore)
					transferCrops.visible = false
					bankDeposit.visible = true
					cropTransferSwitch()
					oneShot = false
					cropSelected = false
					currentMenu = MenuLevel.PopUp
		if selectedCrop == "p":
			if oneShot:
				cropTransferNumber.text = "HOW MANY POTATOES?"
			if Input.is_action_just_pressed("enter"):
				if cropTransferInt <= int(potatoHoldings.text):
					var valueStore
					valueStore = int(potatoHoldings.text) - cropTransferInt
					potatoHoldings.text = str(valueStore)
					valueStore = int(potatoFarm.text) + cropTransferInt
					potatoFarm.text = str(valueStore)
					transferCrops.visible = false
					bankDeposit.visible = true
					cropTransferSwitch()
					oneShot = false
					cropSelected = false
					currentMenu = MenuLevel.PopUp
		if selectedCrop == "c":
			if oneShot:
				cropTransferNumber.text = "HOW MANY CUCUMBERS?"
			if Input.is_action_just_pressed("enter"):
				if cropTransferInt <= int(cucumberHoldings.text):
					var valueStore
					valueStore = int(cucumberHoldings.text) - cropTransferInt
					cucumberHoldings.text = str(valueStore)
					valueStore = int(cucumberFarm.text) + cropTransferInt
					cucumberFarm.text = str(valueStore)
					transferCrops.visible = false
					bankDeposit.visible = true
					cropTransferSwitch()
					oneShot = false
					cropSelected = false
					currentMenu = MenuLevel.PopUp
		if selectedCrop == "g":
			if oneShot:
				cropTransferNumber.text = "HOW MUCH GARLIC?"
			if Input.is_action_just_pressed("enter"):
				if cropTransferInt <= int(garlicHoldings.text):
					var valueStore
					valueStore = int(garlicHoldings.text) - cropTransferInt
					garlicHoldings.text = str(valueStore)
					valueStore = int(garlicFarm.text) + cropTransferInt
					garlicFarm.text = str(valueStore)
					transferCrops.visible = false
					bankDeposit.visible = true
					cropTransferSwitch()
					oneShot = false
					cropSelected = false
					currentMenu = MenuLevel.PopUp
		if selectedCrop == "l":
			if oneShot:
				cropTransferNumber.text = "HOW MUCH LETTUCE?"
			if Input.is_action_just_pressed("enter"):
				if cropTransferInt <= int(lettuceHoldings.text):
					var valueStore
					valueStore = int(lettuceHoldings.text) - cropTransferInt
					lettuceHoldings.text = str(valueStore)
					valueStore = int(lettuceFarm.text) + cropTransferInt
					lettuceFarm.text = str(valueStore)
					transferCrops.visible = false
					bankDeposit.visible = true
					cropTransferSwitch()
					oneShot = false
					cropSelected = false
					currentMenu = MenuLevel.PopUp

func bankLoanFunc():
	loanDeposit.visible = false
	loanDepositConfirm.visible = true
	loanDepositAmount.visible = true
	loanDepositAmount.grab_focus()
	var intLoan = int(loanDepositAmount.text)
	if Input.is_action_just_pressed("enter"):
		if playerCash > intLoan:
			playerCash -= intLoan
			loanValue -= intLoan
			loanValueLabel.text = str(loanValue)
			playerCashLabel.text = str(playerCash)
			bankLoan.visible = false
			transferCrops.visible = true
			loanDepositAmount.text = ""
			loanDeposit.visible = true
			loanDepositConfirm.visible = false
			currentMenu = MenuLevel.PopUp
		else:
			loanDepositAmount.text = ""

func popUpInteractions():
	if bankDeposit.visible && !transferCrops.visible && !bankLoan.visible:
		if Input.is_action_just_pressed("y"):
			currentMenu = MenuLevel.BankDeposit
		elif Input.is_action_just_pressed("n"):
			mainMain.visible = true
			bankDeposit.visible = false
			currentMenu = MenuLevel.CheapPrices
	if !bankLoan.visible && transferCrops.visible && !bankDeposit.visible:
		if Input.is_action_just_pressed("y"):
			currentMenu = MenuLevel.TransferCrops
		elif Input.is_action_just_pressed("n"):
			transferCrops.visible = false
			bankDeposit.visible = true
	if bankLoan.visible && !transferCrops.visible && !bankDeposit.visible && !isLoanPaid:
		if Input.is_action_just_pressed("y"):
			currentMenu = MenuLevel.BankLoan
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
	var randiResult = randi_range(1, 2)
	alreadyPoppedUp = false
	if Input.is_action_just_pressed("l"):
		littletonPrices()
		location.text = littleTon
		travel.visible = false
		if randiResult == 1:
			bankLoan.visible = true
			currentMenu = MenuLevel.PopUp
		elif randiResult == 2:
			cheapPrices.visible = true
			currentMenu = MenuLevel.CheapPrices
	if Input.is_action_just_pressed("r"):
		ruralPlateauPrices()
		location.text = ruralPlateau
#		cheapPrices.visible = true
		travel.visible = false
		if randiResult == 1:
			bankLoan.visible = true
			currentMenu = MenuLevel.PopUp
		elif randiResult == 2:
			cheapPrices.visible = true
			currentMenu = MenuLevel.CheapPrices
	if Input.is_action_just_pressed("b"):
		bigCityPrices()
		location.text = bigCity
#		cheapPrices.visible = true
		travel.visible = false
		if randiResult == 1:
			bankLoan.visible = true
			currentMenu = MenuLevel.PopUp
		elif randiResult == 2:
			cheapPrices.visible = true
			currentMenu = MenuLevel.CheapPrices
	if Input.is_action_just_pressed("m"):
		mountainVillePrices()
		location.text = mountainVille
#		cheapPrices.visible = true
		travel.visible = false
		if randiResult == 1:
			bankLoan.visible = true
			currentMenu = MenuLevel.PopUp
		elif randiResult == 2:
			cheapPrices.visible = true
			currentMenu = MenuLevel.CheapPrices
	if Input.is_action_just_pressed("d"):
		desertVistaPrices()
		location.text = desertVista
#		cheapPrices.visible = true
		travel.visible = false
		if randiResult == 1:
			bankLoan.visible = true
			currentMenu = MenuLevel.PopUp
		elif randiResult == 2:
			cheapPrices.visible = true
			currentMenu = MenuLevel.CheapPrices
	if Input.is_action_just_pressed("t"):
		techValleyPrices()
		location.text = techValley
#		cheapPrices.visible = true
		travel.visible = false
		if randiResult == 1:
			bankLoan.visible = true
			currentMenu = MenuLevel.PopUp
		elif randiResult == 2:
			cheapPrices.visible = true
			currentMenu = MenuLevel.CheapPrices

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
			addUpCrops()
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
		numberToGrow.grab_focus()
		if Input.is_action_just_pressed("enter"):
			var requestAmount = numberToGrow.text
			if int(requestAmount) <= int(affordValue) && inventorySpace >= int(requestAmount) + totalCrops:
				match currentCrop:
					Crops.Avocado:
						var updateHoldings = int(avocadoHoldings.text) + int(requestAmount)
						avocadoHoldings.text = str(updateHoldings)
						var purchaseCost = int(requestAmount) * int(avocadoPrice)
						var updateCash = int(playerCash) - int(purchaseCost)
						playerCashLabel.text = str(updateCash)
						playerCash = updateCash
						growSellToMain()
					Crops.Tomato:
						var updateHoldings = int(tomatoHoldings.text) + int(requestAmount)
						tomatoHoldings.text = str(updateHoldings)
						var purchaseCost = int(requestAmount) * int(tomatoPrice)
						var updateCash = int(playerCash) - int(purchaseCost)
						playerCashLabel.text = str(updateCash)
						playerCash = updateCash
						growSellToMain()
					Crops.Potato:
						var updateHoldings = int(potatoHoldings.text) + int(requestAmount)
						potatoHoldings.text = str(updateHoldings)
						var purchaseCost = int(requestAmount) * int(potatoPrice)
						var updateCash = int(playerCash) - int(purchaseCost)
						playerCashLabel.text = str(updateCash)
						playerCash = updateCash
						growSellToMain()
					Crops.Cucumber:
						var updateHoldings = int(cucumberHoldings.text) + int(requestAmount)
						cucumberHoldings.text = str(updateHoldings)
						var purchaseCost = int(requestAmount) * int(cucumberPrice)
						var updateCash = int(playerCash) - int(purchaseCost)
						playerCashLabel.text = str(updateCash)
						playerCash = updateCash
						growSellToMain()
					Crops.Garlic:
						var updateHoldings = int(garlicHoldings.text) + int(requestAmount)
						garlicHoldings.text = str(updateHoldings)
						var purchaseCost = int(requestAmount) * int(garlicPrice)
						var updateCash = int(playerCash) - int(purchaseCost)
						playerCashLabel.text = str(updateCash)
						playerCash = updateCash
						growSellToMain()
					Crops.Lettuce:
						var updateHoldings = int(lettuceHoldings.text) + int(requestAmount)
						lettuceHoldings.text = str(updateHoldings)
						var purchaseCost = int(requestAmount) * int(lettucePrice)
						var updateCash = int(playerCash) - int(purchaseCost)
						playerCashLabel.text = str(updateCash)
						playerCash = updateCash
						growSellToMain()
			else:
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
