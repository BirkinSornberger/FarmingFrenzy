extends Control

#Enum selectors
enum MenuLevel {Title, Instructions, PopUp, CheapPrices, VanUpgrade, LossEvent, Travel, Grow, Sell, Withdraw, BankLoan, TransferCrops, BankDeposit, Main, GameOver}
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
@onready var outOfSpace: Node = $Main/Interactions/Main/Grow/OutOfSpace
@onready var withdraw: Node = $Main/Interactions/Main/Withdraw
@onready var selectWithdraw: Node = $Main/Interactions/Main/Withdraw/SelectWithdraw
@onready var withdrawCropsMain: Node = $Main/Interactions/Main/Withdraw/Crop
@onready var withdrawMoneyMain: Node = $Main/Interactions/Main/Withdraw/Money
@onready var withdrawSelectCrop: Node = $Main/Interactions/Main/Withdraw/Crop/SelectCrop
@onready var withdrawCropContainer: Node = $Main/Interactions/Main/Withdraw/Crop/Quantity
@onready var withdrawCropAmount: Node = $Main/Interactions/Main/Withdraw/Crop/Quantity/CropsWithdraw
@onready var withdrawCropLabel: Node = $Main/Interactions/Main/Withdraw/Crop/Quantity/CropAmount
@onready var withdrawMoneyLabel: Node = $Main/Interactions/Main/Withdraw/Money/Quantity/MoneyAmount
@onready var withdrawMoneyAmount: Node = $Main/Interactions/Main/Withdraw/Money/Quantity/MoneyWithdraw
@onready var lossEvent: Node = $Main/Interactions/LossEvent
@onready var lossEventTag: Node = $Main/Interactions/LossEvent/LossEventTag
@onready var vanCapacityLabel: Node = $Main/Inventory/CapacityLabel
@onready var vanUpgrade: Node = $Main/Interactions/VanUpgrade
@onready var vanUpgradePrompt: Node = $Main/Interactions/VanUpgrade/UpgradePrompt
@onready var dayValue: Node = $Main/DayCount/Value
@onready var gameOverNode: Node = $GameOver
@onready var scoreValue: Node = $GameOver/ScoreValue
@onready var gameOverAnimator: Node = $GameOver/GameOverAnimator
@onready var gameOverValue: Node = $GameOver/Value

#Crop Holdings
@onready var inventorySpace: int = 50
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
@onready var avocadoInt = int(avocadoHoldings.text)
@onready var tomatoInt = int(tomatoHoldings.text)
@onready var potatoInt = int(potatoHoldings.text)
@onready var cucumberInt = int(cucumberHoldings.text)
@onready var garlicInt = int(garlicHoldings.text)
@onready var lettuceInt = int(lettuceHoldings.text)

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

#Tracking
@onready var isLoanPaid: bool = false
@onready var alreadyPoppedUp: bool = false
@onready var growSelected: bool = false
@onready var sellSelected: bool = false
@onready var cropSelected: bool = false
@onready var selectedCrop = null
@onready var outOfSpaceVar = false
@onready var withdrawSelected = false
@onready var selectCrop = false
@onready var selectMoney = false
@onready var toggled = false
@onready var colorSelector = false
@onready var selectedColor
@onready var vanUpgradeVar = false
@onready var textColorSelector = false
@onready var dayValueVar: bool = false
@onready var dayValueInt: int = 0

