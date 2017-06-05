#!/usr/bin/env ruby

require 'rubygems'
require 'mechanize'
require 'nokogiri'
require 'open-uri'

agent = Mechanize.new
agent.get('http://www.boxorganicos.ufsc.br/') do |page|
  user, password = page.forms.first.fields
  user.value = "USERNAME"
  password.value = "PASSWORD"
  form = page.forms.first
  button = form.buttons.first
  agent.submit(form, button)

  page = page.link_with(text: /pedido/).click
  form = page.link_with(text: /Montar um pedido/).click
  prices = form.body.match(/price.*1550/m)

  #prices.split(" ")
  puts prices[0..3]
  #puts prices.each.map{|values| values.last[1]}


  table = form.search "#products-table"
  table_lines = table[0].children[3].children
  rows = table_lines.select{|e|e.name == "tr"}
  puts rows.each.map{|e,i|[i,e.children[1].children[0]]}

  #priceList.each.map{|values| values.last[1]}

  require 'pry'
  binding.pry
end
