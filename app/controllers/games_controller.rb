require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
    @letters << ('A'..'Z').to_a.sample
    end
  end

  def score
    @message = ''
    @user_input = params[:word]
    @letters = params[:letters]
    url = "https://wagon-dictionary.herokuapp.com/#{@user_input}"
    word_serialized = URI.open(url).read
    word = JSON.parse(word_serialized)
    if word["found"] && @user_input.upcase.chars.all? { |letter| @user_input.upcase.count(letter) <= @letters.count(letter) }
      @message = "nice one, #{@user_input} is a valid english word"
    elsif @user_input.upcase.chars.all? { |letter| @user_input.upcase.count(letter) <= @letters.count(letter) }
      @message = "#{@user_input} is not a valid english word"
    else
      @message = "#{@user_input} is not in #{@letters}"
    end
  end
end