func _process(_delta: float) -> void:
	if dayValueInt == 31:
		currentMenu = MenuLevel.GameOver
	if colorSelector:
		selectedColor = $ChangeColor/ColorPicker.color
		$ChangeColor/ColorRect.color = selectedColor
		frameColors()
	if textColorSelector:
		selectedColor = $ChangeColor/ColorPicker.color
		$ChangeColor/ColorRect.color = selectedColor
		textColor()

	match currentMenu:
		MenuLevel.Title:
			if Input.is_action_just_pressed("y"):
				currentMenu = MenuLevel.Instructions
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
			if dayValueVar:
				dayValueVar = false
				dayValueInt += 1
				dayValue.text = str(dayValueInt)
			mainInteraction()
		
		MenuLevel.Travel:
			changeLocation()
		
		MenuLevel.Grow:
			growCrops()
		
		MenuLevel.Sell:
			sellCrops()
		
		MenuLevel.Withdraw:
			withdrawFunc()
		
		MenuLevel.BankLoan:
			bankLoanFunc()
		
		MenuLevel.TransferCrops:
			transferCropsFunc()
		
		MenuLevel.BankDeposit:
			bankDepositFunc()
		
		MenuLevel.GameOver:
			$GameOver/GameOverAnimator.play("GameOver")
			main.visible = false
			gameOverNode.visible = true
			var score = playerCash + int(bankValueLabel.text)
			scoreValue.text = str(score)
			if score >= 1000000:
				gameOverValue.text = "YOU   WIN!"
			elif score < 1000000:
				gameOverValue.text = "YOU   LOST!"

		MenuLevel.VanUpgrade:
			if vanUpgradeVar:
				if Input.is_action_just_pressed("any"):
					vanUpgradePrompt.text = "WOULD  YOU   LIKE  TO  UPGRADE  YOUR  VAN  STORAGE  FOR  1000?"
					vanUpgradeVar = false
					mainMain.visible = true
					vanUpgrade.visible = false
					dayValueVar = true
					currentMenu = MenuLevel.Main
			if !vanUpgradeVar:
				if Input.is_action_just_pressed("y"):
					if playerCash >= 1000:
						inventorySpace += 10
						playerCash -= 1000
						playerCashLabel.text = str(playerCash)
						vanCapacityLabel.text = str(inventorySpace)
						mainMain.visible = true
						vanUpgrade.visible = false
						dayValueVar = true
						currentMenu = MenuLevel.Main
					elif playerCash < 1000:
						vanUpgradePrompt.text = "YOU CANNOT AFFORD THIS UPGRADE!"
						vanUpgradeVar = true
				if Input.is_action_just_pressed("n"):
					vanUpgradeVar = false
					mainMain.visible = true
					vanUpgrade.visible = false
					dayValueVar = true
					currentMenu = MenuLevel.Main

