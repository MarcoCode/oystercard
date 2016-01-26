require 'oystercard'

  describe OysterCard do 

	subject(:card) { described_class.new }	

  describe '#balance' do 
    
		it 'displays a balance of zero when card is new' do 
		
    expect(card.balance).to eq 0

		end
   end

	describe '#top_up' do 

  	it 'allows user to top up' do
		card.top_up(5)
		expect(card.balance).to eq 5 

		end
    
    it 'does not allow negative amounts' do 
    expect { card.top_up(-2) }.to raise_error "Does not accept negative amounts"
      
    end
    
    it "has a £#{OysterCard::MAX_AMOUNT} limit on top ups" do
      card.top_up(OysterCard::MAX_AMOUNT)
      expect { card.top_up(1) }.to raise_error "You have reached £#{OysterCard::MAX_AMOUNT}"
    end
	end
  
  describe '#deduct' do
    
    it 'deducts a fare from the card' do
      card.top_up 50
      expect{ card.deduct 21}.to change{ card.balance }.by -21
    end
  end
  
  describe '#touch_in' do
    
    it 'updates the in_journey? status to true' do
      card.top_up(2)
      card.touch_in("")
      expect(card).to be_in_journey 
    end

    it "raises an error if the current balance is less than £#{OysterCard::MIN_AMOUNT}" do
      expect{ card.touch_in("") }.to raise_error "Insufficient balance - Minimum required: £#{OysterCard::MIN_AMOUNT}"
    end 
  end
  
  describe '#in-journey' do
    
    it 'should have an initial status of false' do
      
      expect(card).not_to be_in_journey
    end
  end
  
  describe '#touch_out' do
    
    it 'updates the in_journey status to false' do
      card.top_up(2)
      card.touch_in("")
      card.touch_out("")
      expect(card).not_to be_in_journey
   end
  end
  
  
end




