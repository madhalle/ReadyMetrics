#everything commented out is output the user would get. A nice addition, but not necessary!
class VendingMachine
  attr_reader :location, :stock
  def initialize(location)
    @location = location
    @stock = { 1 => {soda: "Pepsi", price: 2.00, quantity: 50},
               2 => {soda: "Coke", price: 1.00, quantity: 50},
               3 => {soda: "Fanta", price: 2.40, quantity: 50},
               4 => {soda: "Sprite", price: 2.30, quantity: 50}
             }
    @money = {5 => 20,
              1 => 100,
              0.25 => 100,
              0.1 => 100,
              0.05 => 100}
    @pressed_number = 0
    @user_payment = 0
  end

  def push_button(button_number)
    @pressed_number = button_number
    # p @stock[button_number][:soda] + ", #{@stock[button_number][:price]}"
    buy_soda
  end

  def buy_soda
   if @user_payment != 0 && @pressed_number !=0
    p @stock[@pressed_number][:soda] if (@stock[@pressed_number][:price] <= @user_payment && @stock[@pressed_number][:quantity] > 0)
    dispense_change
   # elsif @user_payment == 0 &&@pressed_number !=0
   #   "Please insert payment"
   # elsif @user_payment != 0 &&@pressed_number ==0
   #   "Please select soda"
   # else
   #   "Soda is out of stock"
   end
  end

  def insert_money(amount)
    @user_payment += amount
    buy_soda
  end

  def calculated_change
    (@user_payment - @stock[@pressed_number][:price]).round(2)
  end

  def dispense_change
    return_change = Hash.new(0)
    while calculated_change > 0
      @money.each do |money_denomination, quantity|
        if calculated_change/money_denomination >= 1 && quantity > 0
          return_change[money_denomination] += (calculated_change/money_denomination).floor(0)
          quantity -= (calculated_change/money_denomination).floor(0)
          @user_payment -= ((calculated_change/money_denomination).floor(0) * money_denomination)
        elsif quantity == 0
          @money.delete(money_denomination)
        end
      end
    end
    p "Your change is: #{return_change}"
  end
end