func withdrawFunc():
	if withdrawSelected:
		if selectCrop:
			selectWithdraw.visible = false
			if Input.is_action_just_pressed("a"):
				currentCrop = Crops.Avocado
				selectCrop = false
				withdrawCropContainer.visible = true
				withdrawCropAmount.grab_focus()
				withdrawCropLabel.text += " AVOCADOS?"
			if Input.is_action_just_pressed("t"):
				currentCrop = Crops.Tomato
				selectCrop = false
				withdrawCropContainer.visible = true
				withdrawCropAmount.grab_focus()
				withdrawCropLabel.text += " TOMATOES?"
			if Input.is_action_just_pressed("p"):
				currentCrop = Crops.Potato
				selectCrop = false
				withdrawCropContainer.visible = true
				withdrawCropAmount.grab_focus()
				withdrawCropLabel.text += " POTATOES?"
			if Input.is_action_just_pressed("c"):
				currentCrop = Crops.Cucumber
				selectCrop = false
				withdrawCropContainer.visible = true
				withdrawCropAmount.grab_focus()
				withdrawCropLabel.text += " CUCUMBERS?"
			if Input.is_action_just_pressed("g"):
				currentCrop = Crops.Garlic
				selectCrop = false
				withdrawCropContainer.visible = true
				withdrawCropAmount.grab_focus()
				withdrawCropLabel.text += " GARLIC?"
			if Input.is_action_just_pressed("l"):
				currentCrop = Crops.Avocado
				selectCrop = false
				withdrawCropContainer.visible = true
				withdrawCropAmount.grab_focus()
				withdrawCropLabel.text += " LETTUCE?"
		if !selectCrop:
			if Input.is_action_just_pressed("enter"):
				match currentCrop:
					Crops.Avocado:
						if int(withdrawCropAmount.text) <= int(avocadoFarm.text):
							var avocadoFarmInt = int(avocadoFarm.text)
							avocadoInt += int(withdrawCropAmount.text)
							avocadoFarmInt -= int(withdrawCropAmount.text)
							avocadoFarm.text = str(avocadoFarmInt)
							avocadoHoldings.text = str(avocadoInt)
							withdrawCropAmount.text = ""
					Crops.Tomato:
						if int(withdrawCropAmount.text) <= int(tomatoFarm.text):
							var tomatoFarmInt = int(tomatoFarm.text)
							tomatoInt += int(withdrawCropAmount.text)
							tomatoFarmInt -= int(withdrawCropAmount.text)
							tomatoFarm.text = str(tomatoFarmInt)
							tomatoHoldings.text = str(tomatoInt)
							withdrawCropAmount.text = ""
					Crops.Potato:
						if int(withdrawCropAmount.text) <= int(potatoFarm.text):
							var potatoFarmInt = int(potatoFarm.text)
							potatoInt += int(withdrawCropAmount.text)
							potatoFarmInt -= int(withdrawCropAmount.text)
							potatoFarm.text = str(potatoFarmInt)
							potatoHoldings.text = str(potatoInt)
							withdrawCropAmount.text = ""
					Crops.Cucumber:
						if int(withdrawCropAmount.text) <= int(cucumberFarm.text):
							var cucumberFarmInt = int(cucumberFarm.text)
							cucumberInt += int(withdrawCropAmount.text)
							cucumberFarmInt -= int(withdrawCropAmount.text)
							cucumberFarm.text = str(cucumberFarmInt)
							cucumberHoldings.text = str(cucumberInt)
							withdrawCropAmount.text = ""
					Crops.Garlic:
						if int(withdrawCropAmount.text) <= int(garlicFarm.text):
							var garlicFarmInt = int(garlicFarm.text)
							garlicInt += int(withdrawCropAmount.text)
							garlicFarmInt -= int(withdrawCropAmount.text)
							garlicFarm.text = str(garlicFarmInt)
							garlicHoldings.text = str(garlicInt)
							withdrawCropAmount.text = ""
					Crops.Lettuce:
						if int(withdrawCropAmount.text) <= int(lettuceFarm.text):
							var lettuceFarmInt = int(lettuceFarm.text)
							lettuceInt += int(withdrawCropAmount.text)
							lettuceFarmInt -= int(withdrawCropAmount.text)
							lettuceFarm.text = str(lettuceFarmInt)
							lettuceHoldings.text = str(lettuceInt)
							withdrawCropAmount.text = ""
				withdrawCropAmount.text = ""
				withdrawCropLabel.text = "HOW MANY "
				withdrawCropContainer.visible = false
				selectedCrop = Crops.Unselected
				withdrawSelected = false
				withdraw.visible = false
				withdrawCropsMain.visible = false
				withdrawMoneyMain.visible = false
				dayValueVar = true
				currentMenu = MenuLevel.Main
				mainMain.visible = true
	if !withdrawSelected:
		if Input.is_action_just_pressed("c"):
			withdrawCropsMain.visible = true
			withdrawSelected = true
			selectCrop = true
		if Input.is_action_just_pressed("m"):
			withdrawMoneyMain.visible = true
			withdrawSelected = true
			selectMoney = true
		if selectMoney:
			selectWithdraw.visible = false
			withdrawMoneyAmount.grab_focus()
			var intMoney = int(withdrawMoneyAmount.text)
			var intBank = int(bankValueLabel.text)
			if Input.is_action_just_pressed("enter"):
				if intBank >= intMoney:
					intBank = intBank - intMoney
					bankValueLabel.text = str(intBank)
					withdraw.visible = false
					withdrawMoneyMain.visible = false
					withdrawSelected = false
					selectMoney = false
					withdrawMoneyAmount.text = ""
					cheapPrices.visible = true
					alreadyPoppedUp = false
					currentMenu = MenuLevel.CheapPrices
				else:
					withdraw.visible = false
					withdrawMoneyMain.visible = false
					withdrawSelected = false
					selectMoney = false
					withdrawMoneyAmount.text = ""
					cheapPrices.visible = true
					alreadyPoppedUp = false
					currentMenu = MenuLevel.CheapPrices

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
		if playerCash > intLoan && intLoan <= loanValue:
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
			if int(loanValueLabel.text) == 0:
				isLoanPaid = true
		if playerCash > intLoan && intLoan >= loanValue:
			playerCash -= intLoan
			playerCash += intLoan - loanValue
			loanValue = 0
			loanValueLabel.text = str(loanValue)
			playerCashLabel.text = str(playerCash)
			isLoanPaid = true
			bankLoan.visible = false
			transferCrops.visible = true
			loanDepositAmount.text = ""
			loanDeposit.visible = true
			loanDepositConfirm.visible = false
			currentMenu = MenuLevel.PopUp
		if playerCash > intLoan && intLoan == loanValue:
			playerCash -= intLoan
			loanValue = 0
			loanValueLabel.text = str(loanValue)
			playerCashLabel.text = str(playerCash)
			isLoanPaid = true
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
		var random = randi_range(1, 8)
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
			randomOffer = randi_range(1, 6)
			if randomOffer == 1:
				crazyCheapTag.text = "AVOCADOS ARE SELLING FOR INSANE PRICES!"
				@warning_ignore("narrowing_conversion")
				avocadoPrice *= 1.5
			if randomOffer == 2:
				crazyCheapTag.text = "TOMATOES ARE SELLING FOR INSANE PRICES!"
				@warning_ignore("narrowing_conversion")
				tomatoPrice *= 1.5
			if randomOffer == 3:
				crazyCheapTag.text = "POTATOES ARE SELLING FOR INSANE PRICES!"
				@warning_ignore("narrowing_conversion")
				potatoPrice *= 1.5
			if randomOffer == 4:
				crazyCheapTag.text = "CUCUMBERS ARE SELLING FOR INSANE PRICES!"
				@warning_ignore("narrowing_conversion")
				cucumberPrice *= 1.5
			if randomOffer == 5:
				crazyCheapTag.text = "GARLIC IS SELLING FOR INSANE PRICES!"
				@warning_ignore("narrowing_conversion")
				garlicPrice *= 1.5
			if randomOffer == 6:
				crazyCheapTag.text = "LETTUCE IS SELLING FOR INSANE PRICES!"
				@warning_ignore("narrowing_conversion")
				lettucePrice *= 1.5
		elif random == 3:
			cheapPrices.visible = false
			lossEvent.visible = true
			randomOffer = randi_range(1, 6)
			if randomOffer == 1:
				lossEventTag.text = "You crashed your van and lost some crops!"
				mediumLoss()
			if randomOffer == 2:
				lossEventTag.text = "A rival farmer stole a bunch of your crops!"
				mediumLoss()
			if randomOffer == 3:
				lossEventTag.text = "Some of your crops spoiled and had to be thrown out!"
				largeLoss()
			if randomOffer == 4:
				lossEventTag.text = "A storm flooded your fields and some crops were washed away!"
				smallLoss()
			if randomOffer == 5:
				lossEventTag.text = "Pests got into your crops and destroyed them!"
				largeLoss()
			if randomOffer == 6:
				lossEventTag.text = "A cold front moved in and froze some of your crops!"
				smallLoss()
			updateHoldings()
		elif random == 4:
			cheapPrices.visible = false
			vanUpgrade.visible = true
			alreadyPoppedUp = false
			currentMenu = MenuLevel.VanUpgrade
		elif random == 5 or 6 or 7 or 8:
			dayValueVar = true
			currentMenu = MenuLevel.Main
			cheapPrices.visible = false
			mainMain.visible = true
	if Input.is_action_just_pressed("any"):
		lossEventTag.text = ""
		crazyCheapTag.text = " ARE SELLING FOR CRAZY CHEAP!"
		lossEvent.visible = false
		cheapPrices.visible = false
		mainMain.visible = true
		alreadyPoppedUp = false
		dayValueVar = true
		currentMenu = MenuLevel.Main

