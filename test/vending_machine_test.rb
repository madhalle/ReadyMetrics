require "minitest/autorun"
require "minitest/pride"
require "./lib/vending_machine"

class VendingMachineTest < Minitest::Test
  def setup
    @vm1 = VendingMachine.new("Random Rd.")
  end

  def test_vending_machine_attributes
    expected = {
                1=> {soda: "Pepsi", price: 2.00, quantity: 50},
                2=> {soda: "Coke", price:1.00, quantity: 50},
                3=> {soda: "Fanta", price:2.40, quantity: 50},
                4=> {soda: "Sprite", price:2.30, quantity: 50}
              }
    assert_equal expected, @vm1.stock
  end
  #
  # def test_cant_buy_soda_with_only_button
  #   @vm1.push_button(3)
  #   assert_equal "Please insert payment", @vm1.buy_soda
  # end
  #
  # def test_cant_buy_soda_with_only_money
  #   @vm1.insert_money(6.55)
  #   assert_equal "Please select soda", @vm1.buy_soda
  # end

  def test_dispense_change
    @vm1.push_button(3)

    expected = ("Your change is: {1=>4, 0.1=>1, 0.05=>1}")
    # expected = ({0.25=>16, 0.1=>1, 0.05=>1})
    assert_equal expected, @vm1.insert_money(6.55)
  end
end
