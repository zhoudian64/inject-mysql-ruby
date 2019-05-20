# frozen_string_literal: true

require 'sinatra'
require 'grape'
require 'mysql2'


class MYAPI < Grape::API
  format :json

  params do
    optional :name, type: String
    optional :password, type: String
  end
  post :login do
    @password_flag = false
    db = Mysql2::Client.new(host: '127.0.0.1', username: 'root',
                            password: '123456', database: 'homework')
    user_name = params['name']
    password = params['password']
    sql_s = 'SELECT * FROM homework.user WHERE name = "' + user_name + '" AND password = "' + password + '"'
    puts sql_s
    result = db.query sql_s
    result.each do |row|
      @password_flag = true
    end
    db.close
    {'if_password_right' => @password_flag}
  end

  params do
    optional :name, type: String
  end
  post :data do
    db = Mysql2::Client.new(host: '127.0.0.1', username: 'root',
                            password: '123456', database: 'homework')
    user_name = params['name']
    sql_s = 'SELECT * FROM homework.item WHERE user = "' + user_name + '"'
    puts sql_s
    result = db.query sql_s
    @resp = []
    result.each do |row|
      @resp << Hash['name' => row['name'], 'rate' => row['rate'], 'user' => row['user']]
    end
    db.close
    @resp
  end

  params do
    optional :name, type: String
    optional :item, type: String
    optional :rate, type: Integer
  end
  post :insert do
    db = Mysql2::Client.new(host: '127.0.0.1', username: 'root',
                            password: '123456', database: 'homework')
    user_name = params['name']
    item_name = params['item']
    rate = params['rate']
    sql_s = 'INSERT INTO homework.item (name, rate, user) VALUES ("' + item_name + '", ' + rate.to_s + ', "' + user_name + '")'
    puts sql_s
    db.query sql_s
    db.
    db.close
  end
end

class Web < Sinatra::Base
  get '/' do
    'Hello world.'
  end
end

use Rack::Session::Cookie
run Rack::Cascade.new [MYAPI, Web]