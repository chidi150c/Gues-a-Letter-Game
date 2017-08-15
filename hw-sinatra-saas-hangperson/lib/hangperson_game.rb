class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  attr_accessor :word, :guesses, :wrong_guesses

  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
  end
  
  def guess letter
    raise ArgumentError if letter.nil?
    raise ArgumentError if letter.size == 0
    raise ArgumentError unless letter.match(/[a-zA-Z]/)
  
    @word.downcase!
    letter.downcase!
    if  @guesses.include?(letter) || @wrong_guesses.include?(letter)
      return false 
    end
  
    if @word.include? letter
      @guesses << letter
      return true
    else
      @wrong_guesses << letter
      return true
    end
   
  end 
 
  def check_win_or_lose
     #which returns one of the symbol `:win`, `:lose`, or `:play` depending on 
    #the current game state
   
      return :win if @word == word_with_guesses
      return :lose if @wrong_guesses.length >= 7
      :play 
  end
  
 
  def word_with_guesses
    #which substitutes the correct guesses made so far
    #into the word.
     return @word.gsub(/[^(#{@guesses})]/, '-') 
  end
 

 
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
end