func updateHoldings():
	avocadoHoldings.text = str(avocadoInt)
	tomatoHoldings.text = str(tomatoInt)
	potatoHoldings.text = str(potatoInt)
	cucumberHoldings.text = str(cucumberInt)
	garlicHoldings.text = str(garlicInt)
	lettuceHoldings.text = str(lettuceInt)

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
	if Input.is_action_just_pressed("w"):
		withdraw.visible = true
		selectWithdraw.visible = true
		currentMenu = MenuLevel.Withdraw

func growSellToMain():
	outOfSpaceVar = false
	sellMainNode.visible = false
	sellMain.visible = false
	sellSelected = false
	growAmountMain.visible = false
	growMain.visible = false
	growSelected = false
	affordLabel.text = ""
	numberToGrow.text = ""
	numberToSell.text = ""
	dayValueVar = true
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
					else:
						growSellToMain()
				Crops.Tomato:
					if int(tomatoHoldings.text) >= int(numberToSell.text):
						var sellValue = int(numberToSell.text) * tomatoPrice
						playerCash = playerCash + sellValue
						playerCashLabel.text = str(playerCash)
						var sellResult = int(tomatoHoldings.text) - int(numberToSell.text)
						tomatoHoldings.text = str(sellResult)
						growSellToMain()
					else:
						growSellToMain()
				Crops.Potato:
					if int(potatoHoldings.text) >= int(numberToSell.text):
						var sellValue = int(numberToSell.text) * potatoPrice
						playerCash = playerCash + sellValue
						playerCashLabel.text = str(playerCash)
						var sellResult = int(potatoHoldings.text) - int(numberToSell.text)
						potatoHoldings.text = str(sellResult)
						growSellToMain()
					else:
						growSellToMain()
				Crops.Cucumber:
					if int(cucumberHoldings.text) >= int(numberToSell.text):
						var sellValue = int(numberToSell.text) * cucumberPrice
						playerCash = playerCash + sellValue
						playerCashLabel.text = str(playerCash)
						var sellResult = int(cucumberHoldings.text) - int(numberToSell.text)
						cucumberHoldings.text = str(sellResult)
						growSellToMain()
					else:
						growSellToMain()
				Crops.Garlic:
					if int(garlicHoldings.text) >= int(numberToSell.text):
						var sellValue = int(numberToSell.text) * garlicPrice
						playerCash = playerCash + sellValue
						playerCashLabel.text = str(playerCash)
						var sellResult = int(garlicHoldings.text) - int(numberToSell.text)
						garlicHoldings.text = str(sellResult)
						growSellToMain()
					else:
						growSellToMain()
				Crops.Lettuce:
					if int(lettuceHoldings.text) >= int(numberToSell.text):
						var sellValue = int(numberToSell.text) * lettucePrice
						playerCash = playerCash + sellValue
						playerCashLabel.text = str(playerCash)
						var sellResult = int(lettuceHoldings.text) - int(numberToSell.text)
						lettuceHoldings.text = str(sellResult)
						growSellToMain()
					else:
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
			addUpCrops()
			var requestAmount = numberToGrow.text
			if int(requestAmount) <= int(affordValue) && inventorySpace >= int(requestAmount) + totalCrops:
				match currentCrop:
					Crops.Avocado:
						var updateHoldingsVal = int(avocadoHoldings.text) + int(requestAmount)
						avocadoHoldings.text = str(updateHoldingsVal)
						var purchaseCost = int(requestAmount) * int(avocadoPrice)
						var updateCash = int(playerCash) - int(purchaseCost)
						playerCashLabel.text = str(updateCash)
						playerCash = updateCash
						growSellToMain()
					Crops.Tomato:
						var updateHoldingsVal = int(tomatoHoldings.text) + int(requestAmount)
						tomatoHoldings.text = str(updateHoldingsVal)
						var purchaseCost = int(requestAmount) * int(tomatoPrice)
						var updateCash = int(playerCash) - int(purchaseCost)
						playerCashLabel.text = str(updateCash)
						playerCash = updateCash
						growSellToMain()
					Crops.Potato:
						var updateHoldingsVal = int(potatoHoldings.text) + int(requestAmount)
						potatoHoldings.text = str(updateHoldingsVal)
						var purchaseCost = int(requestAmount) * int(potatoPrice)
						var updateCash = int(playerCash) - int(purchaseCost)
						playerCashLabel.text = str(updateCash)
						playerCash = updateCash
						growSellToMain()
					Crops.Cucumber:
						var updateHoldingsVal = int(cucumberHoldings.text) + int(requestAmount)
						cucumberHoldings.text = str(updateHoldingsVal)
						var purchaseCost = int(requestAmount) * int(cucumberPrice)
						var updateCash = int(playerCash) - int(purchaseCost)
						playerCashLabel.text = str(updateCash)
						playerCash = updateCash
						growSellToMain()
					Crops.Garlic:
						var updateHoldingsVal = int(garlicHoldings.text) + int(requestAmount)
						garlicHoldings.text = str(updateHoldingsVal)
						var purchaseCost = int(requestAmount) * int(garlicPrice)
						var updateCash = int(playerCash) - int(purchaseCost)
						playerCashLabel.text = str(updateCash)
						playerCash = updateCash
						growSellToMain()
					Crops.Lettuce:
						var updateHoldingsVal = int(lettuceHoldings.text) + int(requestAmount)
						lettuceHoldings.text = str(updateHoldingsVal)
						var purchaseCost = int(requestAmount) * int(lettucePrice)
						var updateCash = int(playerCash) - int(purchaseCost)
						playerCashLabel.text = str(updateCash)
						playerCash = updateCash
						growSellToMain()
			elif inventorySpace <= int(requestAmount) + totalCrops:
				outOfSpaceVar = true
				outOfSpace.visible = true
				growAmountMain.visible = false
	if outOfSpaceVar:
		if Input.is_action_just_pressed("any"):
			outOfSpace.visible = false
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

