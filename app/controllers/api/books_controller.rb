class Api::BooksController < ApplicationController
  def test_action
    @message = "Hello!"
    render "test.json.jb"
  end
end
