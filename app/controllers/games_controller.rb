require 'open-uri'

class GamesController < ApplicationController

  def new
    @new = Array.new(10) { ('A'..'Z').to_a[rand(26)] }.join(" ")
  end

  def score
    @score = params[:guess].upcase
    @new = params[:letters].split
    @test = include?(@new, @score)
    api = open("https://wagon-dictionary.herokuapp.com/#{@score}").read
    json = JSON.parse(api)
    @is_english = json["found"]
    if @is_english == true && @test == true
      @result = 'Your entered word is English and correct.'
    else
      @result = 'Your entered word is NOT valid!'
    end
  end

  private

  def include?(news, score)
    @final = 0
    score.chars.all? do |letter|
      @final += 1
      score.count(letter) <= news.count(letter)
    end
  end
end
