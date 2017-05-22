#!/usr/bin/env ruby

require 'rubygems'
require 'mechanize'
require 'nokogiri'
require 'open-uri'

agent = Mechanize.new
agent.get('http://www.boxorganicos.ufsc.br/') do |page|
  user, password = page.forms.first.fields
  user.value = "paula"
  password.value = "astolfo08"
  form = page.forms.first
  button = form.buttons.first
  agent.submit(form, button)

  page = page.link_with(text: /pedido/).click
  form = page.link_with(text: /Montar um pedido/).click

  table = form.search "#products-table"
  table_lines = table[0].children[3].children
  rows = table_lines.select{|e|e.name == "tr"}
  puts rows.each.map{|e,i|[i,e.children[1].children[0]]}
  puts rows.each.map{|e,i|[i,e.children[1].children[2]]}

  #puts table.css("td[class='number unitaryValue']")
  priceList.each.map{|values| values.last[1]}
  #puts get_name(priceList)
=begin
  rows.map{|className| (className = 'number unitaryValue') }

  prices = table_lines.select{|e|e.name == "td"}
  puts prices.each.map{|e,i|[i,e[1]]}
=end
  require 'pry'
  binding.pry
end