func smallLoss():
	avocadoInt *= 0.9
	tomatoInt *= 0.9
	potatoInt *= 0.9
	cucumberInt *= 0.9
	garlicInt *= 0.9
	lettuceInt *= 0.9

func mediumLoss():
	avocadoInt *= 0.8
	tomatoInt *= 0.8
	potatoInt *= 0.8
	cucumberInt *= 0.8
	garlicInt *= 0.8
	lettuceInt *= 0.8

func largeLoss():
	avocadoInt *= 0.7
	tomatoInt *= 0.7
	potatoInt *= 0.7
	cucumberInt *= 0.7
	garlicInt *= 0.7
	lettuceInt *= 0.7

func addUpCrops():
	totalCrops = 0
	var holding1 = 0
	var holding2 = 0
	var holdingTotal = 0
	holding1 = int(avocadoHoldings.text) + int(tomatoHoldings.text) + int(potatoHoldings.text)
	holding2 = int(cucumberHoldings.text) + int(garlicHoldings.text) + int(lettuceHoldings.text)
	holdingTotal = holding1 + holding2
	totalCrops = totalCrops + holdingTotal

func frameColors():
	$Main/Frame/Bottom.color = selectedColor
	$Main/Frame/Top.color = selectedColor
	$Main/Frame/BottomLeft.color = selectedColor
	$Main/Frame/BottomRight.color = selectedColor
	$Main/Frame/LeftLeft.color = selectedColor
	$Main/Frame/Left.color = selectedColor
	$Main/Frame/RightRight.color = selectedColor
	$Main/Frame/Right.color = selectedColor
	$Main/Frame/CenterLeft.color = selectedColor
	$Main/Frame/CenterRight.color = selectedColor
	$Main/Frame/TopRight.color = selectedColor
	$Main/Frame/TopLeft.color = selectedColor
	$Main/Frame/TopMiddleBottom.color = selectedColor
	$Main/Frame/TopMiddleTop.color = selectedColor
	$Main/Frame/TopMiddleLeft.color = selectedColor
	$Main/Frame/TopMiddleRight.color = selectedColor
	$Main/Frame/TopLeftLeft.color = selectedColor
	$Main/Frame/TopLeftRight.color = selectedColor
	$Main/Frame/TopLeftBottom.color = selectedColor
	$Main/Frame/TopLeftTop.color = selectedColor
	$Main/Frame/TopRightLeft.color = selectedColor
	$Main/Frame/TopRightRight.color = selectedColor
	$Main/Frame/TopRightTop.color = selectedColor
	$Main/Frame/TopRightBottom.color = selectedColor
	$GameOver/LeaderboardMain/LeftWall.color = selectedColor
	$GameOver/LeaderboardMain/RightWall.color = selectedColor
	$GameOver/LeaderboardMain/TopWall.color = selectedColor
	$GameOver/LeaderboardMain/BottomWall.color = selectedColor
	$GameOver/LeaderboardMain/Underline.color = selectedColor
	$GameOver/LeaderboardMain/CenterDivider.color = selectedColor

func textColor():
	$Main/Inventory/VanCapacity.add_theme_color_override("default_color", selectedColor)
	$Main/Inventory/CapacityLabel.add_theme_color_override("default_color", selectedColor)
	$Main/MyFarm/Title.add_theme_color_override("default_color", selectedColor)
	$Main/MyFarm/FarmCrops/Avocados.add_theme_color_override("default_color", selectedColor)
	$Main/MyFarm/FarmCrops/Tomatoes.add_theme_color_override("default_color", selectedColor)
	$Main/MyFarm/FarmCrops/Potatoes.add_theme_color_override("default_color", selectedColor)
	$Main/MyFarm/FarmCrops/Cucumbers.add_theme_color_override("default_color", selectedColor)
	$Main/MyFarm/FarmCrops/Garlic.add_theme_color_override("default_color", selectedColor)
	$Main/MyFarm/FarmCrops/Lettuce.add_theme_color_override("default_color", selectedColor)
	$Main/MyFarm/Values/Avocados.add_theme_color_override("default_color", selectedColor)
	$Main/MyFarm/Values/Tomatoes.add_theme_color_override("default_color", selectedColor)
	$Main/MyFarm/Values/Potatoes.add_theme_color_override("default_color", selectedColor)
	$Main/MyFarm/Values/Cucumbers.add_theme_color_override("default_color", selectedColor)
	$Main/MyFarm/Values/Garlic.add_theme_color_override("default_color", selectedColor)
	$Main/MyFarm/Values/Lettuce.add_theme_color_override("default_color", selectedColor)
	$Main/MyFarm/Bank.add_theme_color_override("default_color", selectedColor)
	$Main/MyFarm/BankValue.add_theme_color_override("default_color", selectedColor)
	$Main/MyFarm/Loan.add_theme_color_override("default_color", selectedColor)
	$Main/MyFarm/LoanValue.add_theme_color_override("default_color", selectedColor)
	$Main/CurrentHoldings/Title.add_theme_color_override("default_color", selectedColor)
	$Main/CurrentHoldings/Holdings/Avocados.add_theme_color_override("default_color", selectedColor)
	$Main/CurrentHoldings/Holdings/Tomatoes.add_theme_color_override("default_color", selectedColor)
	$Main/CurrentHoldings/Holdings/Potatoes.add_theme_color_override("default_color", selectedColor)
	$Main/CurrentHoldings/Holdings/Cucumbers.add_theme_color_override("default_color", selectedColor)
	$Main/CurrentHoldings/Holdings/Garlic.add_theme_color_override("default_color", selectedColor)
	$Main/CurrentHoldings/Holdings/Lettuce.add_theme_color_override("default_color", selectedColor)
	$Main/CurrentHoldings/Values/Avocados.add_theme_color_override("default_color", selectedColor)
	$Main/CurrentHoldings/Values/Tomatoes.add_theme_color_override("default_color", selectedColor)
	$Main/CurrentHoldings/Values/Potatoes.add_theme_color_override("default_color", selectedColor)
	$Main/CurrentHoldings/Values/Cucumbers.add_theme_color_override("default_color", selectedColor)
	$Main/CurrentHoldings/Values/Garlic.add_theme_color_override("default_color", selectedColor)
	$Main/CurrentHoldings/Values/Lettuce.add_theme_color_override("default_color", selectedColor)
	$Main/CurrentHoldings/Cash.add_theme_color_override("default_color", selectedColor)
	$Main/CurrentHoldings/CashValue.add_theme_color_override("default_color", selectedColor)
	$Main/Location.add_theme_color_override("default_color", selectedColor)
	$Main/Interactions/Main/Sell/SelectSell.add_theme_color_override("default_color", selectedColor)
	$Main/Interactions/Main/Sell/SellAmountMain/Quantity/SellAmount.add_theme_color_override("default_color", selectedColor)
	$Main/Interactions/Main/Sell/SellAmountMain/Quantity/NumberToSell.add_theme_color_override("font_color", selectedColor)
	$Main/Interactions/Main/Grow/SelectGrow.add_theme_color_override("default_color", selectedColor)
	$Main/Interactions/Main/Grow/OutOfSpace.add_theme_color_override("default_color", selectedColor)
	$Main/Interactions/Main/Grow/GrowAmountMain/Quantity/GrowAmount.add_theme_color_override("default_color", selectedColor)
	$Main/Interactions/Main/Grow/GrowAmountMain/AffordAmount.add_theme_color_override("default_color", selectedColor)
	$Main/Interactions/Main/Grow/GrowAmountMain/AffordLabel.add_theme_color_override("default_color", selectedColor)
	$Main/Interactions/Main/Grow/GrowAmountMain/SelectGrow.add_theme_color_override("default_color", selectedColor)
	$Main/Interactions/Main/Grow/GrowAmountMain/Quantity/NumberToGrow.add_theme_color_override("font_color", selectedColor)
	$Main/Interactions/Main/Withdraw/SelectWithdraw.add_theme_color_override("default_color", selectedColor)
	$Main/Interactions/Main/Withdraw/Crop/SelectCrop.add_theme_color_override("default_color", selectedColor)
	$Main/Interactions/Main/Withdraw/Crop/Quantity/CropAmount.add_theme_color_override("default_color", selectedColor)
	$Main/Interactions/Main/Withdraw/Money/Quantity/MoneyAmount.add_theme_color_override("default_color", selectedColor)
	$Main/Interactions/Main/Withdraw/Crop/Quantity/CropsWithdraw.add_theme_color_override("font_color", selectedColor)
	$Main/Interactions/Main/Withdraw/Money/Quantity/MoneyWithdraw.add_theme_color_override("font_color", selectedColor)
	$Main/Interactions/Main/CropPrices.add_theme_color_override("default_color", selectedColor)
	$Main/Interactions/Main/LeftCropsBox/LeftCrops/Avocados.add_theme_color_override("default_color", selectedColor)
	$Main/Interactions/Main/LeftCropsBox/LeftCrops/Tomatoes.add_theme_color_override("default_color", selectedColor)
	$Main/Interactions/Main/LeftCropsBox/LeftCrops/Potatoes.add_theme_color_override("default_color", selectedColor)
	$Main/Interactions/Main/LeftCropsBox/LeftPrices/AvocadosPrice.add_theme_color_override("default_color", selectedColor)
	$Main/Interactions/Main/LeftCropsBox/LeftPrices/TomatoesPrice.add_theme_color_override("default_color", selectedColor)
	$Main/Interactions/Main/LeftCropsBox/LeftPrices/PotatoesPrice.add_theme_color_override("default_color", selectedColor)
	$Main/Interactions/Main/RightCropsBox/RightCrops/Cucumbers.add_theme_color_override("default_color", selectedColor)
	$Main/Interactions/Main/RightCropsBox/RightCrops/Garlic.add_theme_color_override("default_color", selectedColor)
	$Main/Interactions/Main/RightCropsBox/RightCrops/Lettuce.add_theme_color_override("default_color", selectedColor)
	$Main/Interactions/Main/RightCropsBox/RightPrices/CucumbersPrice.add_theme_color_override("default_color", selectedColor)
	$Main/Interactions/Main/RightCropsBox/RightPrices/GarlicPrice.add_theme_color_override("default_color", selectedColor)
	$Main/Interactions/Main/RightCropsBox/RightPrices/LettucePrice.add_theme_color_override("default_color", selectedColor)
	$Main/Interactions/Main/Selection.add_theme_color_override("default_color", selectedColor)
	$Main/Interactions/CheapPrices/CrazyCheapTag.add_theme_color_override("default_color", selectedColor)
	$Main/Interactions/BankLoan/LoanDeposit.add_theme_color_override("default_color", selectedColor)
	$Main/Interactions/BankLoan/LoanDepositConfirm.add_theme_color_override("default_color", selectedColor)
	$Main/Interactions/BankLoan/LoanDepositAmount.add_theme_color_override("font_color", selectedColor)
	$Main/Interactions/TransferCrops/CropTransfer.add_theme_color_override("default_color", selectedColor)
	$Main/Interactions/TransferCrops/CropTransferConfirm.add_theme_color_override("default_color", selectedColor)
	$Main/Interactions/TransferCrops/CropTransferNumber.add_theme_color_override("default_color", selectedColor)
	$Main/Interactions/TransferCrops/CropTransferAmount.add_theme_color_override("font_color", selectedColor)
	$Main/Interactions/BankDeposit/BankDeposit.add_theme_color_override("default_color", selectedColor)
	$Main/Interactions/BankDeposit/BankDepositConfirm.add_theme_color_override("default_color", selectedColor)
	$Main/Interactions/BankDeposit/BankDepositAmount.add_theme_color_override("font_color", selectedColor)
	$Main/Interactions/Travel/SelectCity.add_theme_color_override("default_color", selectedColor)
	$Main/Interactions/Travel/CitiesBox/LeftCities/Littleton.add_theme_color_override("default_color", selectedColor)
	$Main/Interactions/Travel/CitiesBox/LeftCities/RuralPlateau.add_theme_color_override("default_color", selectedColor)
	$Main/Interactions/Travel/CitiesBox/LeftCities/BigCity.add_theme_color_override("default_color", selectedColor)
	$Main/Interactions/Travel/CitiesBox/RightCities/MountainVille.add_theme_color_override("default_color", selectedColor)
	$Main/Interactions/Travel/CitiesBox/RightCities/DesertVista.add_theme_color_override("default_color", selectedColor)
	$Main/Interactions/Travel/CitiesBox/RightCities/TechValley.add_theme_color_override("default_color", selectedColor)
	$Main/Interactions/LossEvent/LossEventTag.add_theme_color_override("default_color", selectedColor)
	$Main/Interactions/VanUpgrade/UpgradePrompt.add_theme_color_override("default_color", selectedColor)
	$Main/DayCount/Day.add_theme_color_override("default_color", selectedColor)
	$Main/DayCount/Value.add_theme_color_override("default_color", selectedColor)
	$Main/DayCount/OutOf.add_theme_color_override("default_color", selectedColor)
	$GameOver/Title.add_theme_color_override("default_color", selectedColor)
	$GameOver/ScoreDialog1.add_theme_color_override("default_color", selectedColor)
	$GameOver/ScoreDialo2.add_theme_color_override("default_color", selectedColor)
	$GameOver/ScoreValue.add_theme_color_override("default_color", selectedColor)
	$GameOver/LeaderboardMain/LeaderboardTitle.add_theme_color_override("default_color", selectedColor)
	$GameOver/LeaderboardMain/Leaderboard/Names/Name1.add_theme_color_override("default_color", selectedColor)
	$GameOver/LeaderboardMain/Leaderboard/Names/Name2.add_theme_color_override("default_color", selectedColor)
	$GameOver/LeaderboardMain/Leaderboard/Names/Name3.add_theme_color_override("default_color", selectedColor)
	$GameOver/LeaderboardMain/Leaderboard/Names/Name4.add_theme_color_override("default_color", selectedColor)
	$GameOver/LeaderboardMain/Leaderboard/Names/Name5.add_theme_color_override("default_color", selectedColor)
	$GameOver/LeaderboardMain/Leaderboard/Scores/Score1.add_theme_color_override("default_color", selectedColor)
	$GameOver/LeaderboardMain/Leaderboard/Scores/Score2.add_theme_color_override("default_color", selectedColor)
	$GameOver/LeaderboardMain/Leaderboard/Scores/Score3.add_theme_color_override("default_color", selectedColor)
	$GameOver/LeaderboardMain/Leaderboard/Scores/Score4.add_theme_color_override("default_color", selectedColor)
	$GameOver/LeaderboardMain/Leaderboard/Scores/Score5.add_theme_color_override("default_color", selectedColor)

func _on_ui_color_toggled(toggled_on: bool) -> void:
	if toggled_on:
		$ChangeColor/ColorRect.visible = true
		$ChangeColor/ColorPicker.visible = true
		$ChangeColor/TextColor.disabled = true
		colorSelector = true
	if !toggled_on:
		$ChangeColor/ColorRect.visible = false
		$ChangeColor/ColorPicker.visible = false
		$ChangeColor/TextColor.disabled = false
		colorSelector = false

func _on_text_color_toggled(toggled_on: bool) -> void:
	if toggled_on:
		$ChangeColor/ColorRect.visible = true
		$ChangeColor/ColorPicker.visible = true
		$ChangeColor/UIColor.disabled = true
		textColorSelector = true

	if !toggled_on:
		$ChangeColor/ColorRect.visible = false
		$ChangeColor/ColorPicker.visible = false
		$ChangeColor/UIColor.disabled = false
		textColorSelector = false

func _on_game_over_animator_animation_finished(anim_name: StringName) -> void:
	$GameOver/GameOverAnimator.play("GameOver")
